import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  static final Analytics _singleton = Analytics._internal();

  static const eventOnboardingSkipped = 'tutorial_skipped';

  late FirebaseAnalytics _analytics;
  late FirebaseAnalyticsObserver observer;

  factory Analytics() {
    return _singleton;
  }

  Analytics._internal() {
    _analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: _analytics);
  }

  Future<void> setUserId(String id) {
    return _analytics.setUserId(id: id);
  }

  Future<void> logUserLogin() {
    return _analytics.logLogin();
  }

  Future logOnboardingBegin() {
    return _analytics.logTutorialBegin();
  }

  Future logOnboardingComplete() {
    return _analytics.logTutorialComplete();
  }

  Future logOnboardingSkipped() async {
    return _analytics.logEvent(name: eventOnboardingSkipped);
  }
}
