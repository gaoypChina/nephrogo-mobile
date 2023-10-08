// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CountryRequest extends CountryRequest {
  @override
  final String name;
  @override
  final String code;
  @override
  final String flagSvg;
  @override
  final String languageCode;
  @override
  final int? order;

  factory _$CountryRequest([void Function(CountryRequestBuilder)? updates]) =>
      (new CountryRequestBuilder()..update(updates))._build();

  _$CountryRequest._(
      {required this.name,
      required this.code,
      required this.flagSvg,
      required this.languageCode,
      this.order})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'CountryRequest', 'name');
    BuiltValueNullFieldError.checkNotNull(code, r'CountryRequest', 'code');
    BuiltValueNullFieldError.checkNotNull(
        flagSvg, r'CountryRequest', 'flagSvg');
    BuiltValueNullFieldError.checkNotNull(
        languageCode, r'CountryRequest', 'languageCode');
  }

  @override
  CountryRequest rebuild(void Function(CountryRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryRequestBuilder toBuilder() =>
      new CountryRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CountryRequest &&
        name == other.name &&
        code == other.code &&
        flagSvg == other.flagSvg &&
        languageCode == other.languageCode &&
        order == other.order;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, flagSvg.hashCode);
    _$hash = $jc(_$hash, languageCode.hashCode);
    _$hash = $jc(_$hash, order.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CountryRequest')
          ..add('name', name)
          ..add('code', code)
          ..add('flagSvg', flagSvg)
          ..add('languageCode', languageCode)
          ..add('order', order))
        .toString();
  }
}

class CountryRequestBuilder
    implements Builder<CountryRequest, CountryRequestBuilder> {
  _$CountryRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _flagSvg;
  String? get flagSvg => _$this._flagSvg;
  set flagSvg(String? flagSvg) => _$this._flagSvg = flagSvg;

  String? _languageCode;
  String? get languageCode => _$this._languageCode;
  set languageCode(String? languageCode) => _$this._languageCode = languageCode;

  int? _order;
  int? get order => _$this._order;
  set order(int? order) => _$this._order = order;

  CountryRequestBuilder() {
    CountryRequest._defaults(this);
  }

  CountryRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _code = $v.code;
      _flagSvg = $v.flagSvg;
      _languageCode = $v.languageCode;
      _order = $v.order;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CountryRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CountryRequest;
  }

  @override
  void update(void Function(CountryRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CountryRequest build() => _build();

  _$CountryRequest _build() {
    final _$result = _$v ??
        new _$CountryRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CountryRequest', 'name'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'CountryRequest', 'code'),
            flagSvg: BuiltValueNullFieldError.checkNotNull(
                flagSvg, r'CountryRequest', 'flagSvg'),
            languageCode: BuiltValueNullFieldError.checkNotNull(
                languageCode, r'CountryRequest', 'languageCode'),
            order: order);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
