import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';

import 'authentication/login_screen.dart';
import 'home_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _authenticationProvider = AuthenticationProvider();

  @override
  Widget build(BuildContext context) {
    if (!_authenticationProvider.isUserLoggedIn) {
      return LoginScreen();
    }

    return HomeScreen();
  }
}
