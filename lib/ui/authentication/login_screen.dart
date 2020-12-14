import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/constants.dart';
import 'package:nephrolog/routes.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoginScreenBody(),
    );
  }
}

class LoginScreenBody extends StatelessWidget {
  final _authenticationProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 64),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: FractionallySizedBox(
                  child: Image.asset("assets/logo/square-logo.png"),
                  widthFactor: 0.7,
                ),
              ),
            ),
            SignInButton(
              Buttons.Google,
              text: "Prisijungti su Google",
              onPressed: () => _loginWithSocial(
                context,
                SocialAuthenticationProvider.google,
              ),
            ),
            SignInButton(
              Buttons.Facebook,
              text: "Prisijungti su Facebook",
              onPressed: () => _loginWithSocial(
                context,
                SocialAuthenticationProvider.facebook,
              ),
            ),
            SignInButton(
              Buttons.AppleDark,
              text: "Prisijungti su Apple",
              onPressed: () => _loginWithSocial(
                context,
                SocialAuthenticationProvider.apple,
              ),
            ),
            SignInButton(
              Buttons.Email,
              text: "Prisijungti su el. paštu",
              onPressed: () => _loginWithSocial(
                context,
                SocialAuthenticationProvider.google,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: LoginConditionsRichText(),
            ),
          ],
        ),
      ),
    );
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

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    if (userCredential != null) {
      await openHomeScreen(context, userCredential);
    }
  }

  Future openHomeScreen(BuildContext context, UserCredential userCredential) {
    return Navigator.pushReplacementNamed(
      context,
      Routes.ROUTE_HOME,
    );
  }
}

class LoginConditionsRichText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: "Prisijungdami Jūs patvirtinate, kad sutinkate su\n",
        ),
        TextSpan(
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
          text: "Privatumo poltika",
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Constants.privacyPolicyUrl),
        ),
        TextSpan(text: " ir "),
        TextSpan(
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
          text: "Naudojimosi taisyklėmis",
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Constants.rulesUrl),
        ),
      ]),
    );
  }

  Future launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
