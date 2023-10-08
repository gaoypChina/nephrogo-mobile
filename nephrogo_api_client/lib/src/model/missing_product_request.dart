//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'missing_product_request.g.dart';

/// MissingProductRequest
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class MissingProductRequest implements Built<MissingProductRequest, MissingProductRequestBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  MissingProductRequest._();

  factory MissingProductRequest([void updates(MissingProductRequestBuilder b)]) = _$MissingProductRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MissingProductRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MissingProductRequest> get serializer => _$MissingProductRequestSerializer();
}

class _$MissingProductRequestSerializer implements PrimitiveSerializer<MissingProductRequest> {
  @override
  final Iterable<Type> types = const [MissingProductRequest, _$MissingProductRequest];

  @override
  final String wireName = r'MissingProductRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MissingProductRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MissingProductRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MissingProductRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MissingProductRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MissingProductRequestBuilder();
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

