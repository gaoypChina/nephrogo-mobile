//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:nephrogo_api_client/src/model/daily_nutrient_norms_with_totals.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_intakes_light_report.g.dart';

/// DailyIntakesLightReport
///
/// Properties:
/// * [date] 
/// * [nutrientNormsAndTotals] 
@BuiltValue()
abstract class DailyIntakesLightReport implements Built<DailyIntakesLightReport, DailyIntakesLightReportBuilder> {
  @BuiltValueField(wireName: r'date')
  Date get date;

  @BuiltValueField(wireName: r'nutrient_norms_and_totals')
  DailyNutrientNormsWithTotals get nutrientNormsAndTotals;

  DailyIntakesLightReport._();

  factory DailyIntakesLightReport([void updates(DailyIntakesLightReportBuilder b)]) = _$DailyIntakesLightReport;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyIntakesLightReportBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyIntakesLightReport> get serializer => _$DailyIntakesLightReportSerializer();
}

class _$DailyIntakesLightReportSerializer implements PrimitiveSerializer<DailyIntakesLightReport> {
  @override
  final Iterable<Type> types = const [DailyIntakesLightReport, _$DailyIntakesLightReport];

  @override
  final String wireName = r'DailyIntakesLightReport';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyIntakesLightReport object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(Date),
    );
    yield r'nutrient_norms_and_totals';
    yield serializers.serialize(
      object.nutrientNormsAndTotals,
      specifiedType: const FullType(DailyNutrientNormsWithTotals),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyIntakesLightReport object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DailyIntakesLightReportBuilder result,
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
        case r'nutrient_norms_and_totals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyNutrientNormsWithTotals),
          ) as DailyNutrientNormsWithTotals;
          result.nutrientNormsAndTotals.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyIntakesLightReport deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyIntakesLightReportBuilder();
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

