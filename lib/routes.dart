import 'package:flutter/material.dart';
import 'package:nephrolog/ui/meal_creation_screen.dart';

import 'ui/home_screen.dart';
import 'ui/intakes_screen.dart';
import 'ui/user_conditions.dart';

class Routes {
  static const ROUTE_HOME = "home";
  static const ROUTE_INTAKES = "intakes";
  static const ROUTE_MEAL_CREATION = "meal_creation";
  static const ROUTE_USER_CONDITIONS = "user_conditions";

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
      default:
        throw Exception("Unable to find route ${settings.name} in routes");
    }
  }
}
