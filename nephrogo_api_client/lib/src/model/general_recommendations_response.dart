//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/general_recommendation_category.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'general_recommendations_response.g.dart';

/// GeneralRecommendationsResponse
///
/// Properties:
/// * [readRecommendationIds] 
/// * [categories] 
@BuiltValue()
abstract class GeneralRecommendationsResponse implements Built<GeneralRecommendationsResponse, GeneralRecommendationsResponseBuilder> {
  @BuiltValueField(wireName: r'read_recommendation_ids')
  BuiltList<int> get readRecommendationIds;

  @BuiltValueField(wireName: r'categories')
  BuiltList<GeneralRecommendationCategory> get categories;

  GeneralRecommendationsResponse._();

  factory GeneralRecommendationsResponse([void updates(GeneralRecommendationsResponseBuilder b)]) = _$GeneralRecommendationsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GeneralRecommendationsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GeneralRecommendationsResponse> get serializer => _$GeneralRecommendationsResponseSerializer();
}

class _$GeneralRecommendationsResponseSerializer implements PrimitiveSerializer<GeneralRecommendationsResponse> {
  @override
  final Iterable<Type> types = const [GeneralRecommendationsResponse, _$GeneralRecommendationsResponse];

  @override
  final String wireName = r'GeneralRecommendationsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GeneralRecommendationsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'read_recommendation_ids';
    yield serializers.serialize(
      object.readRecommendationIds,
      specifiedType: const FullType(BuiltList, [FullType(int)]),
    );
    yield r'categories';
    yield serializers.serialize(
      object.categories,
      specifiedType: const FullType(BuiltList, [FullType(GeneralRecommendationCategory)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GeneralRecommendationsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GeneralRecommendationsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'read_recommendation_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.readRecommendationIds.replace(valueDes);
          break;
        case r'categories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(GeneralRecommendationCategory)]),
          ) as BuiltList<GeneralRecommendationCategory>;
          result.categories.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GeneralRecommendationsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GeneralRecommendationsResponseBuilder();
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

