import 'package:flutter/material.dart';

import 'ui/forms/app_form_select_screen.dart';
import 'ui/home_screen.dart';
import 'ui/intakes_screen.dart';
import 'ui/meal_creation_screen.dart';
import 'ui/tabs/health_indicators/health_indicators_creation_screen.dart';
import 'ui/user_conditions.dart';

class Routes {
  static const ROUTE_HOME = "home";
  static const ROUTE_INTAKES = "intakes";
  static const ROUTE_MEAL_CREATION = "meal_creation";
  static const ROUTE_HEALTH_INDICATORS_CREATION = "health_indicators_creation";
  static const ROUTE_USER_CONDITIONS = "user_conditions";

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
      case ROUTE_USER_CONDITIONS:
        return MaterialPageRoute(builder: (context) {
          return UserConditionsScreen();
        });
      case ROUTE_INTAKES:
        return MaterialPageRoute(builder: (context) {
          IntakesScreenArguments arguments = settings.arguments;

          return IntakesScreen(
            intakesScreenType: arguments.intakesScreenType,
          );
        });
      case ROUTE_FORM_SELECT:
        return MaterialPageRoute(builder: (context) {
          AppFromSelectScreenData data = settings.arguments;

          return AppFromSelectScreen(data: data);
        });
      default:
        throw Exception("Unable to find route ${settings.name} in routes");
    }
  }
}
