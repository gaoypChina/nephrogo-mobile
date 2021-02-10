import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
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

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'lt';

    final analytics = Analytics();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NephroGo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          helperMaxLines: 5,
          errorMaxLines: 5,
        ),
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

    super.dispose();
  }
}
