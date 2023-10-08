//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/daily_intakes_report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'nutrient_weekly_screen_response.g.dart';

/// NutrientWeeklyScreenResponse
///
/// Properties:
/// * [earliestReportDate] 
/// * [dailyIntakesReports] 
@BuiltValue()
abstract class NutrientWeeklyScreenResponse implements Built<NutrientWeeklyScreenResponse, NutrientWeeklyScreenResponseBuilder> {
  @BuiltValueField(wireName: r'earliest_report_date')
  Date? get earliestReportDate;

  @BuiltValueField(wireName: r'daily_intakes_reports')
  BuiltList<DailyIntakesReport> get dailyIntakesReports;

  NutrientWeeklyScreenResponse._();

  factory NutrientWeeklyScreenResponse([void updates(NutrientWeeklyScreenResponseBuilder b)]) = _$NutrientWeeklyScreenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NutrientWeeklyScreenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NutrientWeeklyScreenResponse> get serializer => _$NutrientWeeklyScreenResponseSerializer();
}

class _$NutrientWeeklyScreenResponseSerializer implements PrimitiveSerializer<NutrientWeeklyScreenResponse> {
  @override
  final Iterable<Type> types = const [NutrientWeeklyScreenResponse, _$NutrientWeeklyScreenResponse];

  @override
  final String wireName = r'NutrientWeeklyScreenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NutrientWeeklyScreenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'earliest_report_date';
    yield object.earliestReportDate == null ? null : serializers.serialize(
      object.earliestReportDate,
      specifiedType: const FullType.nullable(Date),
    );
    yield r'daily_intakes_reports';
    yield serializers.serialize(
      object.dailyIntakesReports,
      specifiedType: const FullType(BuiltList, [FullType(DailyIntakesReport)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NutrientWeeklyScreenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NutrientWeeklyScreenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'earliest_report_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.earliestReportDate = valueDes;
          break;
        case r'daily_intakes_reports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DailyIntakesReport)]),
          ) as BuiltList<DailyIntakesReport>;
          result.dailyIntakesReports.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NutrientWeeklyScreenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NutrientWeeklyScreenResponseBuilder();
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

