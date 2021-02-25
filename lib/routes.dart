import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/ui/authentication/email_password_login_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/blood_pressure_and_pulse_creation_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/blood_pressure_edit_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/pulse_edit_screen.dart';
import 'package:nephrogo/ui/tabs/manual_peritoneal_dialysis/manual_peritoneal_dialysis_all_screen.dart';
import 'package:nephrogo/ui/tabs/nutrition/intake_edit.dart';
import 'package:nephrogo_api_client/model/product.dart';

import 'ui/authentication/login_screen.dart';
import 'ui/authentication/registration_screen.dart';
import 'ui/authentication/remind_password.dart';
import 'ui/general_recommendations_screen.dart';
import 'ui/home_screen.dart';
import 'ui/legal/legal_screen.dart';
import 'ui/onboarding/onboarding_screen.dart';
import 'ui/start_screen.dart';
import 'ui/tabs/health_status/health_status_creation_screen.dart';
import 'ui/tabs/health_status/weekly_health_status_screen.dart';
import 'ui/tabs/manual_peritoneal_dialysis/manual_peritoneal_dialysis_creation_screen.dart';
import 'ui/tabs/nutrition/intake_create.dart';
import 'ui/tabs/nutrition/product_search.dart';
import 'ui/tabs/nutrition/summary/nutrition_daily_summary.dart';
import 'ui/tabs/nutrition/summary/nutrition_summary.dart';
import 'ui/user_profile_screen.dart';

class Routes {
  static const routeStart = 'start';

  static const routeLogin = 'login';
  static const routeLoginEmailPassword = 'loginEmailPassword';
  static const routeRegistration = 'registration';
  static const routeRemindPassword = 'RemindPassword';

  static const routeHome = 'home';

  static const routeOnboarding = 'onboarding';

  static const routeNutritionSummary = 'nutritionSummary';
  static const routeNutritionDailySummary = 'nutritionDailySummary';
  static const routeIntakeCreate = 'intakeCreate';
  static const routeIntakeEdit = 'intakeEdit';
  static const routeProductSearch = 'productSearch';

  static const routeWeeklyHealthStatusScreen = 'weeklyHealthStatusScreen';
  static const routeHealthStatusCreation = 'healthStatusCreation';
  static const routeBloodPressureAndPulseCreation =
      'bloodPressureAndPulseCreation';
  static const routeBloodPressureEdit = 'bloodPressureEdit';
  static const routePulseEdit = 'pulseEdit';

  static const routeManualPeritonealDialysisCreation =
      'ManualPeritonealDialysisCreation';
  static const routeManualPeritonealDialysisAllScreen =
      'ManualPeritonealDialysisList';

  static const routeUserProfile = 'userProfile';
  static const routeGeneralRecommendations = 'generalRecommendations';
  static const routeGeneralRecommendationsCategory =
      'generalRecommendationsCategory';
  static const routeLegal = 'legal';

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
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments as IntakeCreateScreenArguments;

          return IntakeCreateScreen(
            dailyNutrientNormsAndTotals: arguments.dailyNutrientNormsAndTotals,
            initialProduct: arguments.product ?? arguments.intake.product,
            intake: arguments.intake,
            initialDate: arguments.initialDate,
            mealType: arguments.mealType,
          );
        });
      case routeIntakeEdit:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments as IntakeEditScreenArguments;

          return IntakeEditScreen(
            dailyNutrientNormsAndTotals: arguments.dailyNutrientNormsAndTotals,
            intake: arguments.intake,
          );
        });
      case routeManualPeritonealDialysisCreation:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments
              as ManualPeritonealDialysisCreationScreenArguments;

          return ManualPeritonealDialysisCreationScreen(
            initialDialysis: arguments.dialysis,
          );
        });
      case routeManualPeritonealDialysisAllScreen:
        return MaterialPageRoute(builder: (context) {
          return ManualPeritonealDialysisDialysisScreen();
        });
      case routeProductSearch:
        return MaterialPageRoute<Product>(builder: (context) {
          final arguments = settings.arguments as ProductSearchScreenArguments;

          return ProductSearchScreen(
            searchType: arguments.searchType,
            excludeProductsIds: arguments.excludeProductsIds,
            date: arguments.date,
            mealType: arguments.mealType,
          );
        });
      case routeNutritionDailySummary:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments as NutritionDailySummaryScreenArguments;

          return NutritionDailySummaryScreen(
            arguments.date,
            nutrient: arguments.nutrient,
          );
        });
      case routeHealthStatusCreation:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments as HealthStatusCreationScreenArguments;

          return HealthStatusCreationScreen(date: arguments.date);
        });
      case routeBloodPressureAndPulseCreation:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments
              as BloodPressureAndPulseCreationScreenArguments;

          return BloodPressureAndPulseCreationScreen(
            initialDate: arguments.date,
          );
        });
      case routeBloodPressureEdit:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments as BloodPressureEditScreenArguments;

          return BloodPressureEditScreen(
            bloodPressure: arguments.bloodPressure,
          );
        });
      case routePulseEdit:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments as PulseEditScreenArguments;

          return PulseEditScreen(pulse: arguments.pulse);
        });
      case routeGeneralRecommendations:
        return MaterialPageRoute(builder: (context) {
          return GeneralRecommendationsScreen();
        });
      case routeGeneralRecommendationsCategory:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments
              as GeneralRecommendationsCategoryScreenArguments;
          return GeneralRecommendationsCategoryScreen(
            category: arguments.category,
          );
        });
      case routeUserProfile:
        return MaterialPageRoute(builder: (context) {
          final nextScreenType =
              settings.arguments as UserProfileNextScreenType;

          return UserProfileScreen(
            nextScreenType: nextScreenType,
          );
        });
      case routeNutritionSummary:
        return MaterialPageRoute(builder: (context) {
          assert(settings.arguments is NutritionSummaryScreenArguments);

          final arguments =
              settings.arguments as NutritionSummaryScreenArguments;

          return NutritionSummaryScreen(
            screenType: arguments.screenType,
            nutrient: arguments.nutrient,
            nutritionSummaryStatistics: arguments.nutritionSummaryStatistics,
          );
        });
      case routeWeeklyHealthStatusScreen:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments as WeeklyHealthStatusScreenArguments;

          return WeeklyHealthStatusScreen(
            healthIndicator: arguments.healthIndicator,
          );
        });
      default:
        throw Exception('Unable to find route ${settings.name} in routes');
    }
  }
}
