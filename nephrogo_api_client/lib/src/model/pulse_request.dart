//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pulse_request.g.dart';

/// PulseRequest
///
/// Properties:
/// * [pulse] 
/// * [measuredAt] 
@BuiltValue()
abstract class PulseRequest implements Built<PulseRequest, PulseRequestBuilder> {
  @BuiltValueField(wireName: r'pulse')
  int get pulse;

  @BuiltValueField(wireName: r'measured_at')
  DateTime get measuredAt;

  PulseRequest._();

  factory PulseRequest([void updates(PulseRequestBuilder b)]) = _$PulseRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PulseRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PulseRequest> get serializer => _$PulseRequestSerializer();
}

class _$PulseRequestSerializer implements PrimitiveSerializer<PulseRequest> {
  @override
  final Iterable<Type> types = const [PulseRequest, _$PulseRequest];

  @override
  final String wireName = r'PulseRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PulseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'pulse';
    yield serializers.serialize(
      object.pulse,
      specifiedType: const FullType(int),
    );
    yield r'measured_at';
    yield serializers.serialize(
      object.measuredAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PulseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PulseRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'pulse':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pulse = valueDes;
          break;
        case r'measured_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.measuredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PulseRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PulseRequestBuilder();
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

