import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/ui/user_profile_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/logo/logo-with-title.png',
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
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
          ),
          if (Theme.of(context).platform == TargetPlatform.iOS)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
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
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: SignInButton(
                Buttons.Email,
                padding: const EdgeInsets.all(16),
                text: appLocalizations.registerUsingEmail,
                onPressed: () => _registerAndLoginUsingEmail(context),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 32, 8, 32),
            child: EmailLoginButtonComponent(
              onCredentialsRetrieved: (userCredential) =>
                  navigateToNextScreen(context, userCredential),
            ),
          ),
        ],
      ),
    );
  }

  Future _registerAndLoginUsingEmail(BuildContext context) async {
    final userCredential = await Navigator.pushNamed<UserCredential>(
      context,
      Routes.routeRegistration,
    );

    if (userCredential != null) {
      await navigateToNextScreen(context, userCredential);
    }
  }

  Future _loginWithSocial(
    BuildContext context,
    SocialAuthenticationProvider provider,
  ) async {
    UserCredential userCredential;

    try {
      userCredential = await _authenticationProvider.signIn(provider);
    } on LoginCancelledException {
      developer.log(
        'Login cancelled',
      );
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

class EmailLoginButtonComponent extends StatelessWidget {
  final void Function(UserCredential userCredential) onCredentialsRetrieved;

  const EmailLoginButtonComponent({
    Key key,
    @required this.onCredentialsRetrieved,
  })  : assert(onCredentialsRetrieved != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          appLocalizations.alreadyRegisterWhenLogin,
          style: const TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
              onPressed: () => _onLoginPressed(context),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(width: 2, color: Colors.white),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(appLocalizations.loginEmail.toUpperCase()),
              )),
        )
      ],
    );
  }

  Future _onLoginPressed(BuildContext context) async {
    final userCredential = await Navigator.pushNamed<UserCredential>(
      context,
      Routes.routeLoginEmailPassword,
    );

    if (userCredential != null) {
      onCredentialsRetrieved(userCredential);
    }
  }
}
