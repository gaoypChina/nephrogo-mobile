//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/general_recommendation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'general_recommendation_subcategory.g.dart';

/// GeneralRecommendationSubcategory
///
/// Properties:
/// * [name] 
/// * [recommendations] 
@BuiltValue()
abstract class GeneralRecommendationSubcategory implements Built<GeneralRecommendationSubcategory, GeneralRecommendationSubcategoryBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'recommendations')
  BuiltList<GeneralRecommendation> get recommendations;

  GeneralRecommendationSubcategory._();

  factory GeneralRecommendationSubcategory([void updates(GeneralRecommendationSubcategoryBuilder b)]) = _$GeneralRecommendationSubcategory;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GeneralRecommendationSubcategoryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GeneralRecommendationSubcategory> get serializer => _$GeneralRecommendationSubcategorySerializer();
}

class _$GeneralRecommendationSubcategorySerializer implements PrimitiveSerializer<GeneralRecommendationSubcategory> {
  @override
  final Iterable<Type> types = const [GeneralRecommendationSubcategory, _$GeneralRecommendationSubcategory];

  @override
  final String wireName = r'GeneralRecommendationSubcategory';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GeneralRecommendationSubcategory object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'recommendations';
    yield serializers.serialize(
      object.recommendations,
      specifiedType: const FullType(BuiltList, [FullType(GeneralRecommendation)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GeneralRecommendationSubcategory object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GeneralRecommendationSubcategoryBuilder result,
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
        case r'recommendations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(GeneralRecommendation)]),
          ) as BuiltList<GeneralRecommendation>;
          result.recommendations.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GeneralRecommendationSubcategory deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GeneralRecommendationSubcategoryBuilder();
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

