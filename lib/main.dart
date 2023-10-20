import 'dart:async';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher, kDebugMode;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nephrogo/app.dart';
import 'package:nephrogo/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final message = '${record.level.name}: ${record.time}: ${record.message}';
    if (kDebugMode) {
      // ignore: avoid_print
      print(message);
    } else {
      FirebaseCrashlytics.instance.log(message);
    }
  });

  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
  runApp(AppComponent());
}
