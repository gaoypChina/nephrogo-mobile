//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_general_recommendation_read_request.g.dart';

/// CreateGeneralRecommendationReadRequest
///
/// Properties:
/// * [generalRecommendation] 
@BuiltValue()
abstract class CreateGeneralRecommendationReadRequest implements Built<CreateGeneralRecommendationReadRequest, CreateGeneralRecommendationReadRequestBuilder> {
  @BuiltValueField(wireName: r'general_recommendation')
  int get generalRecommendation;

  CreateGeneralRecommendationReadRequest._();

  factory CreateGeneralRecommendationReadRequest([void updates(CreateGeneralRecommendationReadRequestBuilder b)]) = _$CreateGeneralRecommendationReadRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateGeneralRecommendationReadRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateGeneralRecommendationReadRequest> get serializer => _$CreateGeneralRecommendationReadRequestSerializer();
}

class _$CreateGeneralRecommendationReadRequestSerializer implements PrimitiveSerializer<CreateGeneralRecommendationReadRequest> {
  @override
  final Iterable<Type> types = const [CreateGeneralRecommendationReadRequest, _$CreateGeneralRecommendationReadRequest];

  @override
  final String wireName = r'CreateGeneralRecommendationReadRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateGeneralRecommendationReadRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'general_recommendation';
    yield serializers.serialize(
      object.generalRecommendation,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateGeneralRecommendationReadRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateGeneralRecommendationReadRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'general_recommendation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.generalRecommendation = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateGeneralRecommendationReadRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateGeneralRecommendationReadRequestBuilder();
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

