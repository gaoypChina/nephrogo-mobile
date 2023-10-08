//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nephrogo_api_client/src/model/chronic_kidney_disease_age_enum.dart';
import 'package:nephrogo_api_client/src/model/gender_enum.dart';
import 'package:nephrogo_api_client/src/model/date.dart';
import 'package:nephrogo_api_client/src/model/diabetes_type_enum.dart';
import 'package:nephrogo_api_client/src/model/chronic_kidney_disease_stage_enum.dart';
import 'package:nephrogo_api_client/src/model/dialysis_enum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_profile_v2_request.g.dart';

/// UserProfileV2Request
///
/// Properties:
/// * [gender] 
/// * [heightCm] 
/// * [chronicKidneyDiseaseStage] 
/// * [dateOfBirth] 
/// * [chronicKidneyDiseaseAge] 
/// * [dialysis] 
/// * [diabetesType] 
@BuiltValue()
abstract class UserProfileV2Request implements Built<UserProfileV2Request, UserProfileV2RequestBuilder> {
  @BuiltValueField(wireName: r'gender')
  GenderEnum get gender;
  // enum genderEnum {  Male,  Female,  };

  @BuiltValueField(wireName: r'height_cm')
  int get heightCm;

  @BuiltValueField(wireName: r'chronic_kidney_disease_stage')
  ChronicKidneyDiseaseStageEnum get chronicKidneyDiseaseStage;
  // enum chronicKidneyDiseaseStageEnum {  Unknown,  Stage1,  Stage2,  Stage3,  Stage4,  Stage5,  };

  @BuiltValueField(wireName: r'date_of_birth')
  Date? get dateOfBirth;

  @BuiltValueField(wireName: r'chronic_kidney_disease_age')
  ChronicKidneyDiseaseAgeEnum? get chronicKidneyDiseaseAge;
  // enum chronicKidneyDiseaseAgeEnum {  Unknown,  <1,  1-5,  6-10,  >10,  };

  @BuiltValueField(wireName: r'dialysis')
  DialysisEnum? get dialysis;
  // enum dialysisEnum {  Unknown,  AutomaticPeritonealDialysis,  ManualPeritonealDialysis,  Hemodialysis,  PostTransplant,  NotPerformed,  };

  @BuiltValueField(wireName: r'diabetes_type')
  DiabetesTypeEnum? get diabetesType;
  // enum diabetesTypeEnum {  Unknown,  Type1,  Type2,  No,  };

  UserProfileV2Request._();

  factory UserProfileV2Request([void updates(UserProfileV2RequestBuilder b)]) = _$UserProfileV2Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserProfileV2RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserProfileV2Request> get serializer => _$UserProfileV2RequestSerializer();
}

class _$UserProfileV2RequestSerializer implements PrimitiveSerializer<UserProfileV2Request> {
  @override
  final Iterable<Type> types = const [UserProfileV2Request, _$UserProfileV2Request];

  @override
  final String wireName = r'UserProfileV2Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserProfileV2Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'gender';
    yield serializers.serialize(
      object.gender,
      specifiedType: const FullType(GenderEnum),
    );
    yield r'height_cm';
    yield serializers.serialize(
      object.heightCm,
      specifiedType: const FullType(int),
    );
    yield r'chronic_kidney_disease_stage';
    yield serializers.serialize(
      object.chronicKidneyDiseaseStage,
      specifiedType: const FullType(ChronicKidneyDiseaseStageEnum),
    );
    if (object.dateOfBirth != null) {
      yield r'date_of_birth';
      yield serializers.serialize(
        object.dateOfBirth,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.chronicKidneyDiseaseAge != null) {
      yield r'chronic_kidney_disease_age';
      yield serializers.serialize(
        object.chronicKidneyDiseaseAge,
        specifiedType: const FullType(ChronicKidneyDiseaseAgeEnum),
      );
    }
    if (object.dialysis != null) {
      yield r'dialysis';
      yield serializers.serialize(
        object.dialysis,
        specifiedType: const FullType(DialysisEnum),
      );
    }
    if (object.diabetesType != null) {
      yield r'diabetes_type';
      yield serializers.serialize(
        object.diabetesType,
        specifiedType: const FullType(DiabetesTypeEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserProfileV2Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserProfileV2RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'gender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GenderEnum),
          ) as GenderEnum;
          result.gender = valueDes;
          break;
        case r'height_cm':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.heightCm = valueDes;
          break;
        case r'chronic_kidney_disease_stage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChronicKidneyDiseaseStageEnum),
          ) as ChronicKidneyDiseaseStageEnum;
          result.chronicKidneyDiseaseStage = valueDes;
          break;
        case r'date_of_birth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.dateOfBirth = valueDes;
          break;
        case r'chronic_kidney_disease_age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChronicKidneyDiseaseAgeEnum),
          ) as ChronicKidneyDiseaseAgeEnum;
          result.chronicKidneyDiseaseAge = valueDes;
          break;
        case r'dialysis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DialysisEnum),
          ) as DialysisEnum;
          result.dialysis = valueDes;
          break;
        case r'diabetes_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DiabetesTypeEnum),
          ) as DiabetesTypeEnum;
          result.diabetesType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserProfileV2Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserProfileV2RequestBuilder();
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

