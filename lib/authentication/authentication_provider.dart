import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nephrolog/preferences/app_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum SocialAuthenticationProvider {
  facebook,
  google,
  apple,
}

abstract class EmailPasswordLoginException implements Exception {}

class InvalidPasswordException extends EmailPasswordLoginException {}

class UserNotFoundException extends EmailPasswordLoginException {}

abstract class RegistrationException implements Exception {}

class EmailAlreadyInUseException extends EmailPasswordLoginException {}

class InvalidEmailException extends EmailPasswordLoginException {}

class WeakPasswordException extends EmailPasswordLoginException {}

class AuthenticationProvider {
  static final AuthenticationProvider _singleton =
      AuthenticationProvider._internal();

  factory AuthenticationProvider() {
    return _singleton;
  }

  AuthenticationProvider._internal();

  final _auth = FirebaseAuth.instance;
  final _appPreferences = AppPreferences();

  User get currentUser => _auth.currentUser;

  bool get isUserLoggedIn => currentUser != null;

  get currentUserPhotoURL {
    final photoURL = _auth.currentUser?.photoURL;
    if (photoURL == null) {
      return null;
    }

    return photoURL.replaceFirst("/s96-c/", "/s300-c/") + "?height=300";
  }

  Future<String> idToken([bool forceRefresh = false]) =>
      currentUser.getIdToken(forceRefresh);

  Future signOut() async {
    await _appPreferences.deleteProfileCreated();
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw InvalidPasswordException();
        default:
          rethrow;
      }
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'weak-password':
          throw WeakPasswordException();
        default:
          rethrow;
      }
    }
  }

  // TODO add Handling for password
  // Adapted from https://firebase.flutter.dev/docs/auth/error-handling
  Future<UserCredential> _linkDifferentProviders(
      FirebaseAuthException authException) async {
    if (authException.code != 'account-exists-with-different-credential') {
      throw ArgumentError.value(
        authException,
        "authException",
        "Can not link different providers, because exception code ${authException.code} is invalid",
      );
    }
    print("Linking ${authException.credential} provider to different provider");

    String email = authException.email;
    AuthCredential pendingCredential = authException.credential;

    // Fetch a list of what sign-in methods exist for the conflicting user
    var userSignInMethods = await _auth.fetchSignInMethodsForEmail(email);
    userSignInMethods =
        userSignInMethods.where((e) => e != 'password').toList();

    OAuthCredential oAuthCredential;
    final method = userSignInMethods.first;
    switch (method) {
      case 'facebook.com':
        oAuthCredential = await _triggerFacebookLogin();
        break;
      case 'google.com':
        oAuthCredential = await _triggerGoogleLogin();
        break;
      case 'apple.com':
        oAuthCredential = await _triggerAppleLogin();
        break;
      default:
        developer.log(
          "Unable to match $method in method for signing",
        );
        throw authException;
    }

    final userCredential = await _auth.signInWithCredential(oAuthCredential);

    // Link the pending credential with the existing account
    return await userCredential.user.linkWithCredential(pendingCredential);
  }

  Future<UserCredential> _signInWithCredential(
      AuthCredential authCredential) async {
    try {
      return await _auth.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return await _linkDifferentProviders(e);
      }
      rethrow;
    }
  }

  Future<OAuthCredential> _triggerGoogleLogin() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser.authentication;

    return GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  Future<UserCredential> signIn(SocialAuthenticationProvider provider) async {
    switch (provider) {
      case SocialAuthenticationProvider.facebook:
        return signInWithFacebook();
      case SocialAuthenticationProvider.google:
        return signInWithGoogle();
      case SocialAuthenticationProvider.apple:
        return signInWithApple();
      default:
        throw ArgumentError.value(provider, "provider",
            "Unable to find specified provider for sign in.");
    }
  }

  // https://firebase.flutter.dev/docs/auth/social
  Future<UserCredential> signInWithGoogle() async {
    final credential = await _triggerGoogleLogin();

    return await _signInWithCredential(credential);
  }

  Future<FacebookAuthCredential> _triggerFacebookLogin() async {
    final result = await FacebookAuth.instance.login();

    return FacebookAuthProvider.credential(result.token);
  }

  // https://firebase.flutter.dev/docs/auth/social
  Future<UserCredential> signInWithFacebook() async {
    final facebookAuthCredential = await _triggerFacebookLogin();

    return await _signInWithCredential(facebookAuthCredential);
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<OAuthCredential> _triggerAppleLogin() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    return OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
  }

  // https://firebase.flutter.dev/docs/auth/social#apple
  Future<UserCredential> signInWithApple() async {
    final oauthCredential = await _triggerAppleLogin();

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await _signInWithCredential(oauthCredential);
  }
}
