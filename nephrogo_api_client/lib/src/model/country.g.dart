// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Country extends Country {
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

  factory _$Country([void Function(CountryBuilder)? updates]) =>
      (new CountryBuilder()..update(updates))._build();

  _$Country._(
      {required this.name,
      required this.code,
      required this.flagSvg,
      required this.languageCode,
      this.order})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(name, r'Country', 'name');
    BuiltValueNullFieldError.checkNotNull(code, r'Country', 'code');
    BuiltValueNullFieldError.checkNotNull(flagSvg, r'Country', 'flagSvg');
    BuiltValueNullFieldError.checkNotNull(
        languageCode, r'Country', 'languageCode');
  }

  @override
  Country rebuild(void Function(CountryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryBuilder toBuilder() => new CountryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Country &&
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
    return (newBuiltValueToStringHelper(r'Country')
          ..add('name', name)
          ..add('code', code)
          ..add('flagSvg', flagSvg)
          ..add('languageCode', languageCode)
          ..add('order', order))
        .toString();
  }
}

class CountryBuilder implements Builder<Country, CountryBuilder> {
  _$Country? _$v;

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

  CountryBuilder() {
    Country._defaults(this);
  }

  CountryBuilder get _$this {
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
  void replace(Country other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Country;
  }

  @override
  void update(void Function(CountryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Country build() => _build();

  _$Country _build() {
    final _$result = _$v ??
        new _$Country._(
            name:
                BuiltValueNullFieldError.checkNotNull(name, r'Country', 'name'),
            code:
                BuiltValueNullFieldError.checkNotNull(code, r'Country', 'code'),
            flagSvg: BuiltValueNullFieldError.checkNotNull(
                flagSvg, r'Country', 'flagSvg'),
            languageCode: BuiltValueNullFieldError.checkNotNull(
                languageCode, r'Country', 'languageCode'),
            order: order);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
