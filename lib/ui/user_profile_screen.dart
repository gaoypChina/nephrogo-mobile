import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:nephrolog/extensions/extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/preferences/app_preferences.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog_api_client/model/chronic_kidney_disease_stage_enum.dart';
import 'package:nephrolog_api_client/model/diabetes_complications_enum.dart';
import 'package:nephrolog_api_client/model/diabetes_type_enum.dart';
import 'package:nephrolog_api_client/model/dialysis_type_enum.dart';
import 'package:nephrolog_api_client/model/gender_enum.dart';
import 'package:nephrolog_api_client/model/user_profile.dart';
import 'package:nephrolog_api_client/model/user_profile_request.dart';

import 'forms/forms.dart';
import 'general/app_future_builder.dart';
import 'general/progress_indicator.dart';

enum UserProfileNextScreenType {
  close,
  homeScreen,
}

class UserProfileScreen extends StatefulWidget {
  final UserProfileNextScreenType nextScreenType;

  const UserProfileScreen({
    Key key,
    @required this.nextScreenType,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final logger = Logger("user_profile");

  static final _birthdayFormat = DateFormat.yMd();

  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();
  final _appPreferences = AppPreferences();

  AppLocalizations _appLocalizations;
  FormValidators _formValidators;

  var _userProfileMemoizer = AsyncMemoizer<UserProfile>();

  UserProfileRequestBuilder _userProfileBuilder;

  UserProfile initialUserProfile;

  DiabetesTypeEnum _diabetesType;

  get isDiabetic =>
      _diabetesType == DiabetesTypeEnum.type1 ||
      _diabetesType == DiabetesTypeEnum.type2;

  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();

    _userProfileBuilder = UserProfileRequestBuilder();

    _userProfileMemoizer.runOnce(() async {
      return await _apiService.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    _formValidators = FormValidators(context);
    _appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocalizations.userProfileScreenTitle),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton.extended(
          onPressed:
              isSubmitting ? null : () => validateAndSaveUserProfile(context),
          label: Text(_appLocalizations.save.toUpperCase()),
          icon: Icon(Icons.save),
        );
      }),
      body: AppFutureBuilder(
        future: _userProfileMemoizer.future,
        builder: (context, userProfile) {
          initialUserProfile = userProfile;

          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    _diabetesType = _diabetesType ?? initialUserProfile?.diabetesType;

    return Visibility(
      visible: !isSubmitting,
      replacement: Center(
        child: AppProgressIndicator(),
      ),
      maintainState: true,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: <Widget>[
            SmallSection(
              title:
                  _appLocalizations.userProfileSectionGeneralInformationTitle,
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppSelectFormField<GenderEnum>(
                  labelText: _appLocalizations.gender,
                  initialValue: initialUserProfile?.gender,
                  validator: _formValidators.nonNull(),
                  onSaved: (v) => _userProfileBuilder.gender = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations.male,
                      value: GenderEnum.male,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.female,
                      value: GenderEnum.female,
                    ),
                  ],
                ),
                AppDatePickerFormField(
                  labelText: _appLocalizations.birthDate,
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now().subtract(Duration(days: 365 * 18)),
                  initialDate: DateTime(1995, 6, 26),
                  selectedDate: initialUserProfile?.birthday,
                  initialDatePickerMode: DatePickerMode.year,
                  initialEntryMode: DatePickerEntryMode.input,
                  dateFormat: _birthdayFormat,
                  validator: _formValidators.nonNull(),
                  onDateSaved: (date) =>
                      _userProfileBuilder.birthday = date.toDate(),
                ),
                AppIntegerFormField(
                  labelText: _appLocalizations.height,
                  validator: _formValidators.numRangeValidator(100, 250),
                  initialValue: initialUserProfile?.heightCm,
                  suffixText: "cm",
                  onSaved: (v) => _userProfileBuilder.heightCm = v,
                ),
                AppDoubleInputField(
                  labelText: _appLocalizations.weight,
                  validator: _formValidators.numRangeValidator(25, 250),
                  helperText: _appLocalizations.userProfileWeightHelper,
                  initialValue: initialUserProfile?.weightKg?.toDouble(),
                  suffixText: "kg",
                  onSaved: (v) => _userProfileBuilder.weightKg = v,
                ),
              ],
            ),
            SmallSection(
              title:
                  _appLocalizations.userProfileSectionChronicKidneyDiseaseTitle,
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppIntegerFormField(
                  labelText: _appLocalizations
                      .userProfileSectionChronicKidneyDiseaseAge,
                  validator: _formValidators.numRangeValidator(0, 100),
                  initialValue: initialUserProfile?.chronicKidneyDiseaseYears,
                  onSaved: (v) =>
                      _userProfileBuilder.chronicKidneyDiseaseYears = v,
                ),
                AppSelectFormField<ChronicKidneyDiseaseStageEnum>(
                  labelText: _appLocalizations
                      .userProfileSectionChronicKidneyDiseaseStage,
                  helperText: _appLocalizations
                      .userProfileSectionChronicKidneyDiseaseStageHelper,
                  onSaved: (v) =>
                      _userProfileBuilder.chronicKidneyDiseaseStage = v.value,
                  initialValue: initialUserProfile?.chronicKidneyDiseaseStage,
                  validator: _formValidators.nonNull(),
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage1,
                      value: ChronicKidneyDiseaseStageEnum.stage1,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage2,
                      value: ChronicKidneyDiseaseStageEnum.stage2,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage3,
                      value: ChronicKidneyDiseaseStageEnum.stage3,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage4,
                      value: ChronicKidneyDiseaseStageEnum.stage4,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage5,
                      value: ChronicKidneyDiseaseStageEnum.stage5,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.iDontKnown,
                      value: ChronicKidneyDiseaseStageEnum.unknown,
                    ),
                  ],
                ),
                AppSelectFormField<DialysisTypeEnum>(
                  labelText: _appLocalizations.userProfileSectionDialysisType,
                  validator: _formValidators.nonNull(),
                  initialValue: initialUserProfile?.dialysisType
                      ?.enumWithoutDefault(DialysisTypeEnum.unknown),
                  onSaved: (v) => _userProfileBuilder.dialysisType = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionDialysisTypePeriotonicDialysis,
                      value: DialysisTypeEnum.periotonicDialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionDialysisTypeHemodialysis,
                      value: DialysisTypeEnum.hemodialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionDialysisTypePostTransplant,
                      description: _appLocalizations
                          .userProfileSectionDialysisTypePostTransplantDescription,
                      value: DialysisTypeEnum.postTransplant,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userProfileSectionDialysisTypeNotPerformed,
                      value: DialysisTypeEnum.notPerformed,
                    ),
                  ],
                ),
              ],
            ),
            SmallSection(
              title: _appLocalizations.userProfileSectionDiabetesTitle,
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppSelectFormField<DiabetesTypeEnum>(
                  labelText: _appLocalizations.userProfileSectionDiabetesType,
                  validator: _formValidators.nonNull(),
                  initialValue: initialUserProfile?.diabetesType
                          ?.enumWithoutDefault(DiabetesTypeEnum.unknown) ??
                      DiabetesTypeEnum.no,
                  onChanged: (dt) {
                    setState(() {
                      _diabetesType = dt.value;
                    });
                  },
                  onSaved: (v) => _userProfileBuilder.diabetesType = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations.userProfileSectionDiabetesType1,
                      value: DiabetesTypeEnum.type1,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.userProfileSectionDiabetesType2,
                      value: DiabetesTypeEnum.type2,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.userProfileSectionDiabetesTypeNo,
                      value: DiabetesTypeEnum.no,
                    ),
                  ],
                ),
                Visibility(
                  visible: isDiabetic,
                  maintainState: true,
                  child: Column(
                    children: [
                      AppIntegerFormField(
                        labelText:
                            _appLocalizations.userProfileSectionDiabetesAge,
                        initialValue: initialUserProfile?.diabetesYears,
                        validator: isDiabetic
                            ? _formValidators.numRangeValidator(0, 100)
                            : null,
                        suffixText: _appLocalizations.ageSuffix,
                        onSaved: (v) => _userProfileBuilder.diabetesYears = v,
                      ),
                      AppSelectFormField<DiabetesComplicationsEnum>(
                        labelText: _appLocalizations
                            .userProfileSectionDiabetesComplications,
                        onSaved: (v) => _userProfileBuilder
                            .diabetesComplications = v?.value,
                        initialValue: initialUserProfile?.diabetesComplications,
                        validator:
                            isDiabetic ? _formValidators.nonNull() : null,
                        items: [
                          AppSelectFormFieldItem(
                            text: _appLocalizations.yes,
                            value: DiabetesComplicationsEnum.yes,
                          ),
                          AppSelectFormFieldItem(
                            text: _appLocalizations.no,
                            value: DiabetesComplicationsEnum.no,
                          ),
                          AppSelectFormFieldItem(
                            text: _appLocalizations.iDontKnown,
                            value: DiabetesComplicationsEnum.unknown,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<UserProfile> _saveUserProfileToApi() async {
    final userProfile = _userProfileBuilder.build();

    return await _apiService.createOrUpdateUserProfile(userProfile);
  }

  Future validateAndSaveUserProfile(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return null;
    }

    setState(() {
      isSubmitting = true;
    });

    _formKey.currentState.save();

    try {
      await _saveUserProfileToApi();
    } catch (ex, st) {
      logger.warning(
        "Got error from API while submiting user conditions",
        ex,
        st,
      );
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(ex.toString())));

      return null;
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }

    await _appPreferences.setProfileCreated();

    await _navigateToAnotherScreen();
  }

  Future _navigateToAnotherScreen() async {
    switch (widget.nextScreenType) {
      case UserProfileNextScreenType.close:
        Navigator.pop(context);
        break;
      case UserProfileNextScreenType.homeScreen:
        return await Navigator.pushReplacementNamed(
          context,
          Routes.ROUTE_HOME,
        );
    }
  }
}
