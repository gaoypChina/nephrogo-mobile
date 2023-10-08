//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:nephrogo_api_client/src/model/daily_health_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_status_weekly_screen_response.g.dart';

/// HealthStatusWeeklyScreenResponse
///
/// Properties:
/// * [earliestHealthStatusDate] 
/// * [dailyHealthStatuses] 
@BuiltValue()
abstract class HealthStatusWeeklyScreenResponse implements Built<HealthStatusWeeklyScreenResponse, HealthStatusWeeklyScreenResponseBuilder> {
  @BuiltValueField(wireName: r'earliest_health_status_date')
  Date? get earliestHealthStatusDate;

  @BuiltValueField(wireName: r'daily_health_statuses')
  BuiltList<DailyHealthStatus> get dailyHealthStatuses;

  HealthStatusWeeklyScreenResponse._();

  factory HealthStatusWeeklyScreenResponse([void updates(HealthStatusWeeklyScreenResponseBuilder b)]) = _$HealthStatusWeeklyScreenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HealthStatusWeeklyScreenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HealthStatusWeeklyScreenResponse> get serializer => _$HealthStatusWeeklyScreenResponseSerializer();
}

class _$HealthStatusWeeklyScreenResponseSerializer implements PrimitiveSerializer<HealthStatusWeeklyScreenResponse> {
  @override
  final Iterable<Type> types = const [HealthStatusWeeklyScreenResponse, _$HealthStatusWeeklyScreenResponse];

  @override
  final String wireName = r'HealthStatusWeeklyScreenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HealthStatusWeeklyScreenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'earliest_health_status_date';
    yield object.earliestHealthStatusDate == null ? null : serializers.serialize(
      object.earliestHealthStatusDate,
      specifiedType: const FullType.nullable(Date),
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
    HealthStatusWeeklyScreenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HealthStatusWeeklyScreenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'earliest_health_status_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.earliestHealthStatusDate = valueDes;
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
  HealthStatusWeeklyScreenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HealthStatusWeeklyScreenResponseBuilder();
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

