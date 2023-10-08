// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_general_recommendation_read_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateGeneralRecommendationReadRequest
    extends CreateGeneralRecommendationReadRequest {
  @override
  final int generalRecommendation;

  factory _$CreateGeneralRecommendationReadRequest(
          [void Function(CreateGeneralRecommendationReadRequestBuilder)?
              updates]) =>
      (new CreateGeneralRecommendationReadRequestBuilder()..update(updates))
          ._build();

  _$CreateGeneralRecommendationReadRequest._(
      {required this.generalRecommendation})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(generalRecommendation,
        r'CreateGeneralRecommendationReadRequest', 'generalRecommendation');
  }

  @override
  CreateGeneralRecommendationReadRequest rebuild(
          void Function(CreateGeneralRecommendationReadRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateGeneralRecommendationReadRequestBuilder toBuilder() =>
      new CreateGeneralRecommendationReadRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateGeneralRecommendationReadRequest &&
        generalRecommendation == other.generalRecommendation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, generalRecommendation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'CreateGeneralRecommendationReadRequest')
          ..add('generalRecommendation', generalRecommendation))
        .toString();
  }
}

class CreateGeneralRecommendationReadRequestBuilder
    implements
        Builder<CreateGeneralRecommendationReadRequest,
            CreateGeneralRecommendationReadRequestBuilder> {
  _$CreateGeneralRecommendationReadRequest? _$v;

  int? _generalRecommendation;
  int? get generalRecommendation => _$this._generalRecommendation;
  set generalRecommendation(int? generalRecommendation) =>
      _$this._generalRecommendation = generalRecommendation;

  CreateGeneralRecommendationReadRequestBuilder() {
    CreateGeneralRecommendationReadRequest._defaults(this);
  }

  CreateGeneralRecommendationReadRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _generalRecommendation = $v.generalRecommendation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateGeneralRecommendationReadRequest other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateGeneralRecommendationReadRequest;
  }

  @override
  void update(
      void Function(CreateGeneralRecommendationReadRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateGeneralRecommendationReadRequest build() => _build();

  _$CreateGeneralRecommendationReadRequest _build() {
    final _$result = _$v ??
        new _$CreateGeneralRecommendationReadRequest._(
            generalRecommendation: BuiltValueNullFieldError.checkNotNull(
                generalRecommendation,
                r'CreateGeneralRecommendationReadRequest',
                'generalRecommendation'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
