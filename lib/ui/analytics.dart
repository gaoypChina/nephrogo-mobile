import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Analytics {
  static final Analytics _singleton = Analytics._internal();

  FirebaseAnalytics analytics;

  factory Analytics() {
    return _singleton;
  }

  Analytics._internal() {
    analytics = FirebaseAnalytics();
  }

  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: analytics);
}
