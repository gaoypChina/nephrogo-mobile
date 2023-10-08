// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_search_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProductSearchResponse extends ProductSearchResponse {
  @override
  final String query;
  @override
  final BuiltList<Product> products;
  @override
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;

  factory _$ProductSearchResponse(
          [void Function(ProductSearchResponseBuilder)? updates]) =>
      (new ProductSearchResponseBuilder()..update(updates))._build();

  _$ProductSearchResponse._(
      {required this.query,
      required this.products,
      required this.dailyNutrientNormsAndTotals})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        query, r'ProductSearchResponse', 'query');
    BuiltValueNullFieldError.checkNotNull(
        products, r'ProductSearchResponse', 'products');
    BuiltValueNullFieldError.checkNotNull(dailyNutrientNormsAndTotals,
        r'ProductSearchResponse', 'dailyNutrientNormsAndTotals');
  }

  @override
  ProductSearchResponse rebuild(
          void Function(ProductSearchResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductSearchResponseBuilder toBuilder() =>
      new ProductSearchResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductSearchResponse &&
        query == other.query &&
        products == other.products &&
        dailyNutrientNormsAndTotals == other.dailyNutrientNormsAndTotals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, query.hashCode);
    _$hash = $jc(_$hash, products.hashCode);
    _$hash = $jc(_$hash, dailyNutrientNormsAndTotals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductSearchResponse')
          ..add('query', query)
          ..add('products', products)
          ..add('dailyNutrientNormsAndTotals', dailyNutrientNormsAndTotals))
        .toString();
  }
}

class ProductSearchResponseBuilder
    implements Builder<ProductSearchResponse, ProductSearchResponseBuilder> {
  _$ProductSearchResponse? _$v;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  ListBuilder<Product>? _products;
  ListBuilder<Product> get products =>
      _$this._products ??= new ListBuilder<Product>();
  set products(ListBuilder<Product>? products) => _$this._products = products;

  DailyNutrientNormsWithTotalsBuilder? _dailyNutrientNormsAndTotals;
  DailyNutrientNormsWithTotalsBuilder get dailyNutrientNormsAndTotals =>
      _$this._dailyNutrientNormsAndTotals ??=
          new DailyNutrientNormsWithTotalsBuilder();
  set dailyNutrientNormsAndTotals(
          DailyNutrientNormsWithTotalsBuilder? dailyNutrientNormsAndTotals) =>
      _$this._dailyNutrientNormsAndTotals = dailyNutrientNormsAndTotals;

  ProductSearchResponseBuilder() {
    ProductSearchResponse._defaults(this);
  }

  ProductSearchResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _query = $v.query;
      _products = $v.products.toBuilder();
      _dailyNutrientNormsAndTotals = $v.dailyNutrientNormsAndTotals.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductSearchResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductSearchResponse;
  }

  @override
  void update(void Function(ProductSearchResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductSearchResponse build() => _build();

  _$ProductSearchResponse _build() {
    _$ProductSearchResponse _$result;
    try {
      _$result = _$v ??
          new _$ProductSearchResponse._(
              query: BuiltValueNullFieldError.checkNotNull(
                  query, r'ProductSearchResponse', 'query'),
              products: products.build(),
              dailyNutrientNormsAndTotals: dailyNutrientNormsAndTotals.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'products';
        products.build();
        _$failedField = 'dailyNutrientNormsAndTotals';
        dailyNutrientNormsAndTotals.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ProductSearchResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
