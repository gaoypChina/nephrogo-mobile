import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _defaultLocale = Locale("lt", "LT");

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'lt';

    return MaterialApp(
      title: 'NephroLog',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _defaultLocale,
      supportedLocales: [_defaultLocale],
      initialRoute: Routes.ROUTE_HOME,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
