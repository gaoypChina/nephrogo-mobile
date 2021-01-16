import 'dart:core';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

extension FutureExtensions<T> on Future<T> {
  Future<T> _onError(exception, StackTrace stackTrace) async {
    await FirebaseCrashlytics.instance.recordError(exception, stackTrace);

    return Future.error(exception, stackTrace);
  }

  Future<T> reportOnError() {
    return this.catchError(_onError);
  }
}
