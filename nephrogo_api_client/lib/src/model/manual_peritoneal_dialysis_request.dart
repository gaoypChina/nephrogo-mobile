//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/dialysis_solution_enum.dart';
import 'package:nephrogo_api_client/src/model/dialysate_color_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'manual_peritoneal_dialysis_request.g.dart';

/// ManualPeritonealDialysisRequest
///
/// Properties:
/// * [startedAt] 
/// * [solutionInMl] 
/// * [isCompleted] 
/// * [dialysisSolution] 
/// * [solutionOutMl] 
/// * [dialysateColor] 
/// * [notes] 
@BuiltValue()
abstract class ManualPeritonealDialysisRequest implements Built<ManualPeritonealDialysisRequest, ManualPeritonealDialysisRequestBuilder> {
  @BuiltValueField(wireName: r'started_at')
  DateTime get startedAt;

  @BuiltValueField(wireName: r'solution_in_ml')
  int get solutionInMl;

  @BuiltValueField(wireName: r'is_completed')
  bool? get isCompleted;

  @BuiltValueField(wireName: r'dialysis_solution')
  DialysisSolutionEnum? get dialysisSolution;
  // enum dialysisSolutionEnum {  Unknown,  Yellow,  Green,  Orange,  Blue,  Purple,  };

  @BuiltValueField(wireName: r'solution_out_ml')
  int? get solutionOutMl;

  @BuiltValueField(wireName: r'dialysate_color')
  DialysateColorEnum? get dialysateColor;
  // enum dialysateColorEnum {  Unknown,  Transparent,  Pink,  CloudyYellowish,  Greenish,  Brown,  CloudyWhite,  };

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  ManualPeritonealDialysisRequest._();

  factory ManualPeritonealDialysisRequest([void updates(ManualPeritonealDialysisRequestBuilder b)]) = _$ManualPeritonealDialysisRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ManualPeritonealDialysisRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ManualPeritonealDialysisRequest> get serializer => _$ManualPeritonealDialysisRequestSerializer();
}

class _$ManualPeritonealDialysisRequestSerializer implements PrimitiveSerializer<ManualPeritonealDialysisRequest> {
  @override
  final Iterable<Type> types = const [ManualPeritonealDialysisRequest, _$ManualPeritonealDialysisRequest];

  @override
  final String wireName = r'ManualPeritonealDialysisRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ManualPeritonealDialysisRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'started_at';
    yield serializers.serialize(
      object.startedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'solution_in_ml';
    yield serializers.serialize(
      object.solutionInMl,
      specifiedType: const FullType(int),
    );
    if (object.isCompleted != null) {
      yield r'is_completed';
      yield serializers.serialize(
        object.isCompleted,
        specifiedType: const FullType(bool),
      );
    }
    if (object.dialysisSolution != null) {
      yield r'dialysis_solution';
      yield serializers.serialize(
        object.dialysisSolution,
        specifiedType: const FullType(DialysisSolutionEnum),
      );
    }
    if (object.solutionOutMl != null) {
      yield r'solution_out_ml';
      yield serializers.serialize(
        object.solutionOutMl,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ManualPeritonealDialysisRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ManualPeritonealDialysisRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'started_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startedAt = valueDes;
          break;
        case r'solution_in_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.solutionInMl = valueDes;
          break;
        case r'is_completed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCompleted = valueDes;
          break;
        case r'dialysis_solution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DialysisSolutionEnum),
          ) as DialysisSolutionEnum;
          result.dialysisSolution = valueDes;
          break;
        case r'solution_out_ml':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.solutionOutMl = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ManualPeritonealDialysisRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ManualPeritonealDialysisRequestBuilder();
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

