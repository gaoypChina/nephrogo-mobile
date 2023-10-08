// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserRequest extends UserRequest {
  @override
  final bool? isMarketingAllowed;
  @override
  final String? selectedCountryCode;

  factory _$UserRequest([void Function(UserRequestBuilder)? updates]) =>
      (new UserRequestBuilder()..update(updates))._build();

  _$UserRequest._({this.isMarketingAllowed, this.selectedCountryCode})
      : super._();

  @override
  UserRequest rebuild(void Function(UserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserRequestBuilder toBuilder() => new UserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserRequest &&
        isMarketingAllowed == other.isMarketingAllowed &&
        selectedCountryCode == other.selectedCountryCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isMarketingAllowed.hashCode);
    _$hash = $jc(_$hash, selectedCountryCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserRequest')
          ..add('isMarketingAllowed', isMarketingAllowed)
          ..add('selectedCountryCode', selectedCountryCode))
        .toString();
  }
}

class UserRequestBuilder implements Builder<UserRequest, UserRequestBuilder> {
  _$UserRequest? _$v;

  bool? _isMarketingAllowed;
  bool? get isMarketingAllowed => _$this._isMarketingAllowed;
  set isMarketingAllowed(bool? isMarketingAllowed) =>
      _$this._isMarketingAllowed = isMarketingAllowed;

  String? _selectedCountryCode;
  String? get selectedCountryCode => _$this._selectedCountryCode;
  set selectedCountryCode(String? selectedCountryCode) =>
      _$this._selectedCountryCode = selectedCountryCode;

  UserRequestBuilder() {
    UserRequest._defaults(this);
  }

  UserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isMarketingAllowed = $v.isMarketingAllowed;
      _selectedCountryCode = $v.selectedCountryCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserRequest;
  }

  @override
  void update(void Function(UserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserRequest build() => _build();

  _$UserRequest _build() {
    final _$result = _$v ??
        new _$UserRequest._(
            isMarketingAllowed: isMarketingAllowed,
            selectedCountryCode: selectedCountryCode);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
