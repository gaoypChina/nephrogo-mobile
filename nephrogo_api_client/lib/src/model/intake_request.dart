//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/meal_type_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'intake_request.g.dart';

/// IntakeRequest
///
/// Properties:
/// * [productId] 
/// * [consumedAt] 
/// * [amountG] 
/// * [mealType] 
/// * [amountMl] 
@BuiltValue()
abstract class IntakeRequest implements Built<IntakeRequest, IntakeRequestBuilder> {
  @BuiltValueField(wireName: r'product_id')
  int get productId;

  @BuiltValueField(wireName: r'consumed_at')
  DateTime get consumedAt;

  @BuiltValueField(wireName: r'amount_g')
  int get amountG;

  @BuiltValueField(wireName: r'meal_type')
  MealTypeEnum? get mealType;
  // enum mealTypeEnum {  Unknown,  Breakfast,  Lunch,  Dinner,  Snack,  };

  @BuiltValueField(wireName: r'amount_ml')
  int? get amountMl;

  IntakeRequest._();

  factory IntakeRequest([void updates(IntakeRequestBuilder b)]) = _$IntakeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IntakeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IntakeRequest> get serializer => _$IntakeRequestSerializer();
}

class _$IntakeRequestSerializer implements PrimitiveSerializer<IntakeRequest> {
  @override
  final Iterable<Type> types = const [IntakeRequest, _$IntakeRequest];

  @override
  final String wireName = r'IntakeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IntakeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
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
    IntakeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IntakeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.productId = valueDes;
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
  IntakeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IntakeRequestBuilder();
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

