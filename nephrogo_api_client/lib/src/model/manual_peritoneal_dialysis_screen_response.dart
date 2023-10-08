//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/daily_health_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/manual_peritoneal_dialysis.dart';
import 'package:nephrogo_api_client/src/model/daily_intakes_light_report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'manual_peritoneal_dialysis_screen_response.g.dart';

/// ManualPeritonealDialysisScreenResponse
///
/// Properties:
/// * [peritonealDialysisInProgress] 
/// * [lastPeritonealDialysis] 
/// * [lastWeekLightNutritionReports] 
/// * [lastWeekHealthStatuses] 
@BuiltValue()
abstract class ManualPeritonealDialysisScreenResponse implements Built<ManualPeritonealDialysisScreenResponse, ManualPeritonealDialysisScreenResponseBuilder> {
  @BuiltValueField(wireName: r'peritoneal_dialysis_in_progress')
  ManualPeritonealDialysis? get peritonealDialysisInProgress;

  @BuiltValueField(wireName: r'last_peritoneal_dialysis')
  BuiltList<ManualPeritonealDialysis> get lastPeritonealDialysis;

  @BuiltValueField(wireName: r'last_week_light_nutrition_reports')
  BuiltList<DailyIntakesLightReport> get lastWeekLightNutritionReports;

  @BuiltValueField(wireName: r'last_week_health_statuses')
  BuiltList<DailyHealthStatus> get lastWeekHealthStatuses;

  ManualPeritonealDialysisScreenResponse._();

  factory ManualPeritonealDialysisScreenResponse([void updates(ManualPeritonealDialysisScreenResponseBuilder b)]) = _$ManualPeritonealDialysisScreenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ManualPeritonealDialysisScreenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ManualPeritonealDialysisScreenResponse> get serializer => _$ManualPeritonealDialysisScreenResponseSerializer();
}

class _$ManualPeritonealDialysisScreenResponseSerializer implements PrimitiveSerializer<ManualPeritonealDialysisScreenResponse> {
  @override
  final Iterable<Type> types = const [ManualPeritonealDialysisScreenResponse, _$ManualPeritonealDialysisScreenResponse];

  @override
  final String wireName = r'ManualPeritonealDialysisScreenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ManualPeritonealDialysisScreenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'peritoneal_dialysis_in_progress';
    yield object.peritonealDialysisInProgress == null ? null : serializers.serialize(
      object.peritonealDialysisInProgress,
      specifiedType: const FullType.nullable(ManualPeritonealDialysis),
    );
    yield r'last_peritoneal_dialysis';
    yield serializers.serialize(
      object.lastPeritonealDialysis,
      specifiedType: const FullType(BuiltList, [FullType(ManualPeritonealDialysis)]),
    );
    yield r'last_week_light_nutrition_reports';
    yield serializers.serialize(
      object.lastWeekLightNutritionReports,
      specifiedType: const FullType(BuiltList, [FullType(DailyIntakesLightReport)]),
    );
    yield r'last_week_health_statuses';
    yield serializers.serialize(
      object.lastWeekHealthStatuses,
      specifiedType: const FullType(BuiltList, [FullType(DailyHealthStatus)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ManualPeritonealDialysisScreenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ManualPeritonealDialysisScreenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'peritoneal_dialysis_in_progress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ManualPeritonealDialysis),
          ) as ManualPeritonealDialysis?;
          if (valueDes == null) continue;
          result.peritonealDialysisInProgress.replace(valueDes);
          break;
        case r'last_peritoneal_dialysis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ManualPeritonealDialysis)]),
          ) as BuiltList<ManualPeritonealDialysis>;
          result.lastPeritonealDialysis.replace(valueDes);
          break;
        case r'last_week_light_nutrition_reports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DailyIntakesLightReport)]),
          ) as BuiltList<DailyIntakesLightReport>;
          result.lastWeekLightNutritionReports.replace(valueDes);
          break;
        case r'last_week_health_statuses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DailyHealthStatus)]),
          ) as BuiltList<DailyHealthStatus>;
          result.lastWeekHealthStatuses.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ManualPeritonealDialysisScreenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ManualPeritonealDialysisScreenResponseBuilder();
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

