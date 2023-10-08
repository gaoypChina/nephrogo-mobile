// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IntakeRequest extends IntakeRequest {
  @override
  final int productId;
  @override
  final DateTime consumedAt;
  @override
  final int amountG;
  @override
  final MealTypeEnum? mealType;
  @override
  final int? amountMl;

  factory _$IntakeRequest([void Function(IntakeRequestBuilder)? updates]) =>
      (new IntakeRequestBuilder()..update(updates))._build();

  _$IntakeRequest._(
      {required this.productId,
      required this.consumedAt,
      required this.amountG,
      this.mealType,
      this.amountMl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        productId, r'IntakeRequest', 'productId');
    BuiltValueNullFieldError.checkNotNull(
        consumedAt, r'IntakeRequest', 'consumedAt');
    BuiltValueNullFieldError.checkNotNull(amountG, r'IntakeRequest', 'amountG');
  }

  @override
  IntakeRequest rebuild(void Function(IntakeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IntakeRequestBuilder toBuilder() => new IntakeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IntakeRequest &&
        productId == other.productId &&
        consumedAt == other.consumedAt &&
        amountG == other.amountG &&
        mealType == other.mealType &&
        amountMl == other.amountMl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, consumedAt.hashCode);
    _$hash = $jc(_$hash, amountG.hashCode);
    _$hash = $jc(_$hash, mealType.hashCode);
    _$hash = $jc(_$hash, amountMl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IntakeRequest')
          ..add('productId', productId)
          ..add('consumedAt', consumedAt)
          ..add('amountG', amountG)
          ..add('mealType', mealType)
          ..add('amountMl', amountMl))
        .toString();
  }
}

class IntakeRequestBuilder
    implements Builder<IntakeRequest, IntakeRequestBuilder> {
  _$IntakeRequest? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  DateTime? _consumedAt;
  DateTime? get consumedAt => _$this._consumedAt;
  set consumedAt(DateTime? consumedAt) => _$this._consumedAt = consumedAt;

  int? _amountG;
  int? get amountG => _$this._amountG;
  set amountG(int? amountG) => _$this._amountG = amountG;

  MealTypeEnum? _mealType;
  MealTypeEnum? get mealType => _$this._mealType;
  set mealType(MealTypeEnum? mealType) => _$this._mealType = mealType;

  int? _amountMl;
  int? get amountMl => _$this._amountMl;
  set amountMl(int? amountMl) => _$this._amountMl = amountMl;

  IntakeRequestBuilder() {
    IntakeRequest._defaults(this);
  }

  IntakeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _consumedAt = $v.consumedAt;
      _amountG = $v.amountG;
      _mealType = $v.mealType;
      _amountMl = $v.amountMl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IntakeRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$IntakeRequest;
  }

  @override
  void update(void Function(IntakeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IntakeRequest build() => _build();

  _$IntakeRequest _build() {
    final _$result = _$v ??
        new _$IntakeRequest._(
            productId: BuiltValueNullFieldError.checkNotNull(
                productId, r'IntakeRequest', 'productId'),
            consumedAt: BuiltValueNullFieldError.checkNotNull(
                consumedAt, r'IntakeRequest', 'consumedAt'),
            amountG: BuiltValueNullFieldError.checkNotNull(
                amountG, r'IntakeRequest', 'amountG'),
            mealType: mealType,
            amountMl: amountMl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
