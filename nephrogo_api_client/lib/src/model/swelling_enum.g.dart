// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swelling_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SwellingEnum _$unknown = const SwellingEnum._('unknown');
const SwellingEnum _$eyes = const SwellingEnum._('eyes');
const SwellingEnum _$wholeFace = const SwellingEnum._('wholeFace');
const SwellingEnum _$handBreadth = const SwellingEnum._('handBreadth');
const SwellingEnum _$hands = const SwellingEnum._('hands');
const SwellingEnum _$belly = const SwellingEnum._('belly');
const SwellingEnum _$knees = const SwellingEnum._('knees');
const SwellingEnum _$foot = const SwellingEnum._('foot');
const SwellingEnum _$wholeLegs = const SwellingEnum._('wholeLegs');

SwellingEnum _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'eyes':
      return _$eyes;
    case 'wholeFace':
      return _$wholeFace;
    case 'handBreadth':
      return _$handBreadth;
    case 'hands':
      return _$hands;
    case 'belly':
      return _$belly;
    case 'knees':
      return _$knees;
    case 'foot':
      return _$foot;
    case 'wholeLegs':
      return _$wholeLegs;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SwellingEnum> _$values =
    new BuiltSet<SwellingEnum>(const <SwellingEnum>[
  _$unknown,
  _$eyes,
  _$wholeFace,
  _$handBreadth,
  _$hands,
  _$belly,
  _$knees,
  _$foot,
  _$wholeLegs,
]);

class _$SwellingEnumMeta {
  const _$SwellingEnumMeta();
  SwellingEnum get unknown => _$unknown;
  SwellingEnum get eyes => _$eyes;
  SwellingEnum get wholeFace => _$wholeFace;
  SwellingEnum get handBreadth => _$handBreadth;
  SwellingEnum get hands => _$hands;
  SwellingEnum get belly => _$belly;
  SwellingEnum get knees => _$knees;
  SwellingEnum get foot => _$foot;
  SwellingEnum get wholeLegs => _$wholeLegs;
  SwellingEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<SwellingEnum> get values => _$values;
}

abstract class _$SwellingEnumMixin {
  // ignore: non_constant_identifier_names
  _$SwellingEnumMeta get SwellingEnum => const _$SwellingEnumMeta();
}

Serializer<SwellingEnum> _$swellingEnumSerializer =
    new _$SwellingEnumSerializer();

class _$SwellingEnumSerializer implements PrimitiveSerializer<SwellingEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'Unknown',
    'eyes': 'Eyes',
    'wholeFace': 'WholeFace',
    'handBreadth': 'HandBreadth',
    'hands': 'Hands',
    'belly': 'Belly',
    'knees': 'Knees',
    'foot': 'Foot',
    'wholeLegs': 'WholeLegs',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unknown': 'unknown',
    'Eyes': 'eyes',
    'WholeFace': 'wholeFace',
    'HandBreadth': 'handBreadth',
    'Hands': 'hands',
    'Belly': 'belly',
    'Knees': 'knees',
    'Foot': 'foot',
    'WholeLegs': 'wholeLegs',
  };

  @override
  final Iterable<Type> types = const <Type>[SwellingEnum];
  @override
  final String wireName = 'SwellingEnum';

  @override
  Object serialize(Serializers serializers, SwellingEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SwellingEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SwellingEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
