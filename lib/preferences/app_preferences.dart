import 'dart:async';

import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _keyProfileCreated = 'PROFILE_CREATED';
  static const _keyOnboardingPassed = 'ONBOARDING_PASSED';
  static const _keyLegalConditionsAgreed = 'LEGAL_CONDITIONS_AGREED';
  static const _keyMarketingAllowed = 'MARKETING_ALLOWED';
  static const _keyInAppUpdateLastPromptedDate =
      'IN_APP_UPDATE_LAST_PROMPTED_DATE';
  static const _keyPeritonealDialysisType = 'PERITONEAL_DIALYSIS_TYPE';

  static final AppPreferences _singleton = AppPreferences._internal();

  factory AppPreferences() {
    return _singleton;
  }

  AppPreferences._internal();

  SharedPreferences? _sharedPreferencesInternal;

  Future<SharedPreferences> get _sharedPreferences async {
    if (_sharedPreferencesInternal != null) {
      return _sharedPreferencesInternal!;
    }
    return _sharedPreferencesInternal = await SharedPreferences.getInstance();
  }

  Future<bool> clear() {
    return _sharedPreferences.then((preferences) => preferences.clear());
  }

  Future<bool> setProfileCreated() {
    return _sharedPreferences
        .then((preferences) => preferences.setBool(_keyProfileCreated, true));
  }

  Future<bool> isProfileCreated() {
    return _sharedPreferences.then(
        (preferences) => preferences.getBool(_keyProfileCreated) ?? false);
  }

  Future<bool> isOnboardingPassed() {
    return _sharedPreferences.then(
        (preferences) => preferences.getBool(_keyOnboardingPassed) ?? false);
  }

  Future<bool> setOnboardingPassed() {
    return _sharedPreferences
        .then((preferences) => preferences.setBool(_keyOnboardingPassed, true));
  }

  Future<bool> isLegalConditionsAgreed() {
    return _sharedPreferences.then((preferences) =>
        preferences.getBool(_keyLegalConditionsAgreed) ?? false);
  }

  Future<bool> setLegalConditionsAgreed() {
    return _sharedPreferences.then(
        (preferences) => preferences.setBool(_keyLegalConditionsAgreed, true));
  }

  Future<bool> hasMarketingAllowed() {
    return _sharedPreferences
        .then((preferences) => preferences.containsKey(_keyMarketingAllowed));
  }

  Future<bool> isMarketingAllowed() {
    return _sharedPreferences.then(
        (preferences) => preferences.getBool(_keyMarketingAllowed) ?? false);
  }

  // ignore: avoid_positional_boolean_parameters
  Future<bool> setMarketingAllowed(bool allowed) {
    return _sharedPreferences.then(
        (preferences) => preferences.setBool(_keyMarketingAllowed, allowed));
  }

  Future<bool> setInAppUpdateLastPromptedDate(DateTime dateTime) {
    return _sharedPreferences.then(
      (preferences) => preferences.setString(
        _keyInAppUpdateLastPromptedDate,
        dateTime.toIso8601String(),
      ),
    );
  }

  Future<DateTime?> getInAppUpdateLastPromptedDate() {
    return _sharedPreferences.then<DateTime?>(
      (preferences) {
        final dateTimeStr =
            preferences.getString(_keyInAppUpdateLastPromptedDate);

        if (dateTimeStr == null) {
          return null;
        }

        return DateTime.parse(dateTimeStr);
      },
    );
  }

  Future<bool> setPeritonealDialysisType(
    PeriotonicDialysisTypeEnum dialysisType,
  ) {
    return _sharedPreferences.then(
      (preferences) => preferences.setString(
        _keyPeritonealDialysisType,
        dialysisType.name,
      ),
    );
  }

  Future<PeriotonicDialysisTypeEnum> getPeritonealDialysisType() {
    return _sharedPreferences.then<PeriotonicDialysisTypeEnum>(
      (preferences) {
        final typeStr =
            preferences.getString(_keyPeritonealDialysisType)?.toLowerCase();

        if (typeStr ==
            PeriotonicDialysisTypeEnum.automatic.name.toLowerCase()) {
          return PeriotonicDialysisTypeEnum.automatic;
        } else if (typeStr ==
            PeriotonicDialysisTypeEnum.manual.name.toLowerCase()) {
          return PeriotonicDialysisTypeEnum.manual;
        } else {
          return PeriotonicDialysisTypeEnum.unknown;
        }
      },
    );
  }

  Future<bool> hasPeritonealDialysisTypeSaved() {
    return _sharedPreferences.then<bool>(
      (preferences) => preferences.containsKey(_keyPeritonealDialysisType),
    );
  }
}
