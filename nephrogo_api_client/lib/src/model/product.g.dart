// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Product extends Product {
  @override
  final int id;
  @override
  final String name;
  @override
  final double potassiumMg;
  @override
  final int proteinsMg;
  @override
  final double sodiumMg;
  @override
  final double phosphorusMg;
  @override
  final int energyKcal;
  @override
  final int liquidsMl;
  @override
  final int carbohydratesMg;
  @override
  final int fatMg;
  @override
  final ProductKindEnum? productKind;
  @override
  final double? densityGMl;

  factory _$Product([void Function(ProductBuilder)? updates]) =>
      (new ProductBuilder()..update(updates))._build();

  _$Product._(
      {required this.id,
      required this.name,
      required this.potassiumMg,
      required this.proteinsMg,
      required this.sodiumMg,
      required this.phosphorusMg,
      required this.energyKcal,
      required this.liquidsMl,
      required this.carbohydratesMg,
      required this.fatMg,
      this.productKind,
      this.densityGMl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Product', 'id');
    BuiltValueNullFieldError.checkNotNull(name, r'Product', 'name');
    BuiltValueNullFieldError.checkNotNull(
        potassiumMg, r'Product', 'potassiumMg');
    BuiltValueNullFieldError.checkNotNull(proteinsMg, r'Product', 'proteinsMg');
    BuiltValueNullFieldError.checkNotNull(sodiumMg, r'Product', 'sodiumMg');
    BuiltValueNullFieldError.checkNotNull(
        phosphorusMg, r'Product', 'phosphorusMg');
    BuiltValueNullFieldError.checkNotNull(energyKcal, r'Product', 'energyKcal');
    BuiltValueNullFieldError.checkNotNull(liquidsMl, r'Product', 'liquidsMl');
    BuiltValueNullFieldError.checkNotNull(
        carbohydratesMg, r'Product', 'carbohydratesMg');
    BuiltValueNullFieldError.checkNotNull(fatMg, r'Product', 'fatMg');
  }

  @override
  Product rebuild(void Function(ProductBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductBuilder toBuilder() => new ProductBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Product &&
        id == other.id &&
        name == other.name &&
        potassiumMg == other.potassiumMg &&
        proteinsMg == other.proteinsMg &&
        sodiumMg == other.sodiumMg &&
        phosphorusMg == other.phosphorusMg &&
        energyKcal == other.energyKcal &&
        liquidsMl == other.liquidsMl &&
        carbohydratesMg == other.carbohydratesMg &&
        fatMg == other.fatMg &&
        productKind == other.productKind &&
        densityGMl == other.densityGMl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, potassiumMg.hashCode);
    _$hash = $jc(_$hash, proteinsMg.hashCode);
    _$hash = $jc(_$hash, sodiumMg.hashCode);
    _$hash = $jc(_$hash, phosphorusMg.hashCode);
    _$hash = $jc(_$hash, energyKcal.hashCode);
    _$hash = $jc(_$hash, liquidsMl.hashCode);
    _$hash = $jc(_$hash, carbohydratesMg.hashCode);
    _$hash = $jc(_$hash, fatMg.hashCode);
    _$hash = $jc(_$hash, productKind.hashCode);
    _$hash = $jc(_$hash, densityGMl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Product')
          ..add('id', id)
          ..add('name', name)
          ..add('potassiumMg', potassiumMg)
          ..add('proteinsMg', proteinsMg)
          ..add('sodiumMg', sodiumMg)
          ..add('phosphorusMg', phosphorusMg)
          ..add('energyKcal', energyKcal)
          ..add('liquidsMl', liquidsMl)
          ..add('carbohydratesMg', carbohydratesMg)
          ..add('fatMg', fatMg)
          ..add('productKind', productKind)
          ..add('densityGMl', densityGMl))
        .toString();
  }
}

class ProductBuilder implements Builder<Product, ProductBuilder> {
  _$Product? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  double? _potassiumMg;
  double? get potassiumMg => _$this._potassiumMg;
  set potassiumMg(double? potassiumMg) => _$this._potassiumMg = potassiumMg;

  int? _proteinsMg;
  int? get proteinsMg => _$this._proteinsMg;
  set proteinsMg(int? proteinsMg) => _$this._proteinsMg = proteinsMg;

  double? _sodiumMg;
  double? get sodiumMg => _$this._sodiumMg;
  set sodiumMg(double? sodiumMg) => _$this._sodiumMg = sodiumMg;

  double? _phosphorusMg;
  double? get phosphorusMg => _$this._phosphorusMg;
  set phosphorusMg(double? phosphorusMg) => _$this._phosphorusMg = phosphorusMg;

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

  ProductKindEnum? _productKind;
  ProductKindEnum? get productKind => _$this._productKind;
  set productKind(ProductKindEnum? productKind) =>
      _$this._productKind = productKind;

  double? _densityGMl;
  double? get densityGMl => _$this._densityGMl;
  set densityGMl(double? densityGMl) => _$this._densityGMl = densityGMl;

  ProductBuilder() {
    Product._defaults(this);
  }

  ProductBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _potassiumMg = $v.potassiumMg;
      _proteinsMg = $v.proteinsMg;
      _sodiumMg = $v.sodiumMg;
      _phosphorusMg = $v.phosphorusMg;
      _energyKcal = $v.energyKcal;
      _liquidsMl = $v.liquidsMl;
      _carbohydratesMg = $v.carbohydratesMg;
      _fatMg = $v.fatMg;
      _productKind = $v.productKind;
      _densityGMl = $v.densityGMl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Product other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Product;
  }

  @override
  void update(void Function(ProductBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Product build() => _build();

  _$Product _build() {
    final _$result = _$v ??
        new _$Product._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Product', 'id'),
            name:
                BuiltValueNullFieldError.checkNotNull(name, r'Product', 'name'),
            potassiumMg: BuiltValueNullFieldError.checkNotNull(
                potassiumMg, r'Product', 'potassiumMg'),
            proteinsMg: BuiltValueNullFieldError.checkNotNull(
                proteinsMg, r'Product', 'proteinsMg'),
            sodiumMg: BuiltValueNullFieldError.checkNotNull(
                sodiumMg, r'Product', 'sodiumMg'),
            phosphorusMg: BuiltValueNullFieldError.checkNotNull(
                phosphorusMg, r'Product', 'phosphorusMg'),
            energyKcal: BuiltValueNullFieldError.checkNotNull(
                energyKcal, r'Product', 'energyKcal'),
            liquidsMl: BuiltValueNullFieldError.checkNotNull(
                liquidsMl, r'Product', 'liquidsMl'),
            carbohydratesMg: BuiltValueNullFieldError.checkNotNull(
                carbohydratesMg, r'Product', 'carbohydratesMg'),
            fatMg: BuiltValueNullFieldError.checkNotNull(
                fatMg, r'Product', 'fatMg'),
            productKind: productKind,
            densityGMl: densityGMl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
