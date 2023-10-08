// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_recommendation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GeneralRecommendation extends GeneralRecommendation {
  @override
  final int id;
  @override
  final String name;
  @override
  final String body;

  factory _$GeneralRecommendation(
          [void Function(GeneralRecommendationBuilder)? updates]) =>
      (new GeneralRecommendationBuilder()..update(updates))._build();

  _$GeneralRecommendation._(
      {required this.id, required this.name, required this.body})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GeneralRecommendation', 'id');
    BuiltValueNullFieldError.checkNotNull(
        name, r'GeneralRecommendation', 'name');
    BuiltValueNullFieldError.checkNotNull(
        body, r'GeneralRecommendation', 'body');
  }

  @override
  GeneralRecommendation rebuild(
          void Function(GeneralRecommendationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeneralRecommendationBuilder toBuilder() =>
      new GeneralRecommendationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneralRecommendation &&
        id == other.id &&
        name == other.name &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GeneralRecommendation')
          ..add('id', id)
          ..add('name', name)
          ..add('body', body))
        .toString();
  }
}

class GeneralRecommendationBuilder
    implements Builder<GeneralRecommendation, GeneralRecommendationBuilder> {
  _$GeneralRecommendation? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  GeneralRecommendationBuilder() {
    GeneralRecommendation._defaults(this);
  }

  GeneralRecommendationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeneralRecommendation other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GeneralRecommendation;
  }

  @override
  void update(void Function(GeneralRecommendationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeneralRecommendation build() => _build();

  _$GeneralRecommendation _build() {
    final _$result = _$v ??
        new _$GeneralRecommendation._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GeneralRecommendation', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'GeneralRecommendation', 'name'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'GeneralRecommendation', 'body'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
