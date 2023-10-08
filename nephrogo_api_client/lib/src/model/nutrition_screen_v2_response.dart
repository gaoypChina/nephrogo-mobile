//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/nutrition_summary_statistics.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/src/model/intake.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'nutrition_screen_v2_response.g.dart';

/// NutritionScreenV2Response
///
/// Properties:
/// * [todayLightNutritionReport] 
/// * [lastWeekLightNutritionReports] 
/// * [currentMonthNutritionReports] 
/// * [latestIntakes] 
/// * [nutritionSummaryStatistics] 
@BuiltValue()
abstract class NutritionScreenV2Response implements Built<NutritionScreenV2Response, NutritionScreenV2ResponseBuilder> {
  @BuiltValueField(wireName: r'today_light_nutrition_report')
  DailyIntakesLightReport get todayLightNutritionReport;

  @BuiltValueField(wireName: r'last_week_light_nutrition_reports')
  BuiltList<DailyIntakesLightReport> get lastWeekLightNutritionReports;

  @BuiltValueField(wireName: r'current_month_nutrition_reports')
  BuiltList<DailyIntakesLightReport> get currentMonthNutritionReports;

  @BuiltValueField(wireName: r'latest_intakes')
  BuiltList<Intake> get latestIntakes;

  @BuiltValueField(wireName: r'nutrition_summary_statistics')
  NutritionSummaryStatistics get nutritionSummaryStatistics;

  NutritionScreenV2Response._();

  factory NutritionScreenV2Response([void updates(NutritionScreenV2ResponseBuilder b)]) = _$NutritionScreenV2Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NutritionScreenV2ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NutritionScreenV2Response> get serializer => _$NutritionScreenV2ResponseSerializer();
}

class _$NutritionScreenV2ResponseSerializer implements PrimitiveSerializer<NutritionScreenV2Response> {
  @override
  final Iterable<Type> types = const [NutritionScreenV2Response, _$NutritionScreenV2Response];

  @override
  final String wireName = r'NutritionScreenV2Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NutritionScreenV2Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'today_light_nutrition_report';
    yield serializers.serialize(
      object.todayLightNutritionReport,
      specifiedType: const FullType(DailyIntakesLightReport),
    );
    yield r'last_week_light_nutrition_reports';
    yield serializers.serialize(
      object.lastWeekLightNutritionReports,
      specifiedType: const FullType(BuiltList, [FullType(DailyIntakesLightReport)]),
    );
    yield r'current_month_nutrition_reports';
    yield serializers.serialize(
      object.currentMonthNutritionReports,
      specifiedType: const FullType(BuiltList, [FullType(DailyIntakesLightReport)]),
    );
    yield r'latest_intakes';
    yield serializers.serialize(
      object.latestIntakes,
      specifiedType: const FullType(BuiltList, [FullType(Intake)]),
    );
    yield r'nutrition_summary_statistics';
    yield serializers.serialize(
      object.nutritionSummaryStatistics,
      specifiedType: const FullType(NutritionSummaryStatistics),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NutritionScreenV2Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NutritionScreenV2ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'today_light_nutrition_report':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyIntakesLightReport),
          ) as DailyIntakesLightReport;
          result.todayLightNutritionReport.replace(valueDes);
          break;
        case r'last_week_light_nutrition_reports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DailyIntakesLightReport)]),
          ) as BuiltList<DailyIntakesLightReport>;
          result.lastWeekLightNutritionReports.replace(valueDes);
          break;
        case r'current_month_nutrition_reports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DailyIntakesLightReport)]),
          ) as BuiltList<DailyIntakesLightReport>;
          result.currentMonthNutritionReports.replace(valueDes);
          break;
        case r'latest_intakes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Intake)]),
          ) as BuiltList<Intake>;
          result.latestIntakes.replace(valueDes);
          break;
        case r'nutrition_summary_statistics':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NutritionSummaryStatistics),
          ) as NutritionSummaryStatistics;
          result.nutritionSummaryStatistics.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NutritionScreenV2Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NutritionScreenV2ResponseBuilder();
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

