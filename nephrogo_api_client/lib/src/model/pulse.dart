//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'pulse.g.dart';

/// Pulse
///
/// Properties:
/// * [id] 
/// * [pulse] 
/// * [measuredAt] 
@BuiltValue()
abstract class Pulse implements Built<Pulse, PulseBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'pulse')
  int get pulse;

  @BuiltValueField(wireName: r'measured_at')
  DateTime get measuredAt;

  Pulse._();

  factory Pulse([void updates(PulseBuilder b)]) = _$Pulse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PulseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Pulse> get serializer => _$PulseSerializer();
}

class _$PulseSerializer implements PrimitiveSerializer<Pulse> {
  @override
  final Iterable<Type> types = const [Pulse, _$Pulse];

  @override
  final String wireName = r'Pulse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Pulse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
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
    Pulse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PulseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
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
  Pulse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PulseBuilder();
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

