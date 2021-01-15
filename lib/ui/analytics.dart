import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Analytics {
  static final Analytics _singleton = Analytics._internal();

  FirebaseAnalytics _analytics;

  factory Analytics() {
    return _singleton;
  }

  Analytics._internal() {
    _analytics = FirebaseAnalytics();
  }

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> setUserId(String id) {
    return _analytics.setUserId(id);
  }

  Future<void> logUserLogin() {
    return _analytics.logLogin();
  }
}
