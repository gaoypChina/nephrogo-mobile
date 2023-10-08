//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:nephrogo_api_client/src/model/daily_health_status.dart';
import 'package:nephrogo_api_client/src/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/src/model/dialysate_color_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'automatic_peritoneal_dialysis.g.dart';

/// AutomaticPeritonealDialysis
///
/// Properties:
/// * [date] 
/// * [dailyHealthStatus] 
/// * [dailyIntakesLightReport] 
/// * [startedAt] 
/// * [isCompleted] 
/// * [solutionGreenInMl] 
/// * [solutionYellowInMl] 
/// * [solutionOrangeInMl] 
/// * [solutionBlueInMl] 
/// * [solutionPurpleInMl] 
/// * [initialDrainingMl] 
/// * [totalDrainVolumeMl] 
/// * [lastFillMl] 
/// * [totalUltrafiltrationMl] 
/// * [dialysateColor] 
/// * [notes] 
/// * [finishedAt] 
@BuiltValue()
abstract class AutomaticPeritonealDialysis implements Built<AutomaticPeritonealDialysis, AutomaticPeritonealDialysisBuilder> {
  @BuiltValueField(wireName: r'date')
  Date get date;

  @BuiltValueField(wireName: r'daily_health_status')
  DailyHealthStatus get dailyHealthStatus;

  @BuiltValueField(wireName: r'daily_intakes_light_report')
  DailyIntakesLightReport get dailyIntakesLightReport;

  @BuiltValueField(wireName: r'started_at')
  DateTime get startedAt;

  @BuiltValueField(wireName: r'is_completed')
  bool? get isCompleted;

  @BuiltValueField(wireName: r'solution_green_in_ml')
  int? get solutionGreenInMl;

  @BuiltValueField(wireName: r'solution_yellow_in_ml')
  int? get solutionYellowInMl;

  @BuiltValueField(wireName: r'solution_orange_in_ml')
  int? get solutionOrangeInMl;

  @BuiltValueField(wireName: r'solution_blue_in_ml')
  int? get solutionBlueInMl;

  @BuiltValueField(wireName: r'solution_purple_in_ml')
  int? get solutionPurpleInMl;

  @BuiltValueField(wireName: r'initial_draining_ml')
  int? get initialDrainingMl;

  @BuiltValueField(wireName: r'total_drain_volume_ml')
  int? get totalDrainVolumeMl;

  @BuiltValueField(wireName: r'last_fill_ml')
  int? get lastFillMl;

  @BuiltValueField(wireName: r'total_ultrafiltration_ml')
  int? get totalUltrafiltrationMl;

  @BuiltValueField(wireName: r'dialysate_color')
  DialysateColorEnum? get dialysateColor;
  // enum dialysateColorEnum {  Unknown,  Transparent,  Pink,  CloudyYellowish,  Greenish,  Brown,  CloudyWhite,  };

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'finished_at')
  DateTime? get finishedAt;

  AutomaticPeritonealDialysis._();

  factory AutomaticPeritonealDialysis([void updates(AutomaticPeritonealDialysisBuilder b)]) = _$AutomaticPeritonealDialysis;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AutomaticPeritonealDialysisBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AutomaticPeritonealDialysis> get serializer => _$AutomaticPeritonealDialysisSerializer();
}

class _$AutomaticPeritonealDialysisSerializer implements PrimitiveSerializer<AutomaticPeritonealDialysis> {
  @override
  final Iterable<Type> types = const [AutomaticPeritonealDialysis, _$AutomaticPeritonealDialysis];

