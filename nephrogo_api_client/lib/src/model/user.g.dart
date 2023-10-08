// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final NutritionSummaryStatistics nutritionSummary;
  @override
  final Country? selectedCountry;
  @override
  final bool? isMarketingAllowed;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates))._build();

  _$User._(
      {required this.nutritionSummary,
      this.selectedCountry,
      this.isMarketingAllowed})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        nutritionSummary, r'User', 'nutritionSummary');
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        nutritionSummary == other.nutritionSummary &&
        selectedCountry == other.selectedCountry &&
        isMarketingAllowed == other.isMarketingAllowed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nutritionSummary.hashCode);
    _$hash = $jc(_$hash, selectedCountry.hashCode);
    _$hash = $jc(_$hash, isMarketingAllowed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('nutritionSummary', nutritionSummary)
          ..add('selectedCountry', selectedCountry)
          ..add('isMarketingAllowed', isMarketingAllowed))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  NutritionSummaryStatisticsBuilder? _nutritionSummary;
  NutritionSummaryStatisticsBuilder get nutritionSummary =>
      _$this._nutritionSummary ??= new NutritionSummaryStatisticsBuilder();
  set nutritionSummary(NutritionSummaryStatisticsBuilder? nutritionSummary) =>
      _$this._nutritionSummary = nutritionSummary;

  CountryBuilder? _selectedCountry;
  CountryBuilder get selectedCountry =>
      _$this._selectedCountry ??= new CountryBuilder();
  set selectedCountry(CountryBuilder? selectedCountry) =>
      _$this._selectedCountry = selectedCountry;

  bool? _isMarketingAllowed;
  bool? get isMarketingAllowed => _$this._isMarketingAllowed;
  set isMarketingAllowed(bool? isMarketingAllowed) =>
      _$this._isMarketingAllowed = isMarketingAllowed;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nutritionSummary = $v.nutritionSummary.toBuilder();
      _selectedCountry = $v.selectedCountry?.toBuilder();
      _isMarketingAllowed = $v.isMarketingAllowed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
              nutritionSummary: nutritionSummary.build(),
              selectedCountry: _selectedCountry?.build(),
              isMarketingAllowed: isMarketingAllowed);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'nutritionSummary';
        nutritionSummary.build();
        _$failedField = 'selectedCountry';
        _selectedCountry?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
