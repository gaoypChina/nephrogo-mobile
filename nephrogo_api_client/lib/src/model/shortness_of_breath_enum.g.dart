// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortness_of_breath_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ShortnessOfBreathEnum _$unknown =
    const ShortnessOfBreathEnum._('unknown');
const ShortnessOfBreathEnum _$no = const ShortnessOfBreathEnum._('no');
const ShortnessOfBreathEnum _$light = const ShortnessOfBreathEnum._('light');
const ShortnessOfBreathEnum _$average =
    const ShortnessOfBreathEnum._('average');
const ShortnessOfBreathEnum _$severe = const ShortnessOfBreathEnum._('severe');
const ShortnessOfBreathEnum _$backbreaking =
    const ShortnessOfBreathEnum._('backbreaking');

ShortnessOfBreathEnum _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'no':
      return _$no;
    case 'light':
      return _$light;
    case 'average':
      return _$average;
    case 'severe':
      return _$severe;
    case 'backbreaking':
      return _$backbreaking;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ShortnessOfBreathEnum> _$values =
    new BuiltSet<ShortnessOfBreathEnum>(const <ShortnessOfBreathEnum>[
  _$unknown,
  _$no,
  _$light,
  _$average,
  _$severe,
  _$backbreaking,
]);

class _$ShortnessOfBreathEnumMeta {
  const _$ShortnessOfBreathEnumMeta();
  ShortnessOfBreathEnum get unknown => _$unknown;
  ShortnessOfBreathEnum get no => _$no;
  ShortnessOfBreathEnum get light => _$light;
  ShortnessOfBreathEnum get average => _$average;
  ShortnessOfBreathEnum get severe => _$severe;
  ShortnessOfBreathEnum get backbreaking => _$backbreaking;
  ShortnessOfBreathEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<ShortnessOfBreathEnum> get values => _$values;
}

abstract class _$ShortnessOfBreathEnumMixin {
  // ignore: non_constant_identifier_names
  _$ShortnessOfBreathEnumMeta get ShortnessOfBreathEnum =>
      const _$ShortnessOfBreathEnumMeta();
}

Serializer<ShortnessOfBreathEnum> _$shortnessOfBreathEnumSerializer =
    new _$ShortnessOfBreathEnumSerializer();

class _$ShortnessOfBreathEnumSerializer
    implements PrimitiveSerializer<ShortnessOfBreathEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'Unknown',
    'no': 'No',
    'light': 'Light',
    'average': 'Average',
    'severe': 'Severe',
    'backbreaking': 'Backbreaking',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unknown': 'unknown',
    'No': 'no',
    'Light': 'light',
    'Average': 'average',
    'Severe': 'severe',
    'Backbreaking': 'backbreaking',
  };

  @override
  final Iterable<Type> types = const <Type>[ShortnessOfBreathEnum];
  @override
  final String wireName = 'ShortnessOfBreathEnum';

  @override
  Object serialize(Serializers serializers, ShortnessOfBreathEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ShortnessOfBreathEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ShortnessOfBreathEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
