// Openapi Generator last run: : 2023-10-07T15:05:35.101223
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/analytics.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'nephrogo_api_client',
    pubAuthor: 'Karolis',
    useEnumExtension: false,
  ),
  inputSpecFile: 'openapi.yaml',
  generatorName: Generator.dio,
  useNextGen: false,
  outputDirectory: 'nephrogo_api_client',
)
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

    final lightTheme = ThemeData(
      primarySwatch: Colors.teal,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: inputDecorationTheme,
      brightness: Brightness.light,
    );
    final darkTheme = ThemeData(
      primarySwatch: Colors.teal,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: inputDecorationTheme,
      brightness: Brightness.dark,
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
          theme: lightTheme.copyWith(
            colorScheme: lightTheme.colorScheme.copyWith(
              secondary: Colors.redAccent,
            ),
          ),
          darkTheme: darkTheme.copyWith(
            colorScheme: darkTheme.colorScheme.copyWith(
              secondary: Colors.redAccent,
            ),
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
      },
    );
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
