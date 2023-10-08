//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/daily_nutrient_norms_with_totals.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/product.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_search_response.g.dart';

/// ProductSearchResponse
///
/// Properties:
/// * [query] 
/// * [products] 
/// * [dailyNutrientNormsAndTotals] 
@BuiltValue()
abstract class ProductSearchResponse implements Built<ProductSearchResponse, ProductSearchResponseBuilder> {
  @BuiltValueField(wireName: r'query')
  String get query;

  @BuiltValueField(wireName: r'products')
  BuiltList<Product> get products;

  @BuiltValueField(wireName: r'daily_nutrient_norms_and_totals')
  DailyNutrientNormsWithTotals get dailyNutrientNormsAndTotals;

  ProductSearchResponse._();

  factory ProductSearchResponse([void updates(ProductSearchResponseBuilder b)]) = _$ProductSearchResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductSearchResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProductSearchResponse> get serializer => _$ProductSearchResponseSerializer();
}

class _$ProductSearchResponseSerializer implements PrimitiveSerializer<ProductSearchResponse> {
  @override
  final Iterable<Type> types = const [ProductSearchResponse, _$ProductSearchResponse];

  @override
  final String wireName = r'ProductSearchResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProductSearchResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'query';
    yield serializers.serialize(
      object.query,
      specifiedType: const FullType(String),
    );
    yield r'products';
    yield serializers.serialize(
      object.products,
      specifiedType: const FullType(BuiltList, [FullType(Product)]),
    );
    yield r'daily_nutrient_norms_and_totals';
    yield serializers.serialize(
      object.dailyNutrientNormsAndTotals,
      specifiedType: const FullType(DailyNutrientNormsWithTotals),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProductSearchResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductSearchResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'query':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.query = valueDes;
          break;
        case r'products':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Product)]),
          ) as BuiltList<Product>;
          result.products.replace(valueDes);
          break;
        case r'daily_nutrient_norms_and_totals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientNormsWithTotals),
          ) as DailyNutrientNormsWithTotals;
          result.dailyNutrientNormsAndTotals.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProductSearchResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductSearchResponseBuilder();
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

