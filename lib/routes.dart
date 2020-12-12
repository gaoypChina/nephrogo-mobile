import 'package:flutter/material.dart';

import 'ui/faq_screen.dart';
import 'ui/home_screen.dart';
import 'ui/tabs/health_indicators/weekly_health_indicators_screen.dart';
import 'ui/tabs/nutrition/weekly_nutrients_screen.dart';
import 'ui/tabs/nutrition/meal_creation_screen.dart';
import 'ui/tabs/health_indicators/health_indicators_creation_screen.dart';
import 'ui/user_conditions.dart';

class Routes {
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
      case ROUTE_HOME:
        return MaterialPageRoute(builder: (context) {
          return HomeScreen();
        });
      case ROUTE_MEAL_CREATION:
        return MaterialPageRoute(builder: (context) {
          return MealCreationScreen();
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
