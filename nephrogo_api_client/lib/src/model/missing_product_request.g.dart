// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missing_product_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MissingProductRequest extends MissingProductRequest {
  @override
  final String message;

  factory _$MissingProductRequest(
          [void Function(MissingProductRequestBuilder)? updates]) =>
      (new MissingProductRequestBuilder()..update(updates))._build();

  _$MissingProductRequest._({required this.message}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        message, r'MissingProductRequest', 'message');
  }

  @override
  MissingProductRequest rebuild(
          void Function(MissingProductRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MissingProductRequestBuilder toBuilder() =>
      new MissingProductRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MissingProductRequest && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MissingProductRequest')
          ..add('message', message))
        .toString();
  }
}

class MissingProductRequestBuilder
    implements Builder<MissingProductRequest, MissingProductRequestBuilder> {
  _$MissingProductRequest? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MissingProductRequestBuilder() {
    MissingProductRequest._defaults(this);
  }

  MissingProductRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MissingProductRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MissingProductRequest;
  }

  @override
  void update(void Function(MissingProductRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MissingProductRequest build() => _build();

  _$MissingProductRequest _build() {
    final _$result = _$v ??
        new _$MissingProductRequest._(
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'MissingProductRequest', 'message'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
