import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/ui/user_profile_screen.dart';

import 'login_conditions.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(child: LoginScreenBody()),
    );
  }
}

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final _authenticationProvider = AuthenticationProvider();

  final _apiService = ApiService();

  final _appPreferences = AppPreferences();

  bool agreedToConditions = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 64),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 36),
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: Image.asset('assets/logo/logo-with-title.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SignInButton(
            Buttons.Google,
            padding: const EdgeInsets.all(8),
            text: appLocalizations.loginGoogle,
            onPressed: () => _loginWithSocial(
              context,
              SocialAuthenticationProvider.google,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SignInButton(
            Buttons.Facebook,
            padding: const EdgeInsets.all(16),
            text: appLocalizations.loginFacebook,
            onPressed: () => _loginWithSocial(
              context,
              SocialAuthenticationProvider.facebook,
            ),
          ),
        ),
        if (Theme.of(context).platform == TargetPlatform.iOS)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignInButton(
              Buttons.AppleDark,
              padding: const EdgeInsets.all(16),
              text: appLocalizations.loginApple,
              onPressed: () => _loginWithSocial(
                context,
                SocialAuthenticationProvider.apple,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SignInButton(
            Buttons.Email,
            padding: const EdgeInsets.all(16),
            text: appLocalizations.loginEmail,
            onPressed: () => _loginUsingEmail(context),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: LoginConditionsRichText(),
        ),
      ],
    );
  }

  Future<bool> _agreeToConditions() async {
    if (agreedToConditions) {
      return true;
    }

    return agreedToConditions = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: LoginConditionsRichText(
            textColor: Colors.black,
            baseText: appLocalizations.loginConditionsAgree,
            textAlign: TextAlign.start,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(appLocalizations.disagree.toUpperCase()),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(appLocalizations.agree.toUpperCase()),
            ),
          ],
        );
      },
    );
  }

  Future _loginUsingEmail(BuildContext context) async {
    final agreed = await _agreeToConditions();

    if (agreed) {
      final userCredential = await Navigator.pushNamed<UserCredential>(
        context,
        Routes.routeLoginEmailPassword,
      );

      if (userCredential != null) {
        await navigateToNextScreen(context, userCredential);
      }
    }
  }

  Future _loginWithSocial(
    BuildContext context,
    SocialAuthenticationProvider provider,
  ) async {
    final agreed = await _agreeToConditions();

    if (agreed) {
      UserCredential userCredential;

      try {
        userCredential = await _authenticationProvider.signIn(provider);
      } catch (e, stacktrace) {
        developer.log(
          'Unable to to to login with social',
          stackTrace: stacktrace,
          error: e,
        );

        await showAppDialog(context: context, message: e.toString());
      }

      if (userCredential != null) {
        await navigateToNextScreen(context, userCredential);
      }
    }
  }

  Future navigateToNextScreen(
      BuildContext context, UserCredential userCredential) async {
    final userProfile = await ProgressDialog(context)
        .showForFuture(_apiService.getUserProfile());

    if (userProfile != null) {
      await _appPreferences.setProfileCreated();

      return Navigator.pushReplacementNamed(
        context,
        Routes.routeHome,
      );
    }

    return Navigator.pushReplacementNamed(
      context,
      Routes.routeUserProfile,
      arguments: UserProfileNextScreenType.homeScreen,
    );
  }
}
