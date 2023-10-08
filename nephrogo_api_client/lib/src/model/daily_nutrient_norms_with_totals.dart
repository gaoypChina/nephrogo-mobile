//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/daily_nutrient_consumption.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_nutrient_norms_with_totals.g.dart';

/// DailyNutrientNormsWithTotals
///
/// Properties:
/// * [potassiumMg] 
/// * [proteinsMg] 
/// * [sodiumMg] 
/// * [phosphorusMg] 
/// * [energyKcal] 
/// * [liquidsMl] 
/// * [carbohydratesMg] 
/// * [fatMg] 
@BuiltValue()
abstract class DailyNutrientNormsWithTotals implements Built<DailyNutrientNormsWithTotals, DailyNutrientNormsWithTotalsBuilder> {
  @BuiltValueField(wireName: r'potassium_mg')
  DailyNutrientConsumption get potassiumMg;

  @BuiltValueField(wireName: r'proteins_mg')
  DailyNutrientConsumption get proteinsMg;

  @BuiltValueField(wireName: r'sodium_mg')
  DailyNutrientConsumption get sodiumMg;

  @BuiltValueField(wireName: r'phosphorus_mg')
  DailyNutrientConsumption get phosphorusMg;

  @BuiltValueField(wireName: r'energy_kcal')
  DailyNutrientConsumption get energyKcal;

  @BuiltValueField(wireName: r'liquids_ml')
  DailyNutrientConsumption get liquidsMl;

  @BuiltValueField(wireName: r'carbohydrates_mg')
  DailyNutrientConsumption get carbohydratesMg;

  @BuiltValueField(wireName: r'fat_mg')
  DailyNutrientConsumption get fatMg;

  DailyNutrientNormsWithTotals._();

  factory DailyNutrientNormsWithTotals([void updates(DailyNutrientNormsWithTotalsBuilder b)]) = _$DailyNutrientNormsWithTotals;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyNutrientNormsWithTotalsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyNutrientNormsWithTotals> get serializer => _$DailyNutrientNormsWithTotalsSerializer();
}

class _$DailyNutrientNormsWithTotalsSerializer implements PrimitiveSerializer<DailyNutrientNormsWithTotals> {
  @override
  final Iterable<Type> types = const [DailyNutrientNormsWithTotals, _$DailyNutrientNormsWithTotals];

  @override
  final String wireName = r'DailyNutrientNormsWithTotals';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyNutrientNormsWithTotals object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'potassium_mg';
    yield serializers.serialize(
      object.potassiumMg,
      specifiedType: const FullType(DailyNutrientConsumption),
    );
    yield r'proteins_mg';
    yield serializers.serialize(
      object.proteinsMg,
      specifiedType: const FullType(DailyNutrientConsumption),
    );
    yield r'sodium_mg';
    yield serializers.serialize(
      object.sodiumMg,
      specifiedType: const FullType(DailyNutrientConsumption),
    );
    yield r'phosphorus_mg';
    yield serializers.serialize(
      object.phosphorusMg,
      specifiedType: const FullType(DailyNutrientConsumption),
    );
    yield r'energy_kcal';
    yield serializers.serialize(
      object.energyKcal,
      specifiedType: const FullType(DailyNutrientConsumption),
    );
    yield r'liquids_ml';
    yield serializers.serialize(
      object.liquidsMl,
      specifiedType: const FullType(DailyNutrientConsumption),
    );
    yield r'carbohydrates_mg';
    yield serializers.serialize(
      object.carbohydratesMg,
      specifiedType: const FullType(DailyNutrientConsumption),
    );
    yield r'fat_mg';
    yield serializers.serialize(
      object.fatMg,
      specifiedType: const FullType(DailyNutrientConsumption),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyNutrientNormsWithTotals object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DailyNutrientNormsWithTotalsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'potassium_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientConsumption),
          ) as DailyNutrientConsumption;
          result.potassiumMg.replace(valueDes);
          break;
        case r'proteins_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientConsumption),
          ) as DailyNutrientConsumption;
          result.proteinsMg.replace(valueDes);
          break;
        case r'sodium_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientConsumption),
          ) as DailyNutrientConsumption;
          result.sodiumMg.replace(valueDes);
          break;
        case r'phosphorus_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientConsumption),
          ) as DailyNutrientConsumption;
          result.phosphorusMg.replace(valueDes);
          break;
        case r'energy_kcal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientConsumption),
          ) as DailyNutrientConsumption;
          result.energyKcal.replace(valueDes);
          break;
        case r'liquids_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientConsumption),
          ) as DailyNutrientConsumption;
          result.liquidsMl.replace(valueDes);
          break;
        case r'carbohydrates_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientConsumption),
          ) as DailyNutrientConsumption;
          result.carbohydratesMg.replace(valueDes);
          break;
        case r'fat_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientConsumption),
          ) as DailyNutrientConsumption;
          result.fatMg.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyNutrientNormsWithTotals deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyNutrientNormsWithTotalsBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

