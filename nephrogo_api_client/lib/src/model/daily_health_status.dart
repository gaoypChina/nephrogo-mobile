//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/shortness_of_breath_enum.dart';
import 'package:nephrogo_api_client/src/model/swelling.dart';
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:nephrogo_api_client/src/model/swelling_difficulty_enum.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/manual_peritoneal_dialysis.dart';
import 'package:nephrogo_api_client/src/model/pulse.dart';
import 'package:nephrogo_api_client/src/model/appetite_enum.dart';
import 'package:nephrogo_api_client/src/model/blood_pressure.dart';
import 'package:nephrogo_api_client/src/model/well_feeling_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_health_status.g.dart';

/// DailyHealthStatus
///
/// Properties:
/// * [date] 
/// * [swellings] 
/// * [bloodPressures] 
/// * [pulses] 
/// * [manualPeritonealDialysis] 
/// * [weightKg] 
/// * [glucose] 
/// * [urineMl] 
/// * [swellingDifficulty] 
/// * [wellFeeling] 
/// * [appetite] 
/// * [shortnessOfBreath] 
@BuiltValue()
abstract class DailyHealthStatus implements Built<DailyHealthStatus, DailyHealthStatusBuilder> {
  @BuiltValueField(wireName: r'date')
  Date get date;

  @BuiltValueField(wireName: r'swellings')
  BuiltList<Swelling> get swellings;

  @BuiltValueField(wireName: r'blood_pressures')
  BuiltList<BloodPressure> get bloodPressures;

  @BuiltValueField(wireName: r'pulses')
  BuiltList<Pulse> get pulses;

  @BuiltValueField(wireName: r'manual_peritoneal_dialysis')
  BuiltList<ManualPeritonealDialysis> get manualPeritonealDialysis;

  @BuiltValueField(wireName: r'weight_kg')
  double? get weightKg;

  @BuiltValueField(wireName: r'glucose')
  double? get glucose;

  @BuiltValueField(wireName: r'urine_ml')
  int? get urineMl;

  @BuiltValueField(wireName: r'swelling_difficulty')
  SwellingDifficultyEnum? get swellingDifficulty;
  // enum swellingDifficultyEnum {  Unknown,  0+,  1+,  2+,  3+,  4+,  };

  @BuiltValueField(wireName: r'well_feeling')
  WellFeelingEnum? get wellFeeling;
  // enum wellFeelingEnum {  Unknown,  Perfect,  Good,  Average,  Bad,  VeryBad,  };

  @BuiltValueField(wireName: r'appetite')
  AppetiteEnum? get appetite;
  // enum appetiteEnum {  Unknown,  Perfect,  Good,  Average,  Bad,  VeryBad,  };

  @BuiltValueField(wireName: r'shortness_of_breath')
  ShortnessOfBreathEnum? get shortnessOfBreath;
  // enum shortnessOfBreathEnum {  Unknown,  No,  Light,  Average,  Severe,  Backbreaking,  };

  DailyHealthStatus._();

  factory DailyHealthStatus([void updates(DailyHealthStatusBuilder b)]) = _$DailyHealthStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyHealthStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyHealthStatus> get serializer => _$DailyHealthStatusSerializer();
}

class _$DailyHealthStatusSerializer implements PrimitiveSerializer<DailyHealthStatus> {
  @override
  final Iterable<Type> types = const [DailyHealthStatus, _$DailyHealthStatus];

  @override
  final String wireName = r'DailyHealthStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyHealthStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(Date),
    );
    yield r'swellings';
    yield serializers.serialize(
      object.swellings,
      specifiedType: const FullType(BuiltList, [FullType(Swelling)]),
    );
    yield r'blood_pressures';
    yield serializers.serialize(
      object.bloodPressures,
      specifiedType: const FullType(BuiltList, [FullType(BloodPressure)]),
    );
    yield r'pulses';
    yield serializers.serialize(
      object.pulses,
      specifiedType: const FullType(BuiltList, [FullType(Pulse)]),
    );
    yield r'manual_peritoneal_dialysis';
    yield serializers.serialize(
      object.manualPeritonealDialysis,
      specifiedType: const FullType(BuiltList, [FullType(ManualPeritonealDialysis)]),
    );
    if (object.weightKg != null) {
      yield r'weight_kg';
      yield serializers.serialize(
        object.weightKg,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.glucose != null) {
      yield r'glucose';
      yield serializers.serialize(
        object.glucose,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.urineMl != null) {
      yield r'urine_ml';
      yield serializers.serialize(
        object.urineMl,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.swellingDifficulty != null) {
      yield r'swelling_difficulty';
      yield serializers.serialize(
        object.swellingDifficulty,
        specifiedType: const FullType(SwellingDifficultyEnum),
      );
    }
    if (object.wellFeeling != null) {
      yield r'well_feeling';
      yield serializers.serialize(
        object.wellFeeling,
        specifiedType: const FullType(WellFeelingEnum),
      );
    }
    if (object.appetite != null) {
      yield r'appetite';
      yield serializers.serialize(
        object.appetite,
        specifiedType: const FullType(AppetiteEnum),
      );
    }
    if (object.shortnessOfBreath != null) {
      yield r'shortness_of_breath';
      yield serializers.serialize(
        object.shortnessOfBreath,
        specifiedType: const FullType(ShortnessOfBreathEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyHealthStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DailyHealthStatusBuilder result,
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
        case r'swellings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Swelling)]),
          ) as BuiltList<Swelling>;
          result.swellings.replace(valueDes);
          break;
        case r'blood_pressures':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BloodPressure)]),
          ) as BuiltList<BloodPressure>;
          result.bloodPressures.replace(valueDes);
          break;
        case r'pulses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Pulse)]),
          ) as BuiltList<Pulse>;
          result.pulses.replace(valueDes);
          break;
        case r'manual_peritoneal_dialysis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ManualPeritonealDialysis)]),
          ) as BuiltList<ManualPeritonealDialysis>;
          result.manualPeritonealDialysis.replace(valueDes);
          break;
        case r'weight_kg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.weightKg = valueDes;
          break;
        case r'glucose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.glucose = valueDes;
          break;
        case r'urine_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.urineMl = valueDes;
          break;
        case r'swelling_difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SwellingDifficultyEnum),
          ) as SwellingDifficultyEnum;
          result.swellingDifficulty = valueDes;
          break;
        case r'well_feeling':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WellFeelingEnum),
          ) as WellFeelingEnum;
          result.wellFeeling = valueDes;
          break;
        case r'appetite':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AppetiteEnum),
          ) as AppetiteEnum;
          result.appetite = valueDes;
          break;
        case r'shortness_of_breath':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ShortnessOfBreathEnum),
          ) as ShortnessOfBreathEnum;
          result.shortnessOfBreath = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyHealthStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyHealthStatusBuilder();
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

