// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_general_recommendation_read.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateGeneralRecommendationRead
    extends CreateGeneralRecommendationRead {
  @override
  final int generalRecommendation;

  factory _$CreateGeneralRecommendationRead(
          [void Function(CreateGeneralRecommendationReadBuilder)? updates]) =>
      (new CreateGeneralRecommendationReadBuilder()..update(updates))._build();

  _$CreateGeneralRecommendationRead._({required this.generalRecommendation})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(generalRecommendation,
        r'CreateGeneralRecommendationRead', 'generalRecommendation');
  }

  @override
  CreateGeneralRecommendationRead rebuild(
          void Function(CreateGeneralRecommendationReadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateGeneralRecommendationReadBuilder toBuilder() =>
      new CreateGeneralRecommendationReadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateGeneralRecommendationRead &&
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
    return (newBuiltValueToStringHelper(r'CreateGeneralRecommendationRead')
          ..add('generalRecommendation', generalRecommendation))
        .toString();
  }
}

class CreateGeneralRecommendationReadBuilder
    implements
        Builder<CreateGeneralRecommendationRead,
            CreateGeneralRecommendationReadBuilder> {
  _$CreateGeneralRecommendationRead? _$v;

  int? _generalRecommendation;
  int? get generalRecommendation => _$this._generalRecommendation;
  set generalRecommendation(int? generalRecommendation) =>
      _$this._generalRecommendation = generalRecommendation;

  CreateGeneralRecommendationReadBuilder() {
    CreateGeneralRecommendationRead._defaults(this);
  }

  CreateGeneralRecommendationReadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _generalRecommendation = $v.generalRecommendation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateGeneralRecommendationRead other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateGeneralRecommendationRead;
  }

  @override
  void update(void Function(CreateGeneralRecommendationReadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateGeneralRecommendationRead build() => _build();

  _$CreateGeneralRecommendationRead _build() {
    final _$result = _$v ??
        new _$CreateGeneralRecommendationRead._(
            generalRecommendation: BuiltValueNullFieldError.checkNotNull(
                generalRecommendation,
                r'CreateGeneralRecommendationRead',
                'generalRecommendation'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
