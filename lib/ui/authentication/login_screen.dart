import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/preferences/app_preferences.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/general/dialogs.dart';
import 'package:nephrolog/ui/user_profile_screen.dart';

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

class LoginScreenBody extends StatelessWidget {
  final _authenticationProvider = AuthenticationProvider();
  final _apiService = ApiService();
  final _appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 64),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 36),
          child: FractionallySizedBox(
            child: Image.asset("assets/logo/logo-with-title.png"),
            widthFactor: 0.6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SignInButton(
            Buttons.Google,
            padding: const EdgeInsets.all(8),
            text: "Prisijungti su Google",
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
            text: "Prisijungti su Facebook",
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
              text: "Prisijungti su Apple",
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
            text: "Prisijungti su el. paštu",
            onPressed: () => _loginUsingEmail(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: LoginConditionsRichText(),
        ),
      ],
    );
  }

  Future _loginUsingEmail(BuildContext context) async {
    final userCredential = await Navigator.pushNamed<UserCredential>(
      context,
      Routes.ROUTE_LOGIN_EMAIL_PASSWORD,
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
    } catch (e, stacktrace) {
      developer.log(
        "Unable to to to login with social",
        stackTrace: stacktrace,
      );

      await showAppDialog(context: context, message: e.toString());
    }

    if (userCredential != null) {
      await navigateToNextScreen(context, userCredential);
    }
  }

  Future navigateToNextScreen(
      BuildContext context, UserCredential userCredential) async {
    final userProfile = await _apiService.getUserProfile();
    if (userProfile != null) {
      await _appPreferences.setProfileCreated();

      return await Navigator.pushReplacementNamed(
        context,
        Routes.ROUTE_HOME,
      );
    }

    return await Navigator.pushReplacementNamed(
      context,
      Routes.ROUTE_USER_PROFILE,
      arguments: UserProfileNextScreenType.homeScreen,
    );
  }
}
