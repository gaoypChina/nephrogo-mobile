//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'blood_pressure.g.dart';

/// BloodPressure
///
/// Properties:
/// * [id] 
/// * [systolicBloodPressure] 
/// * [diastolicBloodPressure] 
/// * [measuredAt] 
@BuiltValue()
abstract class BloodPressure implements Built<BloodPressure, BloodPressureBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'systolic_blood_pressure')
  int get systolicBloodPressure;

  @BuiltValueField(wireName: r'diastolic_blood_pressure')
  int get diastolicBloodPressure;

  @BuiltValueField(wireName: r'measured_at')
  DateTime get measuredAt;

  BloodPressure._();

  factory BloodPressure([void updates(BloodPressureBuilder b)]) = _$BloodPressure;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BloodPressureBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BloodPressure> get serializer => _$BloodPressureSerializer();
}

class _$BloodPressureSerializer implements PrimitiveSerializer<BloodPressure> {
  @override
  final Iterable<Type> types = const [BloodPressure, _$BloodPressure];

  @override
  final String wireName = r'BloodPressure';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BloodPressure object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
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
    BloodPressure object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BloodPressureBuilder result,
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
  BloodPressure deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BloodPressureBuilder();
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

