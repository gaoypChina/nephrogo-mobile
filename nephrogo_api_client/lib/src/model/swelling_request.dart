//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/swelling_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'swelling_request.g.dart';

/// SwellingRequest
///
/// Properties:
/// * [swelling] 
@BuiltValue()
abstract class SwellingRequest implements Built<SwellingRequest, SwellingRequestBuilder> {
  @BuiltValueField(wireName: r'swelling')
  SwellingEnum get swelling;
  // enum swellingEnum {  Unknown,  Eyes,  WholeFace,  HandBreadth,  Hands,  Belly,  Knees,  Foot,  WholeLegs,  };

  SwellingRequest._();

  factory SwellingRequest([void updates(SwellingRequestBuilder b)]) = _$SwellingRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SwellingRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SwellingRequest> get serializer => _$SwellingRequestSerializer();
}

class _$SwellingRequestSerializer implements PrimitiveSerializer<SwellingRequest> {
  @override
  final Iterable<Type> types = const [SwellingRequest, _$SwellingRequest];

  @override
  final String wireName = r'SwellingRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SwellingRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'swelling';
    yield serializers.serialize(
      object.swelling,
      specifiedType: const FullType(SwellingEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SwellingRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SwellingRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'swelling':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SwellingEnum),
          ) as SwellingEnum;
          result.swelling = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SwellingRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SwellingRequestBuilder();
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

