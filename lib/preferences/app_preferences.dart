import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _KEY_PROFILE_CREATED = "PROFILE_CREATED";
  static const _KEY_ONBOARDING_PASSED = "ONBOARDING_PASSED";

  static final AppPreferences _singleton = new AppPreferences._internal();

  factory AppPreferences() {
    return _singleton;
  }

  AppPreferences._internal();

  SharedPreferences _sharedPreferencesInternal;

  Future<SharedPreferences> get _sharedPreferences async {
    if (_sharedPreferencesInternal != null) {
      return _sharedPreferencesInternal;
    }
    _sharedPreferencesInternal = await SharedPreferences.getInstance();

    return _sharedPreferencesInternal;
  }

  Future<bool> setProfileCreated() {
    return _sharedPreferences
        .then((preferences) => preferences.setBool(_KEY_PROFILE_CREATED, true));
  }

  Future<bool> deleteProfileCreated() {
    return _sharedPreferences
        .then((preferences) => preferences.remove(_KEY_PROFILE_CREATED));
  }

  Future<bool> isProfileCreated() {
    return _sharedPreferences.then((preferences) {
      if (preferences.containsKey(_KEY_PROFILE_CREATED)) {
        return preferences.getBool(_KEY_PROFILE_CREATED);
      }

      return false;
    });
  }

  Future<bool> isOnboardingPassed() {
    return _sharedPreferences.then(
        (preferences) => preferences.getBool(_KEY_ONBOARDING_PASSED) ?? false);
  }

  Future<bool> setOnboardingPassed() {
    return _sharedPreferences.then(
        (preferences) => preferences.setBool(_KEY_ONBOARDING_PASSED, true));
  }
}
