import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/ui/general/app_logo.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  final _authenticationProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 32, 16, 64),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignInButton(
                Buttons.Google,
                text: "Prisijungti su Google",
                onPressed: _loginWithGoogle,
              ),
              SignInButton(
                Buttons.Facebook,
                text: "Prisijungti su Facebook",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _loginWithGoogle() async {
    await _authenticationProvider.signInWithGoogle();
  }
}
