//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/daily_intakes_report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_intakes_report_response.g.dart';

/// DailyIntakesReportResponse
///
/// Properties:
/// * [dailyIntakesReport] 
@BuiltValue()
abstract class DailyIntakesReportResponse implements Built<DailyIntakesReportResponse, DailyIntakesReportResponseBuilder> {
  @BuiltValueField(wireName: r'daily_intakes_report')
  DailyIntakesReport get dailyIntakesReport;

  DailyIntakesReportResponse._();

  factory DailyIntakesReportResponse([void updates(DailyIntakesReportResponseBuilder b)]) = _$DailyIntakesReportResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyIntakesReportResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyIntakesReportResponse> get serializer => _$DailyIntakesReportResponseSerializer();
}

class _$DailyIntakesReportResponseSerializer implements PrimitiveSerializer<DailyIntakesReportResponse> {
  @override
  final Iterable<Type> types = const [DailyIntakesReportResponse, _$DailyIntakesReportResponse];

  @override
  final String wireName = r'DailyIntakesReportResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyIntakesReportResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'daily_intakes_report';
    yield serializers.serialize(
      object.dailyIntakesReport,
      specifiedType: const FullType(DailyIntakesReport),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyIntakesReportResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DailyIntakesReportResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'daily_intakes_report':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyIntakesReport),
          ) as DailyIntakesReport;
          result.dailyIntakesReport.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyIntakesReportResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyIntakesReportResponseBuilder();
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

