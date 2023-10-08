// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Intake extends Intake {
  @override
  final int id;
  @override
  final DateTime consumedAt;
  @override
  final int amountG;
  @override
  final int potassiumMg;
  @override
  final int proteinsMg;
  @override
  final int sodiumMg;
  @override
  final int phosphorusMg;
  @override
  final int energyKcal;
  @override
  final int liquidsMl;
  @override
  final int carbohydratesMg;
  @override
  final int fatMg;
  @override
  final Product product;
  @override
  final MealTypeEnum? mealType;
  @override
  final int? amountMl;

  factory _$Intake([void Function(IntakeBuilder)? updates]) =>
      (new IntakeBuilder()..update(updates))._build();

  _$Intake._(
      {required this.id,
      required this.consumedAt,
      required this.amountG,
      required this.potassiumMg,
      required this.proteinsMg,
      required this.sodiumMg,
      required this.phosphorusMg,
      required this.energyKcal,
      required this.liquidsMl,
      required this.carbohydratesMg,
      required this.fatMg,
      required this.product,
      this.mealType,
      this.amountMl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Intake', 'id');
    BuiltValueNullFieldError.checkNotNull(consumedAt, r'Intake', 'consumedAt');
    BuiltValueNullFieldError.checkNotNull(amountG, r'Intake', 'amountG');
    BuiltValueNullFieldError.checkNotNull(
        potassiumMg, r'Intake', 'potassiumMg');
    BuiltValueNullFieldError.checkNotNull(proteinsMg, r'Intake', 'proteinsMg');
    BuiltValueNullFieldError.checkNotNull(sodiumMg, r'Intake', 'sodiumMg');
    BuiltValueNullFieldError.checkNotNull(
        phosphorusMg, r'Intake', 'phosphorusMg');
    BuiltValueNullFieldError.checkNotNull(energyKcal, r'Intake', 'energyKcal');
    BuiltValueNullFieldError.checkNotNull(liquidsMl, r'Intake', 'liquidsMl');
    BuiltValueNullFieldError.checkNotNull(
        carbohydratesMg, r'Intake', 'carbohydratesMg');
    BuiltValueNullFieldError.checkNotNull(fatMg, r'Intake', 'fatMg');
    BuiltValueNullFieldError.checkNotNull(product, r'Intake', 'product');
  }

  @override
  Intake rebuild(void Function(IntakeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IntakeBuilder toBuilder() => new IntakeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Intake &&
        id == other.id &&
        consumedAt == other.consumedAt &&
        amountG == other.amountG &&
        potassiumMg == other.potassiumMg &&
        proteinsMg == other.proteinsMg &&
        sodiumMg == other.sodiumMg &&
        phosphorusMg == other.phosphorusMg &&
        energyKcal == other.energyKcal &&
        liquidsMl == other.liquidsMl &&
        carbohydratesMg == other.carbohydratesMg &&
        fatMg == other.fatMg &&
        product == other.product &&
        mealType == other.mealType &&
        amountMl == other.amountMl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, consumedAt.hashCode);
    _$hash = $jc(_$hash, amountG.hashCode);
    _$hash = $jc(_$hash, potassiumMg.hashCode);
    _$hash = $jc(_$hash, proteinsMg.hashCode);
    _$hash = $jc(_$hash, sodiumMg.hashCode);
    _$hash = $jc(_$hash, phosphorusMg.hashCode);
    _$hash = $jc(_$hash, energyKcal.hashCode);
    _$hash = $jc(_$hash, liquidsMl.hashCode);
    _$hash = $jc(_$hash, carbohydratesMg.hashCode);
    _$hash = $jc(_$hash, fatMg.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jc(_$hash, mealType.hashCode);
    _$hash = $jc(_$hash, amountMl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Intake')
          ..add('id', id)
          ..add('consumedAt', consumedAt)
          ..add('amountG', amountG)
          ..add('potassiumMg', potassiumMg)
          ..add('proteinsMg', proteinsMg)
          ..add('sodiumMg', sodiumMg)
          ..add('phosphorusMg', phosphorusMg)
          ..add('energyKcal', energyKcal)
          ..add('liquidsMl', liquidsMl)
          ..add('carbohydratesMg', carbohydratesMg)
          ..add('fatMg', fatMg)
          ..add('product', product)
          ..add('mealType', mealType)
          ..add('amountMl', amountMl))
        .toString();
  }
}

class IntakeBuilder implements Builder<Intake, IntakeBuilder> {
  _$Intake? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  DateTime? _consumedAt;
  DateTime? get consumedAt => _$this._consumedAt;
  set consumedAt(DateTime? consumedAt) => _$this._consumedAt = consumedAt;

  int? _amountG;
  int? get amountG => _$this._amountG;
  set amountG(int? amountG) => _$this._amountG = amountG;

  int? _potassiumMg;
  int? get potassiumMg => _$this._potassiumMg;
  set potassiumMg(int? potassiumMg) => _$this._potassiumMg = potassiumMg;

  int? _proteinsMg;
  int? get proteinsMg => _$this._proteinsMg;
  set proteinsMg(int? proteinsMg) => _$this._proteinsMg = proteinsMg;

  int? _sodiumMg;
  int? get sodiumMg => _$this._sodiumMg;
  set sodiumMg(int? sodiumMg) => _$this._sodiumMg = sodiumMg;

  int? _phosphorusMg;
  int? get phosphorusMg => _$this._phosphorusMg;
  set phosphorusMg(int? phosphorusMg) => _$this._phosphorusMg = phosphorusMg;

  int? _energyKcal;
  int? get energyKcal => _$this._energyKcal;
  set energyKcal(int? energyKcal) => _$this._energyKcal = energyKcal;

  int? _liquidsMl;
  int? get liquidsMl => _$this._liquidsMl;
  set liquidsMl(int? liquidsMl) => _$this._liquidsMl = liquidsMl;

  int? _carbohydratesMg;
  int? get carbohydratesMg => _$this._carbohydratesMg;
  set carbohydratesMg(int? carbohydratesMg) =>
      _$this._carbohydratesMg = carbohydratesMg;

  int? _fatMg;
  int? get fatMg => _$this._fatMg;
  set fatMg(int? fatMg) => _$this._fatMg = fatMg;

  ProductBuilder? _product;
  ProductBuilder get product => _$this._product ??= new ProductBuilder();
  set product(ProductBuilder? product) => _$this._product = product;

  MealTypeEnum? _mealType;
  MealTypeEnum? get mealType => _$this._mealType;
  set mealType(MealTypeEnum? mealType) => _$this._mealType = mealType;

  int? _amountMl;
  int? get amountMl => _$this._amountMl;
  set amountMl(int? amountMl) => _$this._amountMl = amountMl;

  IntakeBuilder() {
    Intake._defaults(this);
  }

  IntakeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _consumedAt = $v.consumedAt;
      _amountG = $v.amountG;
      _potassiumMg = $v.potassiumMg;
      _proteinsMg = $v.proteinsMg;
      _sodiumMg = $v.sodiumMg;
      _phosphorusMg = $v.phosphorusMg;
      _energyKcal = $v.energyKcal;
      _liquidsMl = $v.liquidsMl;
      _carbohydratesMg = $v.carbohydratesMg;
      _fatMg = $v.fatMg;
      _product = $v.product.toBuilder();
      _mealType = $v.mealType;
      _amountMl = $v.amountMl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Intake other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Intake;
  }

  @override
  void update(void Function(IntakeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Intake build() => _build();

  _$Intake _build() {
    _$Intake _$result;
    try {
      _$result = _$v ??
          new _$Intake._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'Intake', 'id'),
              consumedAt: BuiltValueNullFieldError.checkNotNull(
                  consumedAt, r'Intake', 'consumedAt'),
              amountG: BuiltValueNullFieldError.checkNotNull(
                  amountG, r'Intake', 'amountG'),
              potassiumMg: BuiltValueNullFieldError.checkNotNull(
                  potassiumMg, r'Intake', 'potassiumMg'),
              proteinsMg: BuiltValueNullFieldError.checkNotNull(
                  proteinsMg, r'Intake', 'proteinsMg'),
              sodiumMg: BuiltValueNullFieldError.checkNotNull(
                  sodiumMg, r'Intake', 'sodiumMg'),
              phosphorusMg: BuiltValueNullFieldError.checkNotNull(
                  phosphorusMg, r'Intake', 'phosphorusMg'),
              energyKcal: BuiltValueNullFieldError.checkNotNull(
                  energyKcal, r'Intake', 'energyKcal'),
              liquidsMl: BuiltValueNullFieldError.checkNotNull(
                  liquidsMl, r'Intake', 'liquidsMl'),
              carbohydratesMg: BuiltValueNullFieldError.checkNotNull(
                  carbohydratesMg, r'Intake', 'carbohydratesMg'),
              fatMg: BuiltValueNullFieldError.checkNotNull(
                  fatMg, r'Intake', 'fatMg'),
              product: product.build(),
              mealType: mealType,
              amountMl: amountMl);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'product';
        product.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Intake', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
