// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_recommendation_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GeneralRecommendationCategory extends GeneralRecommendationCategory {
  @override
  final String name;
  @override
  final BuiltList<GeneralRecommendationSubcategory> subcategories;

  factory _$GeneralRecommendationCategory(
          [void Function(GeneralRecommendationCategoryBuilder)? updates]) =>
      (new GeneralRecommendationCategoryBuilder()..update(updates))._build();

  _$GeneralRecommendationCategory._(
      {required this.name, required this.subcategories})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        name, r'GeneralRecommendationCategory', 'name');
    BuiltValueNullFieldError.checkNotNull(
        subcategories, r'GeneralRecommendationCategory', 'subcategories');
  }

  @override
  GeneralRecommendationCategory rebuild(
          void Function(GeneralRecommendationCategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneralRecommendationCategoryBuilder toBuilder() =>
      new GeneralRecommendationCategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneralRecommendationCategory &&
        name == other.name &&
        subcategories == other.subcategories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, subcategories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GeneralRecommendationCategory')
          ..add('name', name)
          ..add('subcategories', subcategories))
        .toString();
  }
}

class GeneralRecommendationCategoryBuilder
    implements
        Builder<GeneralRecommendationCategory,
            GeneralRecommendationCategoryBuilder> {
  _$GeneralRecommendationCategory? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ListBuilder<GeneralRecommendationSubcategory>? _subcategories;
  ListBuilder<GeneralRecommendationSubcategory> get subcategories =>
      _$this._subcategories ??=
          new ListBuilder<GeneralRecommendationSubcategory>();
  set subcategories(
          ListBuilder<GeneralRecommendationSubcategory>? subcategories) =>
      _$this._subcategories = subcategories;

  GeneralRecommendationCategoryBuilder() {
    GeneralRecommendationCategory._defaults(this);
  }

  GeneralRecommendationCategoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _subcategories = $v.subcategories.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeneralRecommendationCategory other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GeneralRecommendationCategory;
  }

  @override
  void update(void Function(GeneralRecommendationCategoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeneralRecommendationCategory build() => _build();

  _$GeneralRecommendationCategory _build() {
    _$GeneralRecommendationCategory _$result;
    try {
      _$result = _$v ??
          new _$GeneralRecommendationCategory._(
              name: BuiltValueNullFieldError.checkNotNull(
                  name, r'GeneralRecommendationCategory', 'name'),
              subcategories: subcategories.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'subcategories';
        subcategories.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GeneralRecommendationCategory', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
