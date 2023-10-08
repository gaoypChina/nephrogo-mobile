// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swelling_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SwellingRequest extends SwellingRequest {
  @override
  final SwellingEnum swelling;

  factory _$SwellingRequest([void Function(SwellingRequestBuilder)? updates]) =>
      (new SwellingRequestBuilder()..update(updates))._build();

  _$SwellingRequest._({required this.swelling}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        swelling, r'SwellingRequest', 'swelling');
  }

  @override
  SwellingRequest rebuild(void Function(SwellingRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SwellingRequestBuilder toBuilder() =>
      new SwellingRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SwellingRequest && swelling == other.swelling;
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
    return (newBuiltValueToStringHelper(r'SwellingRequest')
          ..add('swelling', swelling))
        .toString();
  }
}

class SwellingRequestBuilder
    implements Builder<SwellingRequest, SwellingRequestBuilder> {
  _$SwellingRequest? _$v;

  SwellingEnum? _swelling;
  SwellingEnum? get swelling => _$this._swelling;
  set swelling(SwellingEnum? swelling) => _$this._swelling = swelling;

  SwellingRequestBuilder() {
    SwellingRequest._defaults(this);
  }

  SwellingRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _swelling = $v.swelling;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SwellingRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SwellingRequest;
  }

  @override
  void update(void Function(SwellingRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SwellingRequest build() => _build();

  _$SwellingRequest _build() {
    final _$result = _$v ??
        new _$SwellingRequest._(
            swelling: BuiltValueNullFieldError.checkNotNull(
                swelling, r'SwellingRequest', 'swelling'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
