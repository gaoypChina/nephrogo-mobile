import 'package:flutter/material.dart';
import 'package:nephrolog/ui/meal_creation_screen.dart';

import 'ui/home_screen.dart';
import 'ui/intakes_screen.dart';

class Routes {
  static const ROUTE_HOME = "home";
  static const ROUTE_INTAKES = "intakes";
  static const ROUTE_MEAL_CREATION = "meal_creation";

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
      case ROUTE_INTAKES:
        return MaterialPageRoute(builder: (context) {
          IntakesScreenArguments arguments = settings.arguments;

          return IntakesScreen(
            indicator: arguments.indicator,
          );
        });
      default:
        throw Exception("Unable to find route ${settings.name} in routes");
    }
  }
}
