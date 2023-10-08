//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_app_review.g.dart';

/// UserAppReview
///
/// Properties:
/// * [showAppReviewDialog] 
@BuiltValue()
abstract class UserAppReview implements Built<UserAppReview, UserAppReviewBuilder> {
  @BuiltValueField(wireName: r'show_app_review_dialog')
  bool get showAppReviewDialog;

  UserAppReview._();

  factory UserAppReview([void updates(UserAppReviewBuilder b)]) = _$UserAppReview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserAppReviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserAppReview> get serializer => _$UserAppReviewSerializer();
}

class _$UserAppReviewSerializer implements PrimitiveSerializer<UserAppReview> {
  @override
  final Iterable<Type> types = const [UserAppReview, _$UserAppReview];

  @override
  final String wireName = r'UserAppReview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserAppReview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'show_app_review_dialog';
    yield serializers.serialize(
      object.showAppReviewDialog,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserAppReview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserAppReviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'show_app_review_dialog':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.showAppReviewDialog = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserAppReview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserAppReviewBuilder();
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

