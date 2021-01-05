import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog_api_client/model/chronic_kidney_disease.dart';
import 'package:nephrolog_api_client/model/chronic_kidney_disease_stage.dart';
import 'package:nephrolog_api_client/model/diabetes.dart';
import 'package:nephrolog_api_client/model/diabetes_type.dart';
import 'package:nephrolog_api_client/model/dialysis_type.dart';
import 'package:nephrolog_api_client/model/gender.dart';
import 'package:nephrolog_api_client/model/user_profile.dart';

import 'forms/forms.dart';
import 'general/app_future_builder.dart';
import 'general/progress_indicator.dart';

class UserConditionsScreen extends StatefulWidget {
  @override
  _UserConditionsScreenState createState() => _UserConditionsScreenState();
}

class _UserConditionsScreenState extends State<UserConditionsScreen> {
  static final _birthdayFormat = DateFormat.yMd();

  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  AppLocalizations _appLocalizations;
  FormValidators _formValidators;

  var _userProfileMemoizer = AsyncMemoizer<UserProfile>();

  UserProfileBuilder _userProfileBuilder;
  ChronicKidneyDiseaseBuilder _chronicKidneyDiseaseBuilder;
  DiabetesBuilder _diabetesBuilder;

  bool isDiabetic = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _userProfileBuilder = UserProfileBuilder();
    _chronicKidneyDiseaseBuilder = _userProfileBuilder.chronicKidneyDisease;
    _diabetesBuilder = _userProfileBuilder.diabetes;

