import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/ui/authentication/email_password_login_screen.dart';
import 'package:nephrogo_api_client/model/intake.dart';
import 'package:nephrogo_api_client/model/product.dart';

import 'ui/authentication/login_screen.dart';
import 'ui/authentication/registration_screen.dart';
import 'ui/authentication/remind_password.dart';
import 'ui/faq_screen.dart';
import 'ui/home_screen.dart';
import 'ui/legal/legal_screen.dart';
import 'ui/onboarding/onboarding_screen.dart';
import 'ui/start_screen.dart';
import 'ui/tabs/health_status/health_status_creation_screen.dart';
import 'ui/tabs/health_status/weekly_health_status_screen.dart';
import 'ui/tabs/nutrition/intake_create.dart';
import 'ui/tabs/nutrition/my_daily_intakes_reports_screen.dart';
import 'ui/tabs/nutrition/my_daily_intakes_screen.dart';
import 'ui/tabs/nutrition/product_search.dart';
import 'ui/tabs/nutrition/weekly_nutrients_screen.dart';
import 'ui/user_profile_screen.dart';

class Routes {
  static const routeStart = 'start';

  static const routeLogin = 'login';
  static const routeLoginEmailPassword = 'loginEmailPassword';
  static const routeRegistration = 'registration';
  static const routeRemindPassword = 'RemindPassword';

  static const routeHome = 'home';

  static const routeOnboarding = 'onboarding';

  static const routeDailyWeeklyNutrientsScreen = 'weeklyNutrientsScreen';
  static const routeDailyWeeklyIntakesScreen = 'dailyWeeklyIntakesScreen';
  static const routeMyDailyIntakesScreen = 'myDailyIntakesScreen';
  static const routeIntakeCreate = 'intakeCreate';
  static const routeProductSearch = 'productSearch';

  static const routeWeeklyHealthStatusScreen = 'weeklyHealthStatusScreen';
  static const routeHealthStatusCreation = 'healthStatusCreation';

  static const routeUserProfile = 'userProfile';
  static const routeFAQ = 'faq';
  static const routeLegal = 'legal';

  static const routeFormSelect = 'formSelect';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeStart:
        return MaterialPageRoute(builder: (context) {
          return StartScreen();
        });
      case routeOnboarding:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments as OnboardingScreenArguments;

          return OnboardingScreen(exitType: arguments.exitType);
        });
      case routeLogin:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });
      case routeRegistration:
        return MaterialPageRoute<UserCredential>(builder: (context) {
          return RegistrationScreen();
        });
      case routeRemindPassword:
        return MaterialPageRoute(builder: (context) {
          return RemindPasswordScreen();
        });
      case routeLoginEmailPassword:
        return MaterialPageRoute<UserCredential>(builder: (context) {
          return EmailPasswordLoginScreen();
        });
      case routeHome:
        return MaterialPageRoute(builder: (context) {
          return HomeScreen();
        });
      case routeLegal:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments as LegalScreenArguments;

          return LegalScreen(exitType: arguments.exitType);
        });
      case routeIntakeCreate:
        return MaterialPageRoute<Intake>(builder: (context) {
          final arguments = settings.arguments as IntakeCreateScreenArguments;

          return IntakeCreateScreen(
            dailyNutrientNormsAndTotals: arguments.dailyNutrientNormsAndTotals,
            initialProduct: arguments.product ?? arguments.intake.product,
            intake: arguments.intake,
          );
        });
      case routeProductSearch:
        return MaterialPageRoute<Product>(builder: (context) {
          final searchType = settings.arguments as ProductSearchType;

          return ProductSearchScreen(searchType: searchType);
        });
      case routeMyDailyIntakesScreen:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments as MyDailyIntakesScreenArguments;

          return MyDailyIntakesScreen(date: arguments.date);
        });
      case routeHealthStatusCreation:
        return MaterialPageRoute(builder: (context) {
          return HealthStatusCreationScreen();
        });
      case routeFAQ:
        return MaterialPageRoute(builder: (context) {
          return FrequentlyAskedQuestionsScreen();
        });
      case routeUserProfile:
        return MaterialPageRoute(builder: (context) {
          final nextScreenType =
              settings.arguments as UserProfileNextScreenType;

          return UserProfileScreen(
            nextScreenType: nextScreenType,
          );
        });
      case routeDailyWeeklyIntakesScreen:
        return MaterialPageRoute(builder: (context) {
          return MyDailyIntakesReportsScreen();
        });
      case routeDailyWeeklyNutrientsScreen:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments as WeeklyNutrientsScreenArguments;

          return WeeklyNutrientsScreen(
            nutrient: arguments.nutrient,
          );
        });
      case routeWeeklyHealthStatusScreen:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments as WeeklyHealthStatusScreenArguments;

          return WeeklyHealthStatusScreen(
            initialHealthIndicator: arguments.initialHealthIndicator,
          );
        });
      default:
        throw Exception('Unable to find route ${settings.name} in routes');
    }
  }
}
