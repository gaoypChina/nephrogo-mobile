import 'package:flutter/material.dart';
import 'package:nephrolog/authentication/authentication_provider.dart';
import 'package:nephrolog/preferences/app_preferences.dart';
import 'package:nephrolog/ui/user_profile_screen.dart';

import 'authentication/login_screen.dart';
import 'general/app_future_builder.dart';
import 'home_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _authenticationProvider = AuthenticationProvider();
  final _appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    if (!_authenticationProvider.isUserLoggedIn) {
      return LoginScreen();
    }

    return AppFutureBuilder(
      future: _appPreferences.isProfileCreated(),
      builder: (context, isProfileCreated) {
        if (isProfileCreated) {
          return HomeScreen();
        }

        return UserProfileScreen(
          nextScreenType: UserProfileNextScreenType.homeScreen,
        );
      },
    );
  }
}
