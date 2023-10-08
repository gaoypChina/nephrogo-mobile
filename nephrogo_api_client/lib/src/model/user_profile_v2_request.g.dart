// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_v2_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserProfileV2Request extends UserProfileV2Request {
  @override
  final GenderEnum gender;
  @override
  final int heightCm;
  @override
  final ChronicKidneyDiseaseStageEnum chronicKidneyDiseaseStage;
  @override
  final Date? dateOfBirth;
  @override
  final ChronicKidneyDiseaseAgeEnum? chronicKidneyDiseaseAge;
  @override
  final DialysisEnum? dialysis;
  @override
  final DiabetesTypeEnum? diabetesType;

  factory _$UserProfileV2Request(
          [void Function(UserProfileV2RequestBuilder)? updates]) =>
      (new UserProfileV2RequestBuilder()..update(updates))._build();

  _$UserProfileV2Request._(
      {required this.gender,
      required this.heightCm,
      required this.chronicKidneyDiseaseStage,
      this.dateOfBirth,
      this.chronicKidneyDiseaseAge,
      this.dialysis,
      this.diabetesType})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        gender, r'UserProfileV2Request', 'gender');
    BuiltValueNullFieldError.checkNotNull(
        heightCm, r'UserProfileV2Request', 'heightCm');
    BuiltValueNullFieldError.checkNotNull(chronicKidneyDiseaseStage,
        r'UserProfileV2Request', 'chronicKidneyDiseaseStage');
  }

  @override
  UserProfileV2Request rebuild(
          void Function(UserProfileV2RequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserProfileV2RequestBuilder toBuilder() =>
      new UserProfileV2RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfileV2Request &&
        gender == other.gender &&
        heightCm == other.heightCm &&
        chronicKidneyDiseaseStage == other.chronicKidneyDiseaseStage &&
        dateOfBirth == other.dateOfBirth &&
        chronicKidneyDiseaseAge == other.chronicKidneyDiseaseAge &&
        dialysis == other.dialysis &&
        diabetesType == other.diabetesType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, gender.hashCode);
    _$hash = $jc(_$hash, heightCm.hashCode);
    _$hash = $jc(_$hash, chronicKidneyDiseaseStage.hashCode);
    _$hash = $jc(_$hash, dateOfBirth.hashCode);
    _$hash = $jc(_$hash, chronicKidneyDiseaseAge.hashCode);
    _$hash = $jc(_$hash, dialysis.hashCode);
    _$hash = $jc(_$hash, diabetesType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserProfileV2Request')
          ..add('gender', gender)
          ..add('heightCm', heightCm)
          ..add('chronicKidneyDiseaseStage', chronicKidneyDiseaseStage)
          ..add('dateOfBirth', dateOfBirth)
          ..add('chronicKidneyDiseaseAge', chronicKidneyDiseaseAge)
          ..add('dialysis', dialysis)
          ..add('diabetesType', diabetesType))
        .toString();
  }
}

class UserProfileV2RequestBuilder
    implements Builder<UserProfileV2Request, UserProfileV2RequestBuilder> {
  _$UserProfileV2Request? _$v;

  GenderEnum? _gender;
  GenderEnum? get gender => _$this._gender;
  set gender(GenderEnum? gender) => _$this._gender = gender;

  int? _heightCm;
  int? get heightCm => _$this._heightCm;
  set heightCm(int? heightCm) => _$this._heightCm = heightCm;

  ChronicKidneyDiseaseStageEnum? _chronicKidneyDiseaseStage;
  ChronicKidneyDiseaseStageEnum? get chronicKidneyDiseaseStage =>
      _$this._chronicKidneyDiseaseStage;
  set chronicKidneyDiseaseStage(
          ChronicKidneyDiseaseStageEnum? chronicKidneyDiseaseStage) =>
      _$this._chronicKidneyDiseaseStage = chronicKidneyDiseaseStage;

  Date? _dateOfBirth;
  Date? get dateOfBirth => _$this._dateOfBirth;
  set dateOfBirth(Date? dateOfBirth) => _$this._dateOfBirth = dateOfBirth;

  ChronicKidneyDiseaseAgeEnum? _chronicKidneyDiseaseAge;
  ChronicKidneyDiseaseAgeEnum? get chronicKidneyDiseaseAge =>
      _$this._chronicKidneyDiseaseAge;
  set chronicKidneyDiseaseAge(
          ChronicKidneyDiseaseAgeEnum? chronicKidneyDiseaseAge) =>
      _$this._chronicKidneyDiseaseAge = chronicKidneyDiseaseAge;

  DialysisEnum? _dialysis;
  DialysisEnum? get dialysis => _$this._dialysis;
  set dialysis(DialysisEnum? dialysis) => _$this._dialysis = dialysis;

  DiabetesTypeEnum? _diabetesType;
  DiabetesTypeEnum? get diabetesType => _$this._diabetesType;
  set diabetesType(DiabetesTypeEnum? diabetesType) =>
      _$this._diabetesType = diabetesType;

  UserProfileV2RequestBuilder() {
    UserProfileV2Request._defaults(this);
  }

  UserProfileV2RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _gender = $v.gender;
      _heightCm = $v.heightCm;
      _chronicKidneyDiseaseStage = $v.chronicKidneyDiseaseStage;
      _dateOfBirth = $v.dateOfBirth;
      _chronicKidneyDiseaseAge = $v.chronicKidneyDiseaseAge;
      _dialysis = $v.dialysis;
      _diabetesType = $v.diabetesType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserProfileV2Request other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserProfileV2Request;
  }

  @override
  void update(void Function(UserProfileV2RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserProfileV2Request build() => _build();

  _$UserProfileV2Request _build() {
    final _$result = _$v ??
        new _$UserProfileV2Request._(
            gender: BuiltValueNullFieldError.checkNotNull(
                gender, r'UserProfileV2Request', 'gender'),
            heightCm: BuiltValueNullFieldError.checkNotNull(
                heightCm, r'UserProfileV2Request', 'heightCm'),
            chronicKidneyDiseaseStage: BuiltValueNullFieldError.checkNotNull(
                chronicKidneyDiseaseStage,
                r'UserProfileV2Request',
                'chronicKidneyDiseaseStage'),
            dateOfBirth: dateOfBirth,
            chronicKidneyDiseaseAge: chronicKidneyDiseaseAge,
            dialysis: dialysis,
            diabetesType: diabetesType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
