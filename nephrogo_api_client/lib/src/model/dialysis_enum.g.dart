// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialysis_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DialysisEnum _$unknown = const DialysisEnum._('unknown');
const DialysisEnum _$automaticPeritonealDialysis =
    const DialysisEnum._('automaticPeritonealDialysis');
const DialysisEnum _$manualPeritonealDialysis =
    const DialysisEnum._('manualPeritonealDialysis');
const DialysisEnum _$hemodialysis = const DialysisEnum._('hemodialysis');
const DialysisEnum _$postTransplant = const DialysisEnum._('postTransplant');
const DialysisEnum _$notPerformed = const DialysisEnum._('notPerformed');

DialysisEnum _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'automaticPeritonealDialysis':
      return _$automaticPeritonealDialysis;
    case 'manualPeritonealDialysis':
      return _$manualPeritonealDialysis;
    case 'hemodialysis':
      return _$hemodialysis;
    case 'postTransplant':
      return _$postTransplant;
    case 'notPerformed':
      return _$notPerformed;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DialysisEnum> _$values =
    new BuiltSet<DialysisEnum>(const <DialysisEnum>[
  _$unknown,
  _$automaticPeritonealDialysis,
  _$manualPeritonealDialysis,
  _$hemodialysis,
  _$postTransplant,
  _$notPerformed,
]);

class _$DialysisEnumMeta {
  const _$DialysisEnumMeta();
  DialysisEnum get unknown => _$unknown;
  DialysisEnum get automaticPeritonealDialysis => _$automaticPeritonealDialysis;
  DialysisEnum get manualPeritonealDialysis => _$manualPeritonealDialysis;
  DialysisEnum get hemodialysis => _$hemodialysis;
  DialysisEnum get postTransplant => _$postTransplant;
  DialysisEnum get notPerformed => _$notPerformed;
  DialysisEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<DialysisEnum> get values => _$values;
}

abstract class _$DialysisEnumMixin {
  // ignore: non_constant_identifier_names
  _$DialysisEnumMeta get DialysisEnum => const _$DialysisEnumMeta();
}

Serializer<DialysisEnum> _$dialysisEnumSerializer =
    new _$DialysisEnumSerializer();

class _$DialysisEnumSerializer implements PrimitiveSerializer<DialysisEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'Unknown',
    'automaticPeritonealDialysis': 'AutomaticPeritonealDialysis',
    'manualPeritonealDialysis': 'ManualPeritonealDialysis',
    'hemodialysis': 'Hemodialysis',
    'postTransplant': 'PostTransplant',
    'notPerformed': 'NotPerformed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unknown': 'unknown',
    'AutomaticPeritonealDialysis': 'automaticPeritonealDialysis',
    'ManualPeritonealDialysis': 'manualPeritonealDialysis',
    'Hemodialysis': 'hemodialysis',
    'PostTransplant': 'postTransplant',
    'NotPerformed': 'notPerformed',
  };

  @override
  final Iterable<Type> types = const <Type>[DialysisEnum];
  @override
  final String wireName = 'DialysisEnum';

  @override
  Object serialize(Serializers serializers, DialysisEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DialysisEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DialysisEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
