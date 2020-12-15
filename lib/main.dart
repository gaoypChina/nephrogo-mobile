import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/routes.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  runZonedGuarded<Future<void>>(() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(new AppComponent());
  }, FirebaseCrashlytics.instance.recordError);
}

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