  @override
  final String wireName = r'AutomaticPeritonealDialysis';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AutomaticPeritonealDialysis object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(Date),
    );
    yield r'daily_health_status';
    yield serializers.serialize(
      object.dailyHealthStatus,
      specifiedType: const FullType(DailyHealthStatus),
    );
    yield r'daily_intakes_light_report';
    yield serializers.serialize(
      object.dailyIntakesLightReport,
      specifiedType: const FullType(DailyIntakesLightReport),
    );
    yield r'started_at';
    yield serializers.serialize(
      object.startedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.isCompleted != null) {
      yield r'is_completed';
      yield serializers.serialize(
        object.isCompleted,
        specifiedType: const FullType(bool),
      );
    }
    if (object.solutionGreenInMl != null) {
      yield r'solution_green_in_ml';
      yield serializers.serialize(
        object.solutionGreenInMl,
        specifiedType: const FullType(int),
      );
    }
    if (object.solutionYellowInMl != null) {
      yield r'solution_yellow_in_ml';
      yield serializers.serialize(
        object.solutionYellowInMl,
        specifiedType: const FullType(int),
      );
    }
    if (object.solutionOrangeInMl != null) {
      yield r'solution_orange_in_ml';
      yield serializers.serialize(
        object.solutionOrangeInMl,
        specifiedType: const FullType(int),
      );
    }
    if (object.solutionBlueInMl != null) {
      yield r'solution_blue_in_ml';
      yield serializers.serialize(
        object.solutionBlueInMl,
        specifiedType: const FullType(int),
      );
    }
    if (object.solutionPurpleInMl != null) {
      yield r'solution_purple_in_ml';
      yield serializers.serialize(
        object.solutionPurpleInMl,
        specifiedType: const FullType(int),
      );
    }
    if (object.initialDrainingMl != null) {
      yield r'initial_draining_ml';
      yield serializers.serialize(
        object.initialDrainingMl,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.totalDrainVolumeMl != null) {
      yield r'total_drain_volume_ml';
      yield serializers.serialize(
        object.totalDrainVolumeMl,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.lastFillMl != null) {
      yield r'last_fill_ml';
      yield serializers.serialize(
        object.lastFillMl,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.totalUltrafiltrationMl != null) {
      yield r'total_ultrafiltration_ml';
      yield serializers.serialize(
        object.totalUltrafiltrationMl,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.dialysateColor != null) {
      yield r'dialysate_color';
      yield serializers.serialize(
        object.dialysateColor,
        specifiedType: const FullType(DialysateColorEnum),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType(String),
      );
    }
    if (object.finishedAt != null) {
      yield r'finished_at';
      yield serializers.serialize(
        object.finishedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AutomaticPeritonealDialysis object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AutomaticPeritonealDialysisBuilder result,
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
        case r'daily_health_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyHealthStatus),
          ) as DailyHealthStatus;
          result.dailyHealthStatus.replace(valueDes);
          break;
        case r'daily_intakes_light_report':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyIntakesLightReport),
          ) as DailyIntakesLightReport;
          result.dailyIntakesLightReport.replace(valueDes);
          break;
        case r'started_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startedAt = valueDes;
          break;
        case r'is_completed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCompleted = valueDes;
          break;
        case r'solution_green_in_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.solutionGreenInMl = valueDes;
          break;
        case r'solution_yellow_in_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.solutionYellowInMl = valueDes;
          break;
        case r'solution_orange_in_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.solutionOrangeInMl = valueDes;
          break;
        case r'solution_blue_in_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.solutionBlueInMl = valueDes;
          break;
        case r'solution_purple_in_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.solutionPurpleInMl = valueDes;
          break;
        case r'initial_draining_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.initialDrainingMl = valueDes;
          break;
        case r'total_drain_volume_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.totalDrainVolumeMl = valueDes;
          break;
        case r'last_fill_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.lastFillMl = valueDes;
          break;
        case r'total_ultrafiltration_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.totalUltrafiltrationMl = valueDes;
          break;
        case r'dialysate_color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DialysateColorEnum),
          ) as DialysateColorEnum;
          result.dialysateColor = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notes = valueDes;
          break;
        case r'finished_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.finishedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AutomaticPeritonealDialysis deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AutomaticPeritonealDialysisBuilder();
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

