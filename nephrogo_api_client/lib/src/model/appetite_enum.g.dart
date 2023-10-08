// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appetite_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AppetiteEnum _$unknown = const AppetiteEnum._('unknown');
const AppetiteEnum _$perfect = const AppetiteEnum._('perfect');
const AppetiteEnum _$good = const AppetiteEnum._('good');
const AppetiteEnum _$average = const AppetiteEnum._('average');
const AppetiteEnum _$bad = const AppetiteEnum._('bad');
const AppetiteEnum _$veryBad = const AppetiteEnum._('veryBad');

AppetiteEnum _$valueOf(String name) {
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

final BuiltSet<AppetiteEnum> _$values =
    new BuiltSet<AppetiteEnum>(const <AppetiteEnum>[
  _$unknown,
  _$perfect,
  _$good,
  _$average,
  _$bad,
  _$veryBad,
]);

class _$AppetiteEnumMeta {
  const _$AppetiteEnumMeta();
  AppetiteEnum get unknown => _$unknown;
  AppetiteEnum get perfect => _$perfect;
  AppetiteEnum get good => _$good;
  AppetiteEnum get average => _$average;
  AppetiteEnum get bad => _$bad;
  AppetiteEnum get veryBad => _$veryBad;
  AppetiteEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<AppetiteEnum> get values => _$values;
}

abstract class _$AppetiteEnumMixin {
  // ignore: non_constant_identifier_names
  _$AppetiteEnumMeta get AppetiteEnum => const _$AppetiteEnumMeta();
}

Serializer<AppetiteEnum> _$appetiteEnumSerializer =
    new _$AppetiteEnumSerializer();

class _$AppetiteEnumSerializer implements PrimitiveSerializer<AppetiteEnum> {
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
  final Iterable<Type> types = const <Type>[AppetiteEnum];
  @override
  final String wireName = 'AppetiteEnum';

  @override
  Object serialize(Serializers serializers, AppetiteEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AppetiteEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AppetiteEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
