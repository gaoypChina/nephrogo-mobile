//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_request.g.dart';

/// UserRequest
///
/// Properties:
/// * [isMarketingAllowed] 
/// * [selectedCountryCode] - ISO 3166-1 Alpha 2
@BuiltValue()
abstract class UserRequest implements Built<UserRequest, UserRequestBuilder> {
  @BuiltValueField(wireName: r'is_marketing_allowed')
  bool? get isMarketingAllowed;

  /// ISO 3166-1 Alpha 2
  @BuiltValueField(wireName: r'selected_country_code')
  String? get selectedCountryCode;

  UserRequest._();

  factory UserRequest([void updates(UserRequestBuilder b)]) = _$UserRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserRequest> get serializer => _$UserRequestSerializer();
}

class _$UserRequestSerializer implements PrimitiveSerializer<UserRequest> {
  @override
  final Iterable<Type> types = const [UserRequest, _$UserRequest];

  @override
  final String wireName = r'UserRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.isMarketingAllowed != null) {
      yield r'is_marketing_allowed';
      yield serializers.serialize(
        object.isMarketingAllowed,
        specifiedType: const FullType.nullable(bool),
      );
    }
    if (object.selectedCountryCode != null) {
      yield r'selected_country_code';
      yield serializers.serialize(
        object.selectedCountryCode,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'is_marketing_allowed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isMarketingAllowed = valueDes;
          break;
        case r'selected_country_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.selectedCountryCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserRequestBuilder();
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

