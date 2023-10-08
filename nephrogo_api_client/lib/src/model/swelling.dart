//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/swelling_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'swelling.g.dart';

/// Swelling
///
/// Properties:
/// * [swelling] 
@BuiltValue()
abstract class Swelling implements Built<Swelling, SwellingBuilder> {
  @BuiltValueField(wireName: r'swelling')
  SwellingEnum get swelling;
  // enum swellingEnum {  Unknown,  Eyes,  WholeFace,  HandBreadth,  Hands,  Belly,  Knees,  Foot,  WholeLegs,  };

  Swelling._();

  factory Swelling([void updates(SwellingBuilder b)]) = _$Swelling;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SwellingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Swelling> get serializer => _$SwellingSerializer();
}

class _$SwellingSerializer implements PrimitiveSerializer<Swelling> {
  @override
  final Iterable<Type> types = const [Swelling, _$Swelling];

  @override
  final String wireName = r'Swelling';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Swelling object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'swelling';
    yield serializers.serialize(
      object.swelling,
      specifiedType: const FullType(SwellingEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Swelling object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SwellingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'swelling':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SwellingEnum),
          ) as SwellingEnum;
          result.swelling = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Swelling deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SwellingBuilder();
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

