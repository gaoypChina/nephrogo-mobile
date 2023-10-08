//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'nutrition_summary_statistics.g.dart';

/// NutritionSummaryStatistics
///
/// Properties:
/// * [minReportDate] 
/// * [maxReportDate] 
@BuiltValue()
abstract class NutritionSummaryStatistics implements Built<NutritionSummaryStatistics, NutritionSummaryStatisticsBuilder> {
  @BuiltValueField(wireName: r'min_report_date')
  Date? get minReportDate;

  @BuiltValueField(wireName: r'max_report_date')
  Date? get maxReportDate;

  NutritionSummaryStatistics._();

  factory NutritionSummaryStatistics([void updates(NutritionSummaryStatisticsBuilder b)]) = _$NutritionSummaryStatistics;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NutritionSummaryStatisticsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NutritionSummaryStatistics> get serializer => _$NutritionSummaryStatisticsSerializer();
}

class _$NutritionSummaryStatisticsSerializer implements PrimitiveSerializer<NutritionSummaryStatistics> {
  @override
  final Iterable<Type> types = const [NutritionSummaryStatistics, _$NutritionSummaryStatistics];

  @override
  final String wireName = r'NutritionSummaryStatistics';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NutritionSummaryStatistics object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'min_report_date';
    yield object.minReportDate == null ? null : serializers.serialize(
      object.minReportDate,
      specifiedType: const FullType.nullable(Date),
    );
    yield r'max_report_date';
    yield object.maxReportDate == null ? null : serializers.serialize(
      object.maxReportDate,
      specifiedType: const FullType.nullable(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NutritionSummaryStatistics object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NutritionSummaryStatisticsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'min_report_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.minReportDate = valueDes;
          break;
        case r'max_report_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.maxReportDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NutritionSummaryStatistics deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NutritionSummaryStatisticsBuilder();
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

