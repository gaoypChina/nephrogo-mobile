//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nephrogo_api_client/src/model/automatic_peritoneal_dialysis.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'automatic_peritoneal_dialysis_period_response.g.dart';

/// AutomaticPeritonealDialysisPeriodResponse
///
/// Properties:
/// * [peritonealDialysis] 
@BuiltValue()
abstract class AutomaticPeritonealDialysisPeriodResponse implements Built<AutomaticPeritonealDialysisPeriodResponse, AutomaticPeritonealDialysisPeriodResponseBuilder> {
  @BuiltValueField(wireName: r'peritoneal_dialysis')
  BuiltList<AutomaticPeritonealDialysis> get peritonealDialysis;

  AutomaticPeritonealDialysisPeriodResponse._();

  factory AutomaticPeritonealDialysisPeriodResponse([void updates(AutomaticPeritonealDialysisPeriodResponseBuilder b)]) = _$AutomaticPeritonealDialysisPeriodResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AutomaticPeritonealDialysisPeriodResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AutomaticPeritonealDialysisPeriodResponse> get serializer => _$AutomaticPeritonealDialysisPeriodResponseSerializer();
}

class _$AutomaticPeritonealDialysisPeriodResponseSerializer implements PrimitiveSerializer<AutomaticPeritonealDialysisPeriodResponse> {
  @override
  final Iterable<Type> types = const [AutomaticPeritonealDialysisPeriodResponse, _$AutomaticPeritonealDialysisPeriodResponse];

  @override
  final String wireName = r'AutomaticPeritonealDialysisPeriodResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AutomaticPeritonealDialysisPeriodResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'peritoneal_dialysis';
    yield serializers.serialize(
      object.peritonealDialysis,
      specifiedType: const FullType(BuiltList, [FullType(AutomaticPeritonealDialysis)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AutomaticPeritonealDialysisPeriodResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AutomaticPeritonealDialysisPeriodResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'peritoneal_dialysis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AutomaticPeritonealDialysis)]),
          ) as BuiltList<AutomaticPeritonealDialysis>;
          result.peritonealDialysis.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AutomaticPeritonealDialysisPeriodResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AutomaticPeritonealDialysisPeriodResponseBuilder();
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

