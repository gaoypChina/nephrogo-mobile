import 'package:flutter/material.dart';
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
  final _apiService = ApiService();
  final _appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    final analytics = Analytics();

    const inputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(),
      helperMaxLines: 5,
      errorMaxLines: 5,
    );

    return StreamBuilder<String?>(
        stream: _appPreferences.getLanguageCodeStream(),
        builder: (context, snapshot) {
          final userChosenLocale = _getUserChosenLocale(snapshot.data);

          if (userChosenLocale != null) {
            Intl.defaultLocale = userChosenLocale.toLanguageTag();
          }

          return MaterialApp(
            key: Key('app-with-locale-$userChosenLocale'),
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
            locale: userChosenLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeListResolutionCallback: (locales, supportedLocales) {
              final appLocale = _resolveLocale(
                locales ?? [],
                supportedLocales,
              );

              Intl.defaultLocale = appLocale.toLanguageTag();

              return appLocale;
            },
            initialRoute: Routes.routeStart,
            onGenerateRoute: Routes.onGenerateRoute,
          );
        });
  }

  Locale? _getUserChosenLocale(String? savedCountryCode) {
    for (final supportedLocale in AppLocalizations.supportedLocales) {
      if (supportedLocale.languageCode == savedCountryCode?.toLowerCase()) {
        return supportedLocale;
      }
    }

    return null;
  }

  Locale _resolveLocale(
    List<Locale> locales,
    Iterable<Locale> supportedLocales,
  ) {
    for (final locale in locales) {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
    }

    return const Locale('lt');
  }

  @override
  Future dispose() async {
    await _apiService.dispose();
    await _appPreferences.dispose();

    super.dispose();
  }
}
