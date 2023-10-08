//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'nutrition_summary_statistics_request.g.dart';

/// NutritionSummaryStatisticsRequest
///
/// Properties:
/// * [minReportDate] 
/// * [maxReportDate] 
@BuiltValue()
abstract class NutritionSummaryStatisticsRequest implements Built<NutritionSummaryStatisticsRequest, NutritionSummaryStatisticsRequestBuilder> {
  @BuiltValueField(wireName: r'min_report_date')
  Date? get minReportDate;

  @BuiltValueField(wireName: r'max_report_date')
  Date? get maxReportDate;

  NutritionSummaryStatisticsRequest._();

  factory NutritionSummaryStatisticsRequest([void updates(NutritionSummaryStatisticsRequestBuilder b)]) = _$NutritionSummaryStatisticsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NutritionSummaryStatisticsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NutritionSummaryStatisticsRequest> get serializer => _$NutritionSummaryStatisticsRequestSerializer();
}

class _$NutritionSummaryStatisticsRequestSerializer implements PrimitiveSerializer<NutritionSummaryStatisticsRequest> {
  @override
  final Iterable<Type> types = const [NutritionSummaryStatisticsRequest, _$NutritionSummaryStatisticsRequest];

  @override
  final String wireName = r'NutritionSummaryStatisticsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NutritionSummaryStatisticsRequest object, {
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
    NutritionSummaryStatisticsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NutritionSummaryStatisticsRequestBuilder result,
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
  NutritionSummaryStatisticsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NutritionSummaryStatisticsRequestBuilder();
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

