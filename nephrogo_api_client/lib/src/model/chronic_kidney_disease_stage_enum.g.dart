// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chronic_kidney_disease_stage_enum.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChronicKidneyDiseaseStageEnum _$unknown =
    const ChronicKidneyDiseaseStageEnum._('unknown');
const ChronicKidneyDiseaseStageEnum _$stage1 =
    const ChronicKidneyDiseaseStageEnum._('stage1');
const ChronicKidneyDiseaseStageEnum _$stage2 =
    const ChronicKidneyDiseaseStageEnum._('stage2');
const ChronicKidneyDiseaseStageEnum _$stage3 =
    const ChronicKidneyDiseaseStageEnum._('stage3');
const ChronicKidneyDiseaseStageEnum _$stage4 =
    const ChronicKidneyDiseaseStageEnum._('stage4');
const ChronicKidneyDiseaseStageEnum _$stage5 =
    const ChronicKidneyDiseaseStageEnum._('stage5');

ChronicKidneyDiseaseStageEnum _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'stage1':
      return _$stage1;
    case 'stage2':
      return _$stage2;
    case 'stage3':
      return _$stage3;
    case 'stage4':
      return _$stage4;
    case 'stage5':
      return _$stage5;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ChronicKidneyDiseaseStageEnum> _$values = new BuiltSet<
    ChronicKidneyDiseaseStageEnum>(const <ChronicKidneyDiseaseStageEnum>[
  _$unknown,
  _$stage1,
  _$stage2,
  _$stage3,
  _$stage4,
  _$stage5,
]);

class _$ChronicKidneyDiseaseStageEnumMeta {
  const _$ChronicKidneyDiseaseStageEnumMeta();
  ChronicKidneyDiseaseStageEnum get unknown => _$unknown;
  ChronicKidneyDiseaseStageEnum get stage1 => _$stage1;
  ChronicKidneyDiseaseStageEnum get stage2 => _$stage2;
  ChronicKidneyDiseaseStageEnum get stage3 => _$stage3;
  ChronicKidneyDiseaseStageEnum get stage4 => _$stage4;
  ChronicKidneyDiseaseStageEnum get stage5 => _$stage5;
  ChronicKidneyDiseaseStageEnum valueOf(String name) => _$valueOf(name);
  BuiltSet<ChronicKidneyDiseaseStageEnum> get values => _$values;
}

abstract class _$ChronicKidneyDiseaseStageEnumMixin {
  // ignore: non_constant_identifier_names
  _$ChronicKidneyDiseaseStageEnumMeta get ChronicKidneyDiseaseStageEnum =>
      const _$ChronicKidneyDiseaseStageEnumMeta();
}

Serializer<ChronicKidneyDiseaseStageEnum>
    _$chronicKidneyDiseaseStageEnumSerializer =
    new _$ChronicKidneyDiseaseStageEnumSerializer();

class _$ChronicKidneyDiseaseStageEnumSerializer
    implements PrimitiveSerializer<ChronicKidneyDiseaseStageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'Unknown',
    'stage1': 'Stage1',
    'stage2': 'Stage2',
    'stage3': 'Stage3',
    'stage4': 'Stage4',
    'stage5': 'Stage5',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Unknown': 'unknown',
    'Stage1': 'stage1',
    'Stage2': 'stage2',
    'Stage3': 'stage3',
    'Stage4': 'stage4',
    'Stage5': 'stage5',
  };

  @override
  final Iterable<Type> types = const <Type>[ChronicKidneyDiseaseStageEnum];
  @override
  final String wireName = 'ChronicKidneyDiseaseStageEnum';

  @override
  Object serialize(
          Serializers serializers, ChronicKidneyDiseaseStageEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChronicKidneyDiseaseStageEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChronicKidneyDiseaseStageEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
