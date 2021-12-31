import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/ui/authentication/email_password_login_screen.dart';
import 'package:nephrogo/ui/authentication/login_screen.dart';
import 'package:nephrogo/ui/authentication/registration_screen.dart';
import 'package:nephrogo/ui/authentication/remind_password.dart';
import 'package:nephrogo/ui/country/country_screen.dart';
import 'package:nephrogo/ui/general_recommendations_screen.dart';
import 'package:nephrogo/ui/home_screen.dart';
import 'package:nephrogo/ui/legal/legal_screen.dart';
import 'package:nephrogo/ui/onboarding/onboarding_screen.dart';
import 'package:nephrogo/ui/start_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/blood_pressure_and_pulse_creation_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/blood_pressure_edit_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_creation_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_screen.dart';
import 'package:nephrogo/ui/tabs/health_status/pulse_edit_screen.dart';
import 'package:nephrogo/ui/tabs/nutrition/intake_create.dart';
import 'package:nephrogo/ui/tabs/nutrition/intake_edit.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_daily_summary.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/automatic/automatic_peritoneal_dialysis_creation_screen.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/automatic/automatic_peritoneal_dialysis_periods.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/manual/manual_peritoneal_dialysis_creation_screen.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/manual/manual_peritoneal_dialysis_screen.dart';
import 'package:nephrogo/ui/user_profile/user_profile_screen.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

