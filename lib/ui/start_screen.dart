import 'package:flutter/material.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/ui/country/country_screen.dart';
import 'package:nephrogo/ui/legal/legal_screen.dart';
import 'package:nephrogo/ui/user_profile/user_profile_screen.dart';

import 'authentication/login_screen.dart';
import 'general/app_future_builder.dart';
import 'home_screen.dart';
import 'onboarding/onboarding_screen.dart';

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
      return AppFutureBuilder<bool>(
        future: () => _appPreferences.isCountrySet(),
        builder: (context, isCountrySet) {
          if (!isCountrySet) {
            return const CountryScreen();
          }
          return AppFutureBuilder<bool>(
            future: () => _appPreferences.isOnboardingPassed(),
            builder: (context, isOnboardingPassed) {
              if (isOnboardingPassed) {
                return AppFutureBuilder<bool>(
                  future: () => _appPreferences.isLegalConditionsAgreed(),
                  builder: (context, isLegalConditionsAgreed) {
                    if (isLegalConditionsAgreed) {
                      return LoginScreen();
                    }
                    return LegalScreen(exitType: LegalScreenExitType.login);
                  },
                );
              }
              return const OnboardingScreen(
                exitType: OnboardingScreenExitType.legal,
              );
            },
          );
        },
      );
    }

    return AppFutureBuilder<bool>(
      future: () => _appPreferences.isProfileCreated(),
      builder: (context, isProfileCreated) {
        if (isProfileCreated) {
          return HomeScreen();
        }

        return const UserProfileScreen(
          nextScreenType: UserProfileNextScreenType.homeScreen,
        );
      },
    );
  }
}
