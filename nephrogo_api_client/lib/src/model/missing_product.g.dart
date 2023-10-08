// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missing_product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MissingProduct extends MissingProduct {
  @override
  final String message;

  factory _$MissingProduct([void Function(MissingProductBuilder)? updates]) =>
      (new MissingProductBuilder()..update(updates))._build();

  _$MissingProduct._({required this.message}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        message, r'MissingProduct', 'message');
  }

  @override
  MissingProduct rebuild(void Function(MissingProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MissingProductBuilder toBuilder() =>
      new MissingProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MissingProduct && message == other.message;
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
    return (newBuiltValueToStringHelper(r'MissingProduct')
          ..add('message', message))
        .toString();
  }
}

class MissingProductBuilder
    implements Builder<MissingProduct, MissingProductBuilder> {
  _$MissingProduct? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MissingProductBuilder() {
    MissingProduct._defaults(this);
  }

  MissingProductBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MissingProduct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$MissingProduct;
  }

  @override
  void update(void Function(MissingProductBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MissingProduct build() => _build();

  _$MissingProduct _build() {
    final _$result = _$v ??
        new _$MissingProduct._(
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'MissingProduct', 'message'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
