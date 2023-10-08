//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/daily_health_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_status_screen_response.g.dart';

/// HealthStatusScreenResponse
///
/// Properties:
/// * [hasAnyStatuses] 
/// * [dailyHealthStatuses] 
@BuiltValue()
abstract class HealthStatusScreenResponse implements Built<HealthStatusScreenResponse, HealthStatusScreenResponseBuilder> {
  @BuiltValueField(wireName: r'has_any_statuses')
  bool get hasAnyStatuses;

  @BuiltValueField(wireName: r'daily_health_statuses')
  BuiltList<DailyHealthStatus> get dailyHealthStatuses;

  HealthStatusScreenResponse._();

  factory HealthStatusScreenResponse([void updates(HealthStatusScreenResponseBuilder b)]) = _$HealthStatusScreenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HealthStatusScreenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HealthStatusScreenResponse> get serializer => _$HealthStatusScreenResponseSerializer();
}

class _$HealthStatusScreenResponseSerializer implements PrimitiveSerializer<HealthStatusScreenResponse> {
  @override
  final Iterable<Type> types = const [HealthStatusScreenResponse, _$HealthStatusScreenResponse];

  @override
  final String wireName = r'HealthStatusScreenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HealthStatusScreenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'has_any_statuses';
    yield serializers.serialize(
      object.hasAnyStatuses,
      specifiedType: const FullType(bool),
    );
    yield r'daily_health_statuses';
    yield serializers.serialize(
      object.dailyHealthStatuses,
      specifiedType: const FullType(BuiltList, [FullType(DailyHealthStatus)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HealthStatusScreenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HealthStatusScreenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'has_any_statuses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAnyStatuses = valueDes;
          break;
        case r'daily_health_statuses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DailyHealthStatus)]),
          ) as BuiltList<DailyHealthStatus>;
          result.dailyHealthStatuses.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HealthStatusScreenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HealthStatusScreenResponseBuilder();
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

