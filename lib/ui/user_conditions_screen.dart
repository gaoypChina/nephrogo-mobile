import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:nephrolog/extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
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

enum UserConditionsScreenNavigationType {
  close,
  homeScreen,
}

class UserConditionsScreen extends StatefulWidget {
  final UserConditionsScreenNavigationType navigationType;

  const UserConditionsScreen({
    Key key,
    @required this.navigationType,
  }) : super(key: key);

  @override
  _UserConditionsScreenState createState() => _UserConditionsScreenState();
}

class _UserConditionsScreenState extends State<UserConditionsScreen> {
  final logger = Logger("user_conditions_screen");

  static final _birthdayFormat = DateFormat.yMd();

  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

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
        title: Text(_appLocalizations.userConditionsScreenTitle),
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
              title: _appLocalizations
                  .userConditionsSectionGeneralInformationTitle,
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
                  helperText: _appLocalizations.userConditionsWeightHelper,
                  initialValue: initialUserProfile?.weightKg?.toDouble(),
                  suffixText: "kg",
                  onSaved: (v) => _userProfileBuilder.weightKg = v,
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
                  initialValue: initialUserProfile?.chronicKidneyDiseaseYears,
                  onSaved: (v) =>
                      _userProfileBuilder.chronicKidneyDiseaseYears = v,
                ),
                AppSelectFormField<ChronicKidneyDiseaseStageEnum>(
                  labelText: _appLocalizations
                      .userConditionsSectionChronicKidneyDiseaseStage,
                  helperText: _appLocalizations
                      .userConditionsSectionChronicKidneyDiseaseStageHelper,
                  onSaved: (v) =>
                      _userProfileBuilder.chronicKidneyDiseaseStage = v.value,
                  initialValue: initialUserProfile?.chronicKidneyDiseaseStage,
                  validator: _formValidators.nonNull(),
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage1,
                      value: ChronicKidneyDiseaseStageEnum.stage1,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage2,
                      value: ChronicKidneyDiseaseStageEnum.stage2,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage3,
                      value: ChronicKidneyDiseaseStageEnum.stage3,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage4,
                      value: ChronicKidneyDiseaseStageEnum.stage4,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionChronicKidneyDiseaseStage5,
                      value: ChronicKidneyDiseaseStageEnum.stage5,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.iDontKnown,
                      value: ChronicKidneyDiseaseStageEnum.unknown,
                    ),
                  ],
                ),
                AppSelectFormField<DialysisTypeEnum>(
                  labelText:
                      _appLocalizations.userConditionsSectionDialysisType,
                  validator: _formValidators.nonNull(),
                  initialValue: initialUserProfile?.dialysisType
                      ?.enumWithoutDefault(DialysisTypeEnum.unknown),
                  onSaved: (v) => _userProfileBuilder.dialysisType = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionDialysisTypePeriotonicDialysis,
                      value: DialysisTypeEnum.periotonicDialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionDialysisTypeHemodialysis,
                      value: DialysisTypeEnum.hemodialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionDialysisTypePostTransplant,
                      description: _appLocalizations
                          .userConditionsSectionDialysisTypePostTransplantDescription,
                      value: DialysisTypeEnum.postTransplant,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .userConditionsSectionDialysisTypeNotPerformed,
                      value: DialysisTypeEnum.notPerformed,
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
                AppSelectFormField<DiabetesTypeEnum>(
                  labelText:
                      _appLocalizations.userConditionsSectionDiabetesType,
                  validator: _formValidators.nonNull(),
                  initialValue: initialUserProfile?.diabetesType
                      ?.enumWithoutDefault(DiabetesTypeEnum.unknown),
                  onChanged: (dt) {
                    setState(() {
                      _diabetesType = dt.value;
                    });
                  },
                  onSaved: (v) => _userProfileBuilder.diabetesType = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.userConditionsSectionDiabetesType1,
                      value: DiabetesTypeEnum.type1,
                    ),
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.userConditionsSectionDiabetesType2,
                      value: DiabetesTypeEnum.type2,
                    ),
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.userConditionsSectionDiabetesTypeNo,
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
                            _appLocalizations.userConditionsSectionDiabetesAge,
                        initialValue: initialUserProfile?.diabetesYears,
                        validator: isDiabetic
                            ? _formValidators.numRangeValidator(0, 100)
                            : null,
                        suffixText: _appLocalizations.ageSuffix,
                        onSaved: (v) => _userProfileBuilder.diabetesYears = v,
                      ),
                      AppSelectFormField<DiabetesComplicationsEnum>(
                        labelText: _appLocalizations
                            .userConditionsSectionDiabetesComplications,
                        onSaved: (v) =>
                            _userProfileBuilder.diabetesComplications = v.value,
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

    if (initialUserProfile == null) {
      return await _apiService.createUserProfile(userProfile);
    }

    return await _apiService.updateUserProfile(userProfile);
  }

  Future validateAndSaveUserProfile(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return null;
    }

    setState(() {
      isSubmitting = true;
    });

    // TODO test if hidden field is called
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

    await _navigateToAnotherScreen();
  }

  Future _navigateToAnotherScreen() async {
    switch (widget.navigationType) {
      case UserConditionsScreenNavigationType.close:
        Navigator.pop(context);
        break;
      case UserConditionsScreenNavigationType.homeScreen:
        return await Navigator.pushReplacementNamed(
          context,
          Routes.ROUTE_HOME,
        );
    }
  }
}
