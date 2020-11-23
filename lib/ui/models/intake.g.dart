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
        unknownValue: ProductKind.UNKNOWN),
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
  ProductKind.UNKNOWN: 0,
  ProductKind.FOOD: 1,
  ProductKind.DRINK: 2,
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
