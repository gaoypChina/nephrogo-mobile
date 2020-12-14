import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/routes.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  final _authenticationProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(32, 72, 32, 72),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: FractionallySizedBox(
                  child: Image.asset("assets/logo/logo.png"),
                  widthFactor: 0.8,
                ),
              ),
              SignInButton(
                Buttons.Google,
                text: "Prisijungti su Google",
                onPressed: () => _loginWithGoogle(context),
              ),
              SignInButton(
                Buttons.Facebook,
                text: "Prisijungti su Facebook",
                onPressed: () => _loginWithFacebook(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _loginWithGoogle(BuildContext context) async {
    final userCredential = await _authenticationProvider.signInWithGoogle();

    if (userCredential != null) {
      await openHomeScreen(context, userCredential);
    }
  }

  Future _loginWithFacebook(BuildContext context) async {
    final userCredential = await _authenticationProvider.signInWithFacebook();

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
