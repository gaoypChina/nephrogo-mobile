import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/ui/authentication/email_password_login_screen.dart';

import 'ui/authentication/login_screen.dart';
import 'ui/authentication/registration_screen.dart';
import 'ui/authentication/remind_password.dart';
import 'ui/faq_screen.dart';
import 'ui/home_screen.dart';
import 'ui/start_screen.dart';
import 'ui/tabs/health_indicators/weekly_health_indicators_screen.dart';
import 'ui/tabs/nutrition/weekly_nutrients_screen.dart';
import 'ui/tabs/nutrition/creation/meal_creation_screen.dart';
import 'ui/tabs/health_indicators/health_indicators_creation_screen.dart';
import 'ui/user_conditions_screen.dart';

class Routes {
  static const ROUTE_START = "start";

  static const ROUTE_LOGIN = "login";
  static const ROUTE_LOGIN_EMAIL_PASSWORD = "login_email_password";
  static const ROUTE_REGISTRATION = "registration";
  static const ROUTE_REMIND_PASSWORD = "remind_password";

  static const ROUTE_HOME = "home";

  static const ROUTE_DAILY_WEEKLY_NUTRIENTS_SCREEN = "weekly_nutrients_screen";
  static const ROUTE_MEAL_CREATION = "meal_creation";

  static const ROUTE_WEEKLY_HEALTH_INDICATORS_SCREEN =
      "weekly_health_indicators_screen";
  static const ROUTE_HEALTH_INDICATORS_CREATION = "health_indicators_creation";

  static const ROUTE_USER_CONDITIONS = "user_conditions";
  static const ROUTE_FAQ = "frequently_asked_questions";

  static const ROUTE_FORM_SELECT = "form_select";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_START:
        return MaterialPageRoute(builder: (context) {
          return StartScreen();
        });
      case ROUTE_LOGIN:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });
      case ROUTE_REGISTRATION:
        return MaterialPageRoute<UserCredential>(builder: (context) {
          return RegistrationScreen();
        });
      case ROUTE_REMIND_PASSWORD:
        return MaterialPageRoute(builder: (context) {
          return RemindPasswordScreen();
        });
      case ROUTE_LOGIN_EMAIL_PASSWORD:
        return MaterialPageRoute<UserCredential>(builder: (context) {
          return EmailPasswordLoginScreen();
        });
      case ROUTE_HOME:
        return MaterialPageRoute(builder: (context) {
          return HomeScreen();
        });
      case ROUTE_MEAL_CREATION:
        return MaterialPageRoute(builder: (context) {
          MealCreationScreenArguments arguments = settings.arguments;

          return MealCreationScreen(initialProduct: arguments?.product);
        });
      case ROUTE_HEALTH_INDICATORS_CREATION:
        return MaterialPageRoute(builder: (context) {
          return HealthIndicatorsCreationScreen();
        });
      case ROUTE_FAQ:
        return MaterialPageRoute(builder: (context) {
          return FrequentlyAskedQuestionsScreen();
        });
      case ROUTE_USER_CONDITIONS:
        return MaterialPageRoute(builder: (context) {
          return UserConditionsScreen();
        });
      case ROUTE_DAILY_WEEKLY_NUTRIENTS_SCREEN:
        return MaterialPageRoute(builder: (context) {
          WeeklyNutrientsScreenArguments arguments = settings.arguments;

          return WeeklyNutrientsScreen(
            nutrient: arguments.nutrient,
          );
        });
      case ROUTE_WEEKLY_HEALTH_INDICATORS_SCREEN:
        return MaterialPageRoute(builder: (context) {
          WeeklyHealthIndicatorsScreenArguments arguments = settings.arguments;

          return WeeklyHealthIndicatorsScreen(
            initialHealthIndicator: arguments.initialHealthIndicator,
          );
        });
      default:
        throw Exception("Unable to find route ${settings.name} in routes");
    }
  }
}
