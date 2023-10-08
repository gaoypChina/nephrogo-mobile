//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'blood_pressure_request.g.dart';

/// BloodPressureRequest
///
/// Properties:
/// * [systolicBloodPressure] 
/// * [diastolicBloodPressure] 
/// * [measuredAt] 
@BuiltValue()
abstract class BloodPressureRequest implements Built<BloodPressureRequest, BloodPressureRequestBuilder> {
  @BuiltValueField(wireName: r'systolic_blood_pressure')
  int get systolicBloodPressure;

  @BuiltValueField(wireName: r'diastolic_blood_pressure')
  int get diastolicBloodPressure;

  @BuiltValueField(wireName: r'measured_at')
  DateTime get measuredAt;

  BloodPressureRequest._();

  factory BloodPressureRequest([void updates(BloodPressureRequestBuilder b)]) = _$BloodPressureRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BloodPressureRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BloodPressureRequest> get serializer => _$BloodPressureRequestSerializer();
}

class _$BloodPressureRequestSerializer implements PrimitiveSerializer<BloodPressureRequest> {
  @override
  final Iterable<Type> types = const [BloodPressureRequest, _$BloodPressureRequest];

  @override
  final String wireName = r'BloodPressureRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BloodPressureRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'systolic_blood_pressure';
    yield serializers.serialize(
      object.systolicBloodPressure,
      specifiedType: const FullType(int),
    );
    yield r'diastolic_blood_pressure';
    yield serializers.serialize(
      object.diastolicBloodPressure,
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
    BloodPressureRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BloodPressureRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'systolic_blood_pressure':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.systolicBloodPressure = valueDes;
          break;
        case r'diastolic_blood_pressure':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.diastolicBloodPressure = valueDes;
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
  BloodPressureRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BloodPressureRequestBuilder();
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

