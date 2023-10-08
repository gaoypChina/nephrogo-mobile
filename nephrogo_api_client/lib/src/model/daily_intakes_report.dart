//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:nephrogo_api_client/src/model/daily_nutrient_norms_with_totals.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/intake.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_intakes_report.g.dart';

/// DailyIntakesReport
///
/// Properties:
/// * [date] 
/// * [intakes] 
/// * [dailyNutrientNormsAndTotals] 
@BuiltValue()
abstract class DailyIntakesReport implements Built<DailyIntakesReport, DailyIntakesReportBuilder> {
  @BuiltValueField(wireName: r'date')
  Date get date;

  @BuiltValueField(wireName: r'intakes')
  BuiltList<Intake> get intakes;

  @BuiltValueField(wireName: r'daily_nutrient_norms_and_totals')
  DailyNutrientNormsWithTotals get dailyNutrientNormsAndTotals;

  DailyIntakesReport._();

  factory DailyIntakesReport([void updates(DailyIntakesReportBuilder b)]) = _$DailyIntakesReport;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyIntakesReportBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyIntakesReport> get serializer => _$DailyIntakesReportSerializer();
}

class _$DailyIntakesReportSerializer implements PrimitiveSerializer<DailyIntakesReport> {
  @override
  final Iterable<Type> types = const [DailyIntakesReport, _$DailyIntakesReport];

  @override
  final String wireName = r'DailyIntakesReport';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyIntakesReport object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(Date),
    );
    yield r'intakes';
    yield serializers.serialize(
      object.intakes,
      specifiedType: const FullType(BuiltList, [FullType(Intake)]),
    );
    yield r'daily_nutrient_norms_and_totals';
    yield serializers.serialize(
      object.dailyNutrientNormsAndTotals,
      specifiedType: const FullType(DailyNutrientNormsWithTotals),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyIntakesReport object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DailyIntakesReportBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.date = valueDes;
          break;
        case r'intakes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Intake)]),
          ) as BuiltList<Intake>;
          result.intakes.replace(valueDes);
          break;
        case r'daily_nutrient_norms_and_totals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientNormsWithTotals),
          ) as DailyNutrientNormsWithTotals;
          result.dailyNutrientNormsAndTotals.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyIntakesReport deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyIntakesReportBuilder();
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

