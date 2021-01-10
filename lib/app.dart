import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/routes.dart';

import 'l10n/localizations.dart';

class AppComponent extends StatelessWidget {
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
}
