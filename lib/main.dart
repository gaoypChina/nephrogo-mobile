import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

import 'app.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final message = '${record.level.name}: ${record.time}: ${record.message}';
    if (kDebugMode) {
      print(message);
    } else {
      FirebaseCrashlytics.instance.log(message);
    }
  });

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  runZonedGuarded<Future<void>>(
    () async {
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);

      runApp(AppComponent());
    },
    FirebaseCrashlytics.instance.recordError,
  );
}
