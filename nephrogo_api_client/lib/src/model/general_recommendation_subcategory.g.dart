// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_recommendation_subcategory.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GeneralRecommendationSubcategory
    extends GeneralRecommendationSubcategory {
  @override
  final String name;
  @override
  final BuiltList<GeneralRecommendation> recommendations;

  factory _$GeneralRecommendationSubcategory(
          [void Function(GeneralRecommendationSubcategoryBuilder)? updates]) =>
      (new GeneralRecommendationSubcategoryBuilder()..update(updates))._build();

  _$GeneralRecommendationSubcategory._(
      {required this.name, required this.recommendations})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        name, r'GeneralRecommendationSubcategory', 'name');
    BuiltValueNullFieldError.checkNotNull(recommendations,
        r'GeneralRecommendationSubcategory', 'recommendations');
  }

  @override
  GeneralRecommendationSubcategory rebuild(
          void Function(GeneralRecommendationSubcategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneralRecommendationSubcategoryBuilder toBuilder() =>
      new GeneralRecommendationSubcategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneralRecommendationSubcategory &&
        name == other.name &&
        recommendations == other.recommendations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, recommendations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GeneralRecommendationSubcategory')
          ..add('name', name)
          ..add('recommendations', recommendations))
        .toString();
  }
}

class GeneralRecommendationSubcategoryBuilder
    implements
        Builder<GeneralRecommendationSubcategory,
            GeneralRecommendationSubcategoryBuilder> {
  _$GeneralRecommendationSubcategory? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ListBuilder<GeneralRecommendation>? _recommendations;
  ListBuilder<GeneralRecommendation> get recommendations =>
      _$this._recommendations ??= new ListBuilder<GeneralRecommendation>();
  set recommendations(ListBuilder<GeneralRecommendation>? recommendations) =>
      _$this._recommendations = recommendations;

  GeneralRecommendationSubcategoryBuilder() {
    GeneralRecommendationSubcategory._defaults(this);
  }

  GeneralRecommendationSubcategoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _recommendations = $v.recommendations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeneralRecommendationSubcategory other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GeneralRecommendationSubcategory;
  }

  @override
  void update(void Function(GeneralRecommendationSubcategoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeneralRecommendationSubcategory build() => _build();

  _$GeneralRecommendationSubcategory _build() {
    _$GeneralRecommendationSubcategory _$result;
    try {
      _$result = _$v ??
          new _$GeneralRecommendationSubcategory._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'GeneralRecommendationSubcategory', 'name'),
              recommendations: recommendations.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recommendations';
        recommendations.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GeneralRecommendationSubcategory', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
