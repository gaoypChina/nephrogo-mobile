import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/routes.dart';

import 'l10n/localizations.dart';

class AppComponent extends StatefulWidget {
  @override
  _AppComponentState createState() => _AppComponentState();
}

class _AppComponentState extends State<AppComponent> {
  static final _defaultLocale = Locale("lt", "LT");

  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'lt';

    return MaterialApp(
      title: 'NephroGo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          helperMaxLines: 5,
          errorMaxLines: 5,
        ),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _defaultLocale,
      supportedLocales: [_defaultLocale],
      initialRoute: Routes.ROUTE_START,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }

  @override
  Future dispose() async {
    await _apiService.dispose();

    super.dispose();
  }
}
