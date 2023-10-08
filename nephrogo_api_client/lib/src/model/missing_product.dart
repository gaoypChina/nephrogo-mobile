//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'missing_product.g.dart';

/// MissingProduct
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class MissingProduct implements Built<MissingProduct, MissingProductBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  MissingProduct._();

  factory MissingProduct([void updates(MissingProductBuilder b)]) = _$MissingProduct;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MissingProductBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MissingProduct> get serializer => _$MissingProductSerializer();
}

class _$MissingProductSerializer implements PrimitiveSerializer<MissingProduct> {
  @override
  final Iterable<Type> types = const [MissingProduct, _$MissingProduct];

  @override
  final String wireName = r'MissingProduct';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MissingProduct object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MissingProduct object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MissingProductBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MissingProduct deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MissingProductBuilder();
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

