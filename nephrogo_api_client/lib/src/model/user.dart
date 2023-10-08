//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/nutrition_summary_statistics.dart';
import 'package:nephrogo_api_client/src/model/country.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

/// User
///
/// Properties:
/// * [nutritionSummary] 
/// * [selectedCountry] 
/// * [isMarketingAllowed] 
@BuiltValue()
abstract class User implements Built<User, UserBuilder> {
  @BuiltValueField(wireName: r'nutrition_summary')
  NutritionSummaryStatistics get nutritionSummary;

  @BuiltValueField(wireName: r'selected_country')
  Country? get selectedCountry;

  @BuiltValueField(wireName: r'is_marketing_allowed')
  bool? get isMarketingAllowed;

  User._();

  factory User([void updates(UserBuilder b)]) = _$User;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<User> get serializer => _$UserSerializer();
}

class _$UserSerializer implements PrimitiveSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];

  @override
  final String wireName = r'User';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    User object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'nutrition_summary';
    yield serializers.serialize(
      object.nutritionSummary,
      specifiedType: const FullType(NutritionSummaryStatistics),
    );
    yield r'selected_country';
    yield object.selectedCountry == null ? null : serializers.serialize(
      object.selectedCountry,
      specifiedType: const FullType.nullable(Country),
    );
    if (object.isMarketingAllowed != null) {
      yield r'is_marketing_allowed';
      yield serializers.serialize(
        object.isMarketingAllowed,
        specifiedType: const FullType.nullable(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    User object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nutrition_summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NutritionSummaryStatistics),
          ) as NutritionSummaryStatistics;
          result.nutritionSummary.replace(valueDes);
          break;
        case r'selected_country':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Country),
          ) as Country?;
          if (valueDes == null) continue;
          result.selectedCountry.replace(valueDes);
          break;
        case r'is_marketing_allowed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isMarketingAllowed = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  User deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserBuilder();
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

