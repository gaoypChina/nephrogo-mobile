import 'dart:async';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);

  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair as List<dynamic>;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last as StackTrace,
    );
  }).sendPort);

  runZonedGuarded<void>(
    () => runApp(AppComponent()),
    FirebaseCrashlytics.instance.recordError,
  );
}
