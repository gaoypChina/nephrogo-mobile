// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'well_feeling_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WellFeelingEnum _$unknown = const WellFeelingEnum._('unknown');
const WellFeelingEnum _$perfect = const WellFeelingEnum._('perfect');
const WellFeelingEnum _$good = const WellFeelingEnum._('good');
const WellFeelingEnum _$average = const WellFeelingEnum._('average');
const WellFeelingEnum _$bad = const WellFeelingEnum._('bad');
const WellFeelingEnum _$veryBad = const WellFeelingEnum._('veryBad');

WellFeelingEnum _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'perfect':
      return _$perfect;
    case 'good':
      return _$good;
    case 'average':
      return _$average;
    case 'bad':
      return _$bad;
    case 'veryBad':
      return _$veryBad;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<WellFeelingEnum> _$values =
    new BuiltSet<WellFeelingEnum>(const <WellFeelingEnum>[
  _$unknown,
  _$perfect,
  _$good,
  _$average,
  _$bad,
  _$veryBad,
]);

class _$WellFeelingEnumMeta {
  const _$WellFeelingEnumMeta();
  WellFeelingEnum get unknown => _$unknown;
  WellFeelingEnum get perfect => _$perfect;
  WellFeelingEnum get good => _$good;
  WellFeelingEnum get average => _$average;
  WellFeelingEnum get bad => _$bad;
  WellFeelingEnum get veryBad => _$veryBad;
  WellFeelingEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<WellFeelingEnum> get values => _$values;
}

abstract class _$WellFeelingEnumMixin {
  // ignore: non_constant_identifier_names
  _$WellFeelingEnumMeta get WellFeelingEnum => const _$WellFeelingEnumMeta();
}

Serializer<WellFeelingEnum> _$wellFeelingEnumSerializer =
    new _$WellFeelingEnumSerializer();

class _$WellFeelingEnumSerializer
    implements PrimitiveSerializer<WellFeelingEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'Unknown',
    'perfect': 'Perfect',
    'good': 'Good',
    'average': 'Average',
    'bad': 'Bad',
    'veryBad': 'VeryBad',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unknown': 'unknown',
    'Perfect': 'perfect',
    'Good': 'good',
    'Average': 'average',
    'Bad': 'bad',
    'VeryBad': 'veryBad',
  };

  @override
  final Iterable<Type> types = const <Type>[WellFeelingEnum];
  @override
  final String wireName = 'WellFeelingEnum';

  @override
  Object serialize(Serializers serializers, WellFeelingEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WellFeelingEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WellFeelingEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
