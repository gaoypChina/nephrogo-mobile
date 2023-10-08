// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialysate_color_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DialysateColorEnum _$unknown = const DialysateColorEnum._('unknown');
const DialysateColorEnum _$transparent =
    const DialysateColorEnum._('transparent');
const DialysateColorEnum _$pink = const DialysateColorEnum._('pink');
const DialysateColorEnum _$cloudyYellowish =
    const DialysateColorEnum._('cloudyYellowish');
const DialysateColorEnum _$greenish = const DialysateColorEnum._('greenish');
const DialysateColorEnum _$brown = const DialysateColorEnum._('brown');
const DialysateColorEnum _$cloudyWhite =
    const DialysateColorEnum._('cloudyWhite');

DialysateColorEnum _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'transparent':
      return _$transparent;
    case 'pink':
      return _$pink;
    case 'cloudyYellowish':
      return _$cloudyYellowish;
    case 'greenish':
      return _$greenish;
    case 'brown':
      return _$brown;
    case 'cloudyWhite':
      return _$cloudyWhite;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DialysateColorEnum> _$values =
    new BuiltSet<DialysateColorEnum>(const <DialysateColorEnum>[
  _$unknown,
  _$transparent,
  _$pink,
  _$cloudyYellowish,
  _$greenish,
  _$brown,
  _$cloudyWhite,
]);

class _$DialysateColorEnumMeta {
  const _$DialysateColorEnumMeta();
  DialysateColorEnum get unknown => _$unknown;
  DialysateColorEnum get transparent => _$transparent;
  DialysateColorEnum get pink => _$pink;
  DialysateColorEnum get cloudyYellowish => _$cloudyYellowish;
  DialysateColorEnum get greenish => _$greenish;
  DialysateColorEnum get brown => _$brown;
  DialysateColorEnum get cloudyWhite => _$cloudyWhite;
  DialysateColorEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<DialysateColorEnum> get values => _$values;
}

abstract class _$DialysateColorEnumMixin {
  // ignore: non_constant_identifier_names
  _$DialysateColorEnumMeta get DialysateColorEnum =>
      const _$DialysateColorEnumMeta();
}

Serializer<DialysateColorEnum> _$dialysateColorEnumSerializer =
    new _$DialysateColorEnumSerializer();

class _$DialysateColorEnumSerializer
    implements PrimitiveSerializer<DialysateColorEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'Unknown',
    'transparent': 'Transparent',
    'pink': 'Pink',
    'cloudyYellowish': 'CloudyYellowish',
    'greenish': 'Greenish',
    'brown': 'Brown',
    'cloudyWhite': 'CloudyWhite',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unknown': 'unknown',
    'Transparent': 'transparent',
    'Pink': 'pink',
    'CloudyYellowish': 'cloudyYellowish',
    'Greenish': 'greenish',
    'Brown': 'brown',
    'CloudyWhite': 'cloudyWhite',
  };

  @override
  final Iterable<Type> types = const <Type>[DialysateColorEnum];
  @override
  final String wireName = 'DialysateColorEnum';

  @override
  Object serialize(Serializers serializers, DialysateColorEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DialysateColorEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DialysateColorEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
