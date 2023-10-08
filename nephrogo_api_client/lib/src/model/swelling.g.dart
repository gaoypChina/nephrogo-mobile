// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swelling.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Swelling extends Swelling {
  @override
  final SwellingEnum swelling;

  factory _$Swelling([void Function(SwellingBuilder)? updates]) =>
      (new SwellingBuilder()..update(updates))._build();

  _$Swelling._({required this.swelling}) : super._() {
    BuiltValueNullFieldError.checkNotNull(swelling, r'Swelling', 'swelling');
  }

  @override
  Swelling rebuild(void Function(SwellingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SwellingBuilder toBuilder() => new SwellingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Swelling && swelling == other.swelling;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, swelling.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Swelling')..add('swelling', swelling))
        .toString();
  }
}

class SwellingBuilder implements Builder<Swelling, SwellingBuilder> {
  _$Swelling? _$v;

  SwellingEnum? _swelling;
  SwellingEnum? get swelling => _$this._swelling;
  set swelling(SwellingEnum? swelling) => _$this._swelling = swelling;

  SwellingBuilder() {
    Swelling._defaults(this);
  }

  SwellingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _swelling = $v.swelling;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Swelling other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Swelling;
  }

  @override
  void update(void Function(SwellingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Swelling build() => _build();

  _$Swelling _build() {
    final _$result = _$v ??
        new _$Swelling._(
            swelling: BuiltValueNullFieldError.checkNotNull(
                swelling, r'Swelling', 'swelling'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
