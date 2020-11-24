// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'] as int,
    json['name'] as String,
    _$enumDecodeNullable(_$ProductKindEnumMap, json['kind'],
        unknownValue: ProductKind.unknown),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': _$ProductKindEnumMap[instance.kind],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ProductKindEnumMap = {
  ProductKind.unknown: 0,
  ProductKind.food: 1,
  ProductKind.drink: 2,
};

Intake _$IntakeFromJson(Map<String, dynamic> json) {
  return Intake(
    json['id'] as int,
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
    json['amountG'] as int,
  );
}

Map<String, dynamic> _$IntakeToJson(Intake instance) => <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'dateTime': instance.dateTime?.toIso8601String(),
      'amountG': instance.amountG,
    };

IndicatorConsumption _$IndicatorConsumptionFromJson(Map<String, dynamic> json) {
  return IndicatorConsumption(
    json['consumed'] as int,
    json['norm'] as int,
    json['unit'] as String,
  );
}

Map<String, dynamic> _$IndicatorConsumptionToJson(
        IndicatorConsumption instance) =>
    <String, dynamic>{
      'consumed': instance.consumed,
      'norm': instance.norm,
      'unit': instance.unit,
    };

DailyIntake _$DailyIntakeFromJson(Map<String, dynamic> json) {
  return DailyIntake(
    json['id'] as int,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['intakes'] as List)
        ?.map((e) =>
            e == null ? null : Intake.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['energy'] == null
        ? null
        : IndicatorConsumption.fromJson(json['energy'] as Map<String, dynamic>),
    json['carbohydrates'] == null
        ? null
        : IndicatorConsumption.fromJson(
            json['carbohydrates'] as Map<String, dynamic>),
    json['proteins'] == null
        ? null
        : IndicatorConsumption.fromJson(
            json['proteins'] as Map<String, dynamic>),
    json['liquids'] == null
        ? null
        : IndicatorConsumption.fromJson(
            json['liquids'] as Map<String, dynamic>),
    json['sodium'] == null
        ? null
        : IndicatorConsumption.fromJson(json['sodium'] as Map<String, dynamic>),
    json['potassium'] == null
        ? null
        : IndicatorConsumption.fromJson(
            json['potassium'] as Map<String, dynamic>),
    json['phosphorus'] == null
        ? null
        : IndicatorConsumption.fromJson(
            json['phosphorus'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DailyIntakeToJson(DailyIntake instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'intakes': instance.intakes,
      'energy': instance.energy,
      'carbohydrates': instance.carbohydrates,
      'proteins': instance.proteins,
      'liquids': instance.liquids,
      'sodium': instance.sodium,
      'potassium': instance.potassium,
      'phosphorus': instance.phosphorus,
    };
