import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const keyProfileCreated = 'PROFILE_CREATED';
  static const keyOnboardingPassed = 'ONBOARDING_PASSED';
  static const keyLegalConditionsAgreed = 'LEGAL_CONDITIONS_AGREED';
  static const keyMarketingAllowed = 'MARKETING_ALLOWED';

  static final AppPreferences _singleton = AppPreferences._internal();

  factory AppPreferences() {
    return _singleton;
  }

  AppPreferences._internal();

  SharedPreferences _sharedPreferencesInternal;

  Future<SharedPreferences> get _sharedPreferences async {
    if (_sharedPreferencesInternal != null) {
      return _sharedPreferencesInternal;
    }
    return _sharedPreferencesInternal = await SharedPreferences.getInstance();
  }

  Future<bool> setProfileCreated() {
    return _sharedPreferences
        .then((preferences) => preferences.setBool(keyProfileCreated, true));
  }

  Future<bool> deleteProfileCreated() {
    return _sharedPreferences
        .then((preferences) => preferences.remove(keyProfileCreated));
  }

  Future<bool> isProfileCreated() {
    return _sharedPreferences.then((preferences) {
      if (preferences.containsKey(keyProfileCreated)) {
        return preferences.getBool(keyProfileCreated);
      }

      return false;
    });
  }

  Future<bool> isOnboardingPassed() {
    return _sharedPreferences.then(
        (preferences) => preferences.getBool(keyOnboardingPassed) ?? false);
  }

  Future<bool> setOnboardingPassed() {
    return _sharedPreferences
        .then((preferences) => preferences.setBool(keyOnboardingPassed, true));
  }

  Future<bool> isLegalConditionsAgreed() {
    return _sharedPreferences.then((preferences) =>
        preferences.getBool(keyLegalConditionsAgreed) ?? false);
  }

  Future<bool> setLegalConditionsAgreed() {
    return _sharedPreferences.then(
        (preferences) => preferences.setBool(keyLegalConditionsAgreed, true));
  }

  Future<bool> isMarketingAllowed() {
    return _sharedPreferences
        .then((preferences) => preferences.getBool(keyMarketingAllowed));
  }

  // ignore: avoid_positional_boolean_parameters
  Future<bool> setMarketingAllowed(bool allowed) {
    return _sharedPreferences.then(
        (preferences) => preferences.setBool(keyMarketingAllowed, allowed));
  }
}
