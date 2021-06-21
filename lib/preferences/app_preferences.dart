import 'dart:async';

import 'package:async/async.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _AppPreferencesChangeEvent { dialysis, country }

class AppPreferences {
  static const _keyProfileCreated = 'PROFILE_CREATED';
  static const _keyOnboardingPassed = 'ONBOARDING_PASSED';
  static const _keyLegalConditionsAgreed = 'LEGAL_CONDITIONS_AGREED';
  static const _keyMarketingAllowed = 'MARKETING_ALLOWED';
  static const _keyInAppUpdateLastPromptedDate =
      'IN_APP_UPDATE_LAST_PROMPTED_DATE';
  static const _keyCountry = 'COUNTRY';

  // PERITONEAL_DIALYSIS_TYPE is due to historical reasons
  static const _keyDialysisType = 'PERITONEAL_DIALYSIS_TYPE';

  static final AppPreferences _singleton = AppPreferences._internal();

  final _preferencesEventsStreamController =
      StreamController<_AppPreferencesChangeEvent>.broadcast();

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

  Future<String?> getCountry() {
    return _sharedPreferences.then(
      (preferences) => preferences.getString(_keyCountry),
    );
  }

  Future<bool> isCountrySet() {
    return _sharedPreferences.then(
      (preferences) => preferences.containsKey(_keyCountry),
    );
  }

  Stream<String?> getCountryStream() {
    return _buildAppEventsStreamWithInitialEmit(
      _AppPreferencesChangeEvent.country,
    ).asyncMap((_) => getCountry());
  }

  Future<bool> setCountry(String countyCode) {
    return _sharedPreferences.then(
      (preferences) async {
        final previousCountry = await getCountry();

        if (countyCode != previousCountry) {
          await preferences.setString(_keyCountry, countyCode);

          _postPreferencesStateChangeEvent(_AppPreferencesChangeEvent.country);

          return true;
        }

        return false;
      },
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

  Future<bool> setDialysisType(
    DialysisEnum? dialysisType,
  ) {
    return _sharedPreferences
        .then(
      (preferences) => preferences.setString(
        _keyDialysisType,
        (dialysisType ?? DialysisEnum.unknown).name,
      ),
    )
        .then<bool>((v) {
      _postPreferencesStateChangeEvent(_AppPreferencesChangeEvent.dialysis);

      return v;
    });
  }

  Future<DialysisEnum> getDialysisType() {
    return _sharedPreferences.then<DialysisEnum>(
      (preferences) {
        final typeStr = preferences.getString(_keyDialysisType)?.toLowerCase();

        if (typeStr == null) {
          return DialysisEnum.unknown;
        }

        for (final dialysis in DialysisEnum.values) {
          if (dialysis.name.toLowerCase() == typeStr) {
            return dialysis;
          }
        }

        switch (typeStr) {
          case 'automatic':
            return DialysisEnum.automaticPeritonealDialysis;
          case 'manual':
            return DialysisEnum.manualPeritonealDialysis;
          default:
            return DialysisEnum.unknown;
        }
      },
    );
  }

  Stream<DialysisEnum> getDialysisTypeStream() {
    return _buildAppEventsStreamWithInitialEmit(
            _AppPreferencesChangeEvent.dialysis)
        .asyncMap((_) => getDialysisType());
  }

  void _postPreferencesStateChangeEvent(_AppPreferencesChangeEvent event) {
    _preferencesEventsStreamController.add(event);
  }

  Stream<_AppPreferencesChangeEvent> _buildAppEventsStreamWithInitialEmit(
      _AppPreferencesChangeEvent event) {
    return StreamGroup.merge(
      [_preferencesEventsStreamController.stream, Stream.value(event)],
    ).where((e) => e == event);
  }

  Future dispose() {
    return _preferencesEventsStreamController.close();
  }
}
