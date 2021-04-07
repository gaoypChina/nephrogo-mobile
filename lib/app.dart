import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/analytics.dart';

import 'l10n/localizations.dart';

class AppComponent extends StatefulWidget {
  @override
  _AppComponentState createState() => _AppComponentState();
}

class _AppComponentState extends State<AppComponent> {
  static const _defaultLocale = Locale('lt', 'LT');

  final _apiService = ApiService();
  final _appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'lt';

    final analytics = Analytics();

    const inputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(),
      helperMaxLines: 5,
      errorMaxLines: 5,
    );

    return MaterialApp(
      title: 'NephroGo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.redAccent,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: inputDecorationTheme,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.redAccent,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: inputDecorationTheme,
      ),
      navigatorObservers: [analytics.observer],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _defaultLocale,
      supportedLocales: const [_defaultLocale],
      initialRoute: Routes.routeStart,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }

  @override
  Future dispose() async {
    await _apiService.dispose();
    await _appPreferences.dispose();

    super.dispose();
  }
}
