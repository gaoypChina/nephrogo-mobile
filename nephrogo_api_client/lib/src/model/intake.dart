//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/product.dart';
import 'package:nephrogo_api_client/src/model/meal_type_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'intake.g.dart';

/// Intake
///
/// Properties:
/// * [id] 
/// * [consumedAt] 
/// * [amountG] 
/// * [potassiumMg] 
/// * [proteinsMg] 
/// * [sodiumMg] 
/// * [phosphorusMg] 
/// * [energyKcal] 
/// * [liquidsMl] 
/// * [carbohydratesMg] 
/// * [fatMg] 
/// * [product] 
/// * [mealType] 
/// * [amountMl] 
@BuiltValue()
abstract class Intake implements Built<Intake, IntakeBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'consumed_at')
  DateTime get consumedAt;

  @BuiltValueField(wireName: r'amount_g')
  int get amountG;

  @BuiltValueField(wireName: r'potassium_mg')
  int get potassiumMg;

  @BuiltValueField(wireName: r'proteins_mg')
  int get proteinsMg;

  @BuiltValueField(wireName: r'sodium_mg')
  int get sodiumMg;

  @BuiltValueField(wireName: r'phosphorus_mg')
  int get phosphorusMg;

  @BuiltValueField(wireName: r'energy_kcal')
  int get energyKcal;

  @BuiltValueField(wireName: r'liquids_ml')
  int get liquidsMl;

  @BuiltValueField(wireName: r'carbohydrates_mg')
  int get carbohydratesMg;

  @BuiltValueField(wireName: r'fat_mg')
  int get fatMg;

  @BuiltValueField(wireName: r'product')
  Product get product;

  @BuiltValueField(wireName: r'meal_type')
  MealTypeEnum? get mealType;
  // enum mealTypeEnum {  Unknown,  Breakfast,  Lunch,  Dinner,  Snack,  };

  @BuiltValueField(wireName: r'amount_ml')
  int? get amountMl;

  Intake._();

  factory Intake([void updates(IntakeBuilder b)]) = _$Intake;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IntakeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Intake> get serializer => _$IntakeSerializer();
}

class _$IntakeSerializer implements PrimitiveSerializer<Intake> {
  @override
  final Iterable<Type> types = const [Intake, _$Intake];

  @override
  final String wireName = r'Intake';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Intake object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'consumed_at';
    yield serializers.serialize(
      object.consumedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'amount_g';
    yield serializers.serialize(
      object.amountG,
      specifiedType: const FullType(int),
    );
    yield r'potassium_mg';
    yield serializers.serialize(
      object.potassiumMg,
      specifiedType: const FullType(int),
    );
    yield r'proteins_mg';
    yield serializers.serialize(
      object.proteinsMg,
      specifiedType: const FullType(int),
    );
    yield r'sodium_mg';
    yield serializers.serialize(
      object.sodiumMg,
      specifiedType: const FullType(int),
    );
    yield r'phosphorus_mg';
    yield serializers.serialize(
      object.phosphorusMg,
      specifiedType: const FullType(int),
    );
    yield r'energy_kcal';
    yield serializers.serialize(
      object.energyKcal,
      specifiedType: const FullType(int),
    );
    yield r'liquids_ml';
    yield serializers.serialize(
      object.liquidsMl,
      specifiedType: const FullType(int),
    );
    yield r'carbohydrates_mg';
    yield serializers.serialize(
      object.carbohydratesMg,
      specifiedType: const FullType(int),
    );
    yield r'fat_mg';
    yield serializers.serialize(
      object.fatMg,
      specifiedType: const FullType(int),
    );
    yield r'product';
    yield serializers.serialize(
      object.product,
      specifiedType: const FullType(Product),
    );
    if (object.mealType != null) {
      yield r'meal_type';
      yield serializers.serialize(
        object.mealType,
        specifiedType: const FullType(MealTypeEnum),
      );
    }
    if (object.amountMl != null) {
      yield r'amount_ml';
      yield serializers.serialize(
        object.amountMl,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Intake object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IntakeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'consumed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.consumedAt = valueDes;
          break;
        case r'amount_g':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.amountG = valueDes;
          break;
        case r'potassium_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.potassiumMg = valueDes;
          break;
        case r'proteins_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.proteinsMg = valueDes;
          break;
        case r'sodium_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sodiumMg = valueDes;
          break;
        case r'phosphorus_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.phosphorusMg = valueDes;
          break;
        case r'energy_kcal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.energyKcal = valueDes;
          break;
        case r'liquids_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.liquidsMl = valueDes;
          break;
        case r'carbohydrates_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.carbohydratesMg = valueDes;
          break;
        case r'fat_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fatMg = valueDes;
          break;
        case r'product':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Product),
          ) as Product;
          result.product.replace(valueDes);
          break;
        case r'meal_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MealTypeEnum),
          ) as MealTypeEnum;
          result.mealType = valueDes;
          break;
        case r'amount_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.amountMl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Intake deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IntakeBuilder();
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

