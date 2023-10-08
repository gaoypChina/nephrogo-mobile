//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_nutrient_consumption.g.dart';

/// DailyNutrientConsumption
///
/// Properties:
/// * [norm] 
/// * [total] 
@BuiltValue()
abstract class DailyNutrientConsumption implements Built<DailyNutrientConsumption, DailyNutrientConsumptionBuilder> {
  @BuiltValueField(wireName: r'norm')
  int? get norm;

  @BuiltValueField(wireName: r'total')
  int get total;

  DailyNutrientConsumption._();

  factory DailyNutrientConsumption([void updates(DailyNutrientConsumptionBuilder b)]) = _$DailyNutrientConsumption;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyNutrientConsumptionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyNutrientConsumption> get serializer => _$DailyNutrientConsumptionSerializer();
}

class _$DailyNutrientConsumptionSerializer implements PrimitiveSerializer<DailyNutrientConsumption> {
  @override
  final Iterable<Type> types = const [DailyNutrientConsumption, _$DailyNutrientConsumption];

  @override
  final String wireName = r'DailyNutrientConsumption';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyNutrientConsumption object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'norm';
    yield object.norm == null ? null : serializers.serialize(
      object.norm,
      specifiedType: const FullType.nullable(int),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyNutrientConsumption object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DailyNutrientConsumptionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'norm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.norm = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyNutrientConsumption deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyNutrientConsumptionBuilder();
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