    _userProfileMemoizer.runOnce(() async {
      return await _apiService.userProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    _formValidators = FormValidators(context);
    _appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocalizations.userConditionsScreenTitle),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton.extended(
          onPressed: () => validateAndSaveUserProfile(context),
          label: Text(_appLocalizations.save.toUpperCase()),
          icon: Icon(Icons.save),
        );
      }),
      body: AppFutureBuilder(
        future: _userProfileMemoizer.future,
        builder: (context, userProfile) {
          return _buildBody(userProfile);
        },
      ),
    );
  }

  Widget _buildBody(UserProfile initialUserProfile) {
    return Visibility(
      visible: !isLoading,
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
              title: _appLocalizations
                  .userConditionsSectionGeneralInformationTitle,
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppSelectFormField<Gender>(
                  labelText: _appLocalizations.gender,
                  initialValue: initialUserProfile?.gender,
                  validator: _formValidators.nonNull(),
                  onSaved: (v) => _userProfileBuilder.gender = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations.male,
                      value: Gender.male,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.female,
                      value: Gender.female,
                    ),
                  ],
                ),
                AppDatePickerFormField(
                  labelText: _appLocalizations.birthDate,
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now().subtract(Duration(days: 365 * 18)),
                  initialDate: DateTime(1995, 6, 26),
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
                  suffixText: "cm",
                  onSaved: (v) => _userProfileBuilder.heightCm = v,
                ),
                AppDoubleInputField(
                  labelText: _appLocalizations.weight,
                  validator: _formValidators.numRangeValidator(25, 250),
                  helperText: _appLocalizations.userConditionsWeightHelper,
                  suffixText: "kg",
                  onSaved: (v) => _userProfileBuilder.weightKg = v.toInt(),
                ),
              ],
            ),
            SmallSection(
              title: _appLocalizations
                  .userConditionsSectionChronicKidneyDiseaseTitle,
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppIntegerFormField(
                  labelText: _appLocalizations
                      .userConditionsSectionChronicKidneyDiseaseAge,
                  validator: _formValidators.numRangeValidator(0, 100),
                  onSaved: (v) => _chronicKidneyDiseaseBuilder.age = v,
                ),
                AppSelectFormField<ChronicKidneyDiseaseStage>(
                  labelText: _appLocalizations
                      .userConditionsSectionChronicKidneyDiseaseStage,
                  helperText: _appLocalizations
                      .userConditionsSectionChronicKidneyDiseaseStageHelper,
                  onSaved: (v) => _chronicKidneyDiseaseBuilder.stage = v.value,
                  initialValue: initialUserProfile?.chronicKidneyDisease?.stage,
                  validator: _formValidators.nonNull(),
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage1,
                      value: ChronicKidneyDiseaseStage.stage1,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage2,
                      value: ChronicKidneyDiseaseStage.stage2,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage3,
                      value: ChronicKidneyDiseaseStage.stage3,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage4,
                      value: ChronicKidneyDiseaseStage.stage4,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage5,
                      value: ChronicKidneyDiseaseStage.stage5,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.iDontKnown,
                      value: ChronicKidneyDiseaseStage.unknown,
                    ),
                  ],
                ),
                AppSelectFormField<DialysisType>(
                  labelText:
                      _appLocalizations.userConditionsSectionDialysisType,
                  validator: _formValidators.nonNull(),
                  initialValue:
                      initialUserProfile?.chronicKidneyDisease?.dialysisType,
                  onSaved: (v) =>
                      _chronicKidneyDiseaseBuilder.dialysisType = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionDialysisTypePeriotonicDialysis,
                      value: DialysisType.periotonicDialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionDialysisTypeHemodialysis,
                      value: DialysisType.hemodialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionDialysisTypePostTransplant,
                      description: _appLocalizations
                          .userConditionsSectionDialysisTypePostTransplantDescription,
                      value: DialysisType.postTransplant,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionDialysisTypeNotPerformed,
                      value: DialysisType.notPerformed,
                    ),
                  ],
                ),
              ],
            ),
            SmallSection(
              title: _appLocalizations.userConditionsSectionDiabetesTitle,
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppSelectFormField<DiabetesType>(
                  labelText:
                      _appLocalizations.userConditionsSectionDiabetesType,
                  validator: _formValidators.nonNull(),
                  initialValue: initialUserProfile?.diabetes?.type,
                  onChanged: (item) {
                    setState(() {
                      isDiabetic = item.value != DiabetesType.unknown;
                    });
                  },
                  onSaved: (v) => _diabetesBuilder.type = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.userConditionsSectionDiabetesType1,
                      value: DiabetesType.type1,
                    ),
                    AppSelectFormFieldItem(
                      text:
                      _appLocalizations.userConditionsSectionDiabetesType2,
                      value: DiabetesType.type1,
                    ),
                    AppSelectFormFieldItem(
                      text:
                      _appLocalizations.userConditionsSectionDiabetesTypeNo,
                      value: DiabetesType.unknown,
                    ),
                  ],
                ),
                Visibility(
                  visible: isDiabetic,
                  child: Column(
                    children: [
                      AppIntegerFormField(
                        labelText:
                        _appLocalizations.userConditionsSectionDiabetesAge,
                        validator: isDiabetic
                            ? _formValidators.numRangeValidator(0, 100)
                            : null,
                        suffixText: _appLocalizations.ageSuffix,
                        onSaved: (v) => print(v),
                      ),
                      AppSelectFormField<String>(
                        labelText: _appLocalizations
                            .userConditionsSectionDiabetesComplications,
                        onChanged: (value) {},
                        validator:
                            isDiabetic ? _formValidators.nonNull() : null,
                        items: [
                          AppSelectFormFieldItem(
                            text: _appLocalizations.yes,
                            value: "1",
                          ),
                          AppSelectFormFieldItem(
                            text: _appLocalizations.no,
                            value: "2",
                          ),
                          AppSelectFormFieldItem(
                            text: _appLocalizations.iDontKnown,
                            value: "3",
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

  Future<UserProfile> _saveUserProfile() async {
    _formKey.currentState.save();

    final userProfile = _userProfileBuilder.build();

    return await _apiService.setUserProfile(userProfile);
  }

  Future validateAndSaveUserProfile(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return null;
    }

    UserProfile userProfile;

    try {
      setState(() {
        isLoading = true;
      });

      userProfile = await _saveUserProfile();
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(ex.toString())));

      return null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    Navigator.pop(context, userProfile);
  }
}
