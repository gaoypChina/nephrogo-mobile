import 'package:flutter/material.dart';

import 'ui/home_screen.dart';

class Routes {
  static const ROUTE_HOME = "home";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_HOME:
        return MaterialPageRoute(builder: (context) {
          return HomeScreen();
        });
      default:
        throw Exception("Unable to find route ${settings.name} in routes");
    }
  }
}