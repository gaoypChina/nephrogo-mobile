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

part 'user_profile_v2.g.dart';

/// UserProfileV2
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
abstract class UserProfileV2 implements Built<UserProfileV2, UserProfileV2Builder> {
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

  UserProfileV2._();

  factory UserProfileV2([void updates(UserProfileV2Builder b)]) = _$UserProfileV2;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserProfileV2Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserProfileV2> get serializer => _$UserProfileV2Serializer();
}

class _$UserProfileV2Serializer implements PrimitiveSerializer<UserProfileV2> {
  @override
  final Iterable<Type> types = const [UserProfileV2, _$UserProfileV2];

  @override
  final String wireName = r'UserProfileV2';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserProfileV2 object, {
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
    UserProfileV2 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserProfileV2Builder result,
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
  UserProfileV2 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserProfileV2Builder();
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

