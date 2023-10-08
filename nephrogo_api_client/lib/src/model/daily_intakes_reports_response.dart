//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/daily_intakes_light_report.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_intakes_reports_response.g.dart';

/// DailyIntakesReportsResponse
///
/// Properties:
/// * [dailyIntakesLightReports] 
@BuiltValue()
abstract class DailyIntakesReportsResponse implements Built<DailyIntakesReportsResponse, DailyIntakesReportsResponseBuilder> {
  @BuiltValueField(wireName: r'daily_intakes_light_reports')
  BuiltList<DailyIntakesLightReport> get dailyIntakesLightReports;

  DailyIntakesReportsResponse._();

  factory DailyIntakesReportsResponse([void updates(DailyIntakesReportsResponseBuilder b)]) = _$DailyIntakesReportsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyIntakesReportsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyIntakesReportsResponse> get serializer => _$DailyIntakesReportsResponseSerializer();
}

class _$DailyIntakesReportsResponseSerializer implements PrimitiveSerializer<DailyIntakesReportsResponse> {
  @override
  final Iterable<Type> types = const [DailyIntakesReportsResponse, _$DailyIntakesReportsResponse];

  @override
  final String wireName = r'DailyIntakesReportsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyIntakesReportsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'daily_intakes_light_reports';
    yield serializers.serialize(
      object.dailyIntakesLightReports,
      specifiedType: const FullType(BuiltList, [FullType(DailyIntakesLightReport)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyIntakesReportsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DailyIntakesReportsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'daily_intakes_light_reports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DailyIntakesLightReport)]),
          ) as BuiltList<DailyIntakesLightReport>;
          result.dailyIntakesLightReports.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyIntakesReportsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyIntakesReportsResponseBuilder();
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