// ignore: avoid_classes_with_only_static_members
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

  static const routeHealthStatusScreen = 'weeklyHealthStatusScreen';
  static const routeHealthStatusCreation = 'healthStatusCreation';
  static const routeBloodPressureAndPulseCreation =
      'bloodPressureAndPulseCreation';
  static const routeBloodPressureEdit = 'bloodPressureEdit';
  static const routePulseEdit = 'pulseEdit';

  static const routeManualPeritonealDialysisCreation =
      'ManualPeritonealDialysisCreation';
  static const routeManualPeritonealDialysisScreen =
      'ManualPeritonealDialysisDialysisScreen';

  static const routeAutomaticPeritonealDialysisCreation =
      'AutomaticPeritonealDialysisCreation';
  static const routeAutomaticPeritonealDialysisPeriod =
      'AutomaticPeritonealDialysisPeriod';

  static const routeUserProfile = 'userProfile';

  static const routeGeneralRecommendationsCategory =
      'generalRecommendationsCategory';
  static const routeGeneralRecommendationsSubcategory =
      'generalRecommendationsSubcategory';
  static const routeGeneralRecommendation = 'generalRecommendation';

  static const routeLegal = 'legal';
  static const routeCountry = 'country';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeStart:
        return MaterialPageRoute(builder: (context) {
          return StartScreen();
        });
      case routeOnboarding:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments as OnboardingScreenArguments?;

          if (arguments == null) {
            throw ArgumentError.value(
              arguments,
              'Pass OnboardingScreenArguments',
            );
          }

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
          final arguments = settings.arguments! as LegalScreenArguments;

          return LegalScreen(exitType: arguments.exitType);
        });
      case routeCountry:
        return MaterialPageRoute(builder: (context) {
          return CountryScreen();
        });
      case routeIntakeCreate:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments! as IntakeCreateScreenArguments;

          return IntakeCreateScreen(
            dailyNutrientNormsAndTotals: arguments.dailyNutrientNormsAndTotals,
            initialProduct: arguments.product,
            initialDate: arguments.initialDate,
            mealType: arguments.mealType,
          );
        });
      case routeIntakeEdit:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments! as IntakeEditScreenArguments;

          return IntakeEditScreen(
            dailyNutrientNormsAndTotals: arguments.dailyNutrientNormsAndTotals,
            intake: arguments.intake,
          );
        });
      case routeManualPeritonealDialysisCreation:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments!
              as ManualPeritonealDialysisCreationScreenArguments;

          return ManualPeritonealDialysisCreationScreen(
            initialDialysis: arguments.dialysis,
          );
        });
      case routeManualPeritonealDialysisScreen:
        return MaterialPageRoute(
          builder: (context) {
            final arguments =
                settings.arguments! as ManualPeritonealDialysisScreenArguments;

            return ManualPeritonealDialysisScreen(
              initialDate: arguments.initialDate,
            );
          },
        );
      case routeAutomaticPeritonealDialysisCreation:
        return MaterialPageRoute(
          builder: (context) {
            final arguments = settings.arguments!
                as AutomaticPeritonealDialysisCreationScreenArguments;

            return AutomaticPeritonealDialysisCreationScreen(
              initialDialysis: arguments.dialysis,
            );
          },
        );
      case routeAutomaticPeritonealDialysisPeriod:
        return MaterialPageRoute(
          builder: (context) {
            final arguments = settings.arguments!
                as AutomaticPeritonealDialysisPeriodsScreenArguments;

            return AutomaticPeritonealDialysisPeriodsScreen(
              initialDate: arguments.initialDate,
            );
          },
        );
      case routeProductSearch:
        return MaterialPageRoute<Product>(builder: (context) {
          final arguments = settings.arguments! as ProductSearchScreenArguments;

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
              settings.arguments! as NutritionDailySummaryScreenArguments;

          return NutritionDailySummaryScreen(
            arguments.date,
            nutrient: arguments.nutrient,
          );
        });
      case routeHealthStatusCreation:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments! as HealthStatusCreationScreenArguments;

          return HealthStatusCreationScreen(date: arguments.date);
        });
      case routeBloodPressureAndPulseCreation:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments!
              as BloodPressureAndPulseCreationScreenArguments;

          return BloodPressureAndPulseCreationScreen(
            initialDate: arguments.date,
          );
        });
      case routeBloodPressureEdit:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments! as BloodPressureEditScreenArguments;

          return BloodPressureEditScreen(
            bloodPressure: arguments.bloodPressure,
          );
        });
      case routePulseEdit:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments! as PulseEditScreenArguments;

          return PulseEditScreen(pulse: arguments.pulse);
        });

      case routeGeneralRecommendationsCategory:
        return MaterialPageRoute<Set<int>>(builder: (context) {
          final arguments = settings.arguments!
              as GeneralRecommendationCategoryScreenArguments;
          return GeneralRecommendationCategoryScreen(
            category: arguments.category,
            readRecommendationIds: arguments.readRecommendationIds,
          );
        });
      case routeGeneralRecommendationsSubcategory:
        return MaterialPageRoute<Set<int>>(builder: (context) {
          final arguments = settings.arguments!
              as GeneralRecommendationSubcategoryScreenArguments;
          return GeneralRecommendationSubcategoryScreen(
            subcategory: arguments.subcategory,
            readRecommendationIds: arguments.readRecommendationIds,
          );
        });
      case routeGeneralRecommendation:
        return MaterialPageRoute(builder: (context) {
          final arguments =
              settings.arguments! as GeneralRecommendationScreenArguments;

          return GeneralRecommendationScreen(
            recommendation: arguments.recommendation,
            subcategory: arguments.subcategory,
          );
        });
      case routeUserProfile:
        return MaterialPageRoute(builder: (context) {
          final nextScreenType =
              settings.arguments! as UserProfileNextScreenType;

          return UserProfileScreen(
            nextScreenType: nextScreenType,
          );
        });
      case routeNutritionSummary:
        return MaterialPageRoute(builder: (context) {
          assert(settings.arguments is NutritionSummaryScreenArguments);

          final arguments =
              settings.arguments! as NutritionSummaryScreenArguments;

          return NutritionSummaryScreen(
            screenType: arguments.screenType,
            nutrient: arguments.nutrient,
            nutritionSummaryStatistics: arguments.nutritionSummaryStatistics,
          );
        });
      case routeHealthStatusScreen:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments! as HealthStatusScreenArguments;

          return HealthStatusScreen(
            healthIndicator: arguments.healthIndicator,
          );
        });
      default:
        throw Exception('Unable to find route ${settings.name} in routes');
    }
  }
}
