//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_general_recommendation_read.g.dart';

/// CreateGeneralRecommendationRead
///
/// Properties:
/// * [generalRecommendation] 
@BuiltValue()
abstract class CreateGeneralRecommendationRead implements Built<CreateGeneralRecommendationRead, CreateGeneralRecommendationReadBuilder> {
  @BuiltValueField(wireName: r'general_recommendation')
  int get generalRecommendation;

  CreateGeneralRecommendationRead._();

  factory CreateGeneralRecommendationRead([void updates(CreateGeneralRecommendationReadBuilder b)]) = _$CreateGeneralRecommendationRead;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateGeneralRecommendationReadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateGeneralRecommendationRead> get serializer => _$CreateGeneralRecommendationReadSerializer();
}

class _$CreateGeneralRecommendationReadSerializer implements PrimitiveSerializer<CreateGeneralRecommendationRead> {
  @override
  final Iterable<Type> types = const [CreateGeneralRecommendationRead, _$CreateGeneralRecommendationRead];

  @override
  final String wireName = r'CreateGeneralRecommendationRead';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateGeneralRecommendationRead object, {
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
    CreateGeneralRecommendationRead object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateGeneralRecommendationReadBuilder result,
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
  CreateGeneralRecommendationRead deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateGeneralRecommendationReadBuilder();
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

