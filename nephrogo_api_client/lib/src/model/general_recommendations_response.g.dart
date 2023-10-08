// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_recommendations_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GeneralRecommendationsResponse extends GeneralRecommendationsResponse {
  @override
  final BuiltList<int> readRecommendationIds;
  @override
  final BuiltList<GeneralRecommendationCategory> categories;

  factory _$GeneralRecommendationsResponse(
          [void Function(GeneralRecommendationsResponseBuilder)? updates]) =>
      (new GeneralRecommendationsResponseBuilder()..update(updates))._build();

  _$GeneralRecommendationsResponse._(
      {required this.readRecommendationIds, required this.categories})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(readRecommendationIds,
        r'GeneralRecommendationsResponse', 'readRecommendationIds');
    BuiltValueNullFieldError.checkNotNull(
        categories, r'GeneralRecommendationsResponse', 'categories');
  }

  @override
  GeneralRecommendationsResponse rebuild(
          void Function(GeneralRecommendationsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneralRecommendationsResponseBuilder toBuilder() =>
      new GeneralRecommendationsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneralRecommendationsResponse &&
        readRecommendationIds == other.readRecommendationIds &&
        categories == other.categories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, readRecommendationIds.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GeneralRecommendationsResponse')
          ..add('readRecommendationIds', readRecommendationIds)
          ..add('categories', categories))
        .toString();
  }
}

class GeneralRecommendationsResponseBuilder
    implements
        Builder<GeneralRecommendationsResponse,
            GeneralRecommendationsResponseBuilder> {
  _$GeneralRecommendationsResponse? _$v;

  ListBuilder<int>? _readRecommendationIds;
  ListBuilder<int> get readRecommendationIds =>
      _$this._readRecommendationIds ??= new ListBuilder<int>();
  set readRecommendationIds(ListBuilder<int>? readRecommendationIds) =>
      _$this._readRecommendationIds = readRecommendationIds;

  ListBuilder<GeneralRecommendationCategory>? _categories;
  ListBuilder<GeneralRecommendationCategory> get categories =>
      _$this._categories ??= new ListBuilder<GeneralRecommendationCategory>();
  set categories(ListBuilder<GeneralRecommendationCategory>? categories) =>
      _$this._categories = categories;

  GeneralRecommendationsResponseBuilder() {
    GeneralRecommendationsResponse._defaults(this);
  }

  GeneralRecommendationsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _readRecommendationIds = $v.readRecommendationIds.toBuilder();
      _categories = $v.categories.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeneralRecommendationsResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GeneralRecommendationsResponse;
  }

  @override
  void update(void Function(GeneralRecommendationsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeneralRecommendationsResponse build() => _build();

  _$GeneralRecommendationsResponse _build() {
    _$GeneralRecommendationsResponse _$result;
    try {
      _$result = _$v ??
          new _$GeneralRecommendationsResponse._(
              readRecommendationIds: readRecommendationIds.build(),
              categories: categories.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'readRecommendationIds';
        readRecommendationIds.build();
        _$failedField = 'categories';
        categories.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GeneralRecommendationsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
