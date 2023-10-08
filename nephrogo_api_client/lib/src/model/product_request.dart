//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/product_kind_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_request.g.dart';

/// ProductRequest
///
/// Properties:
/// * [name] 
/// * [potassiumMg] 
/// * [proteinsMg] 
/// * [sodiumMg] 
/// * [phosphorusMg] 
/// * [energyKcal] 
/// * [liquidsMl] 
/// * [carbohydratesMg] 
/// * [fatMg] 
/// * [productKind] 
/// * [densityGMl] 
@BuiltValue()
abstract class ProductRequest implements Built<ProductRequest, ProductRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'potassium_mg')
  double get potassiumMg;

  @BuiltValueField(wireName: r'proteins_mg')
  int get proteinsMg;

  @BuiltValueField(wireName: r'sodium_mg')
  double get sodiumMg;

  @BuiltValueField(wireName: r'phosphorus_mg')
  double get phosphorusMg;

  @BuiltValueField(wireName: r'energy_kcal')
  int get energyKcal;

  @BuiltValueField(wireName: r'liquids_ml')
  int get liquidsMl;

  @BuiltValueField(wireName: r'carbohydrates_mg')
  int get carbohydratesMg;

  @BuiltValueField(wireName: r'fat_mg')
  int get fatMg;

  @BuiltValueField(wireName: r'product_kind')
  ProductKindEnum? get productKind;
  // enum productKindEnum {  Unknown,  Food,  Drink,  };

  @BuiltValueField(wireName: r'density_g_ml')
  double? get densityGMl;

  ProductRequest._();

  factory ProductRequest([void updates(ProductRequestBuilder b)]) = _$ProductRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductRequest> get serializer => _$ProductRequestSerializer();
}

class _$ProductRequestSerializer implements PrimitiveSerializer<ProductRequest> {
  @override
  final Iterable<Type> types = const [ProductRequest, _$ProductRequest];

  @override
  final String wireName = r'ProductRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'potassium_mg';
    yield serializers.serialize(
      object.potassiumMg,
      specifiedType: const FullType(double),
    );
    yield r'proteins_mg';
    yield serializers.serialize(
      object.proteinsMg,
      specifiedType: const FullType(int),
    );
    yield r'sodium_mg';
    yield serializers.serialize(
      object.sodiumMg,
      specifiedType: const FullType(double),
    );
    yield r'phosphorus_mg';
    yield serializers.serialize(
      object.phosphorusMg,
      specifiedType: const FullType(double),
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
    if (object.productKind != null) {
      yield r'product_kind';
      yield serializers.serialize(
        object.productKind,
        specifiedType: const FullType(ProductKindEnum),
      );
    }
    if (object.densityGMl != null) {
      yield r'density_g_ml';
      yield serializers.serialize(
        object.densityGMl,
        specifiedType: const FullType.nullable(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'potassium_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
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
            specifiedType: const FullType(double),
          ) as double;
          result.sodiumMg = valueDes;
          break;
        case r'phosphorus_mg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
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
        case r'product_kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKindEnum),
          ) as ProductKindEnum;
          result.productKind = valueDes;
          break;
        case r'density_g_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.densityGMl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductRequestBuilder();
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

