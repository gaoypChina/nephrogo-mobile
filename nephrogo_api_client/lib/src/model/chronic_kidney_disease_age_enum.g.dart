// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chronic_kidney_disease_age_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChronicKidneyDiseaseAgeEnum _$unknown =
    const ChronicKidneyDiseaseAgeEnum._('unknown');
const ChronicKidneyDiseaseAgeEnum _$lessThan1 =
    const ChronicKidneyDiseaseAgeEnum._('lessThan1');
const ChronicKidneyDiseaseAgeEnum _$n15 =
    const ChronicKidneyDiseaseAgeEnum._('n15');
const ChronicKidneyDiseaseAgeEnum _$n610 =
    const ChronicKidneyDiseaseAgeEnum._('n610');
const ChronicKidneyDiseaseAgeEnum _$greaterThan10 =
    const ChronicKidneyDiseaseAgeEnum._('greaterThan10');

ChronicKidneyDiseaseAgeEnum _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'lessThan1':
      return _$lessThan1;
    case 'n15':
      return _$n15;
    case 'n610':
      return _$n610;
    case 'greaterThan10':
      return _$greaterThan10;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ChronicKidneyDiseaseAgeEnum> _$values = new BuiltSet<
    ChronicKidneyDiseaseAgeEnum>(const <ChronicKidneyDiseaseAgeEnum>[
  _$unknown,
  _$lessThan1,
  _$n15,
  _$n610,
  _$greaterThan10,
]);

class _$ChronicKidneyDiseaseAgeEnumMeta {
  const _$ChronicKidneyDiseaseAgeEnumMeta();
  ChronicKidneyDiseaseAgeEnum get unknown => _$unknown;
  ChronicKidneyDiseaseAgeEnum get lessThan1 => _$lessThan1;
  ChronicKidneyDiseaseAgeEnum get n15 => _$n15;
  ChronicKidneyDiseaseAgeEnum get n610 => _$n610;
  ChronicKidneyDiseaseAgeEnum get greaterThan10 => _$greaterThan10;
  ChronicKidneyDiseaseAgeEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<ChronicKidneyDiseaseAgeEnum> get values => _$values;
}

abstract class _$ChronicKidneyDiseaseAgeEnumMixin {
  // ignore: non_constant_identifier_names
  _$ChronicKidneyDiseaseAgeEnumMeta get ChronicKidneyDiseaseAgeEnum =>
      const _$ChronicKidneyDiseaseAgeEnumMeta();
}

Serializer<ChronicKidneyDiseaseAgeEnum>
    _$chronicKidneyDiseaseAgeEnumSerializer =
    new _$ChronicKidneyDiseaseAgeEnumSerializer();

class _$ChronicKidneyDiseaseAgeEnumSerializer
    implements PrimitiveSerializer<ChronicKidneyDiseaseAgeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'Unknown',
    'lessThan1': '<1',
    'n15': '1-5',
    'n610': '6-10',
    'greaterThan10': '>10',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unknown': 'unknown',
    '<1': 'lessThan1',
    '1-5': 'n15',
    '6-10': 'n610',
    '>10': 'greaterThan10',
  };

  @override
  final Iterable<Type> types = const <Type>[ChronicKidneyDiseaseAgeEnum];
  @override
  final String wireName = 'ChronicKidneyDiseaseAgeEnum';

  @override
  Object serialize(Serializers serializers, ChronicKidneyDiseaseAgeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChronicKidneyDiseaseAgeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChronicKidneyDiseaseAgeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
