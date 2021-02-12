import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/authentication/authentication_provider.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/model/chronic_kidney_disease_stage_enum.dart';
import 'package:nephrogo_api_client/model/diabetes_complications_enum.dart';
import 'package:nephrogo_api_client/model/diabetes_type_enum.dart';
import 'package:nephrogo_api_client/model/dialysis_type_enum.dart';
import 'package:nephrogo_api_client/model/gender_enum.dart';
import 'package:nephrogo_api_client/model/user_profile.dart';
import 'package:nephrogo_api_client/model/user_profile_request.dart';

import 'forms/forms.dart';
import 'general/app_future_builder.dart';
import 'general/dialogs.dart';
import 'general/progress_dialog.dart';

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
  final logger = Logger('user_profile');

  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();
  final _appPreferences = AppPreferences();
  final _authenticationProvider = AuthenticationProvider();

  FormValidators _formValidators;

  final _userProfileMemoizer = AsyncMemoizer<UserProfile>();

  UserProfileRequestBuilder _userProfileBuilder;

  DiabetesTypeEnum _diabetesType;

  bool get isDiabetic =>
      _diabetesType == DiabetesTypeEnum.type1 ||
      _diabetesType == DiabetesTypeEnum.type2;

  AppLocalizations get _appLocalizations => AppLocalizations.of(context);

  @override
  void initState() {
    super.initState();

    _userProfileBuilder = UserProfileRequestBuilder();

    _userProfileMemoizer.runOnce(() async {
      return _apiService.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    _formValidators = FormValidators(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocalizations.userProfileScreenTitle),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () => validateAndSaveUserProfile(context),
            child: Text(appLocalizations.save.toUpperCase()),
          ),
        ],
      ),
      body: AppFutureBuilder<UserProfile>(
        future: _userProfileMemoizer.future,
        builder: (context, userProfile) {
          return _buildBody(userProfile);
        },
      ),
    );
  }

  Widget _buildBody(UserProfile initialUserProfile) {
    _diabetesType = _diabetesType ?? initialUserProfile?.diabetesType;

    return Form(
      key: _formKey,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BasicSection(
                header: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AppListTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.info_outline)),
                    title: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        appLocalizations.userProfileExplanation,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
              SmallSection(
                title:
                    _appLocalizations.userProfileSectionGeneralInformationTitle,
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
                  AppIntegerFormField(
                    labelText: _appLocalizations.birthYear,
                    validator: _formValidators.and(
                      _formValidators.nonNull(),
                      _formValidators.numRangeValidator(1920, 2003),
                    ),
                    initialValue: initialUserProfile?.yearOfBirth,
                    onSaved: (v) => _userProfileBuilder.yearOfBirth = v,
                    suffixText: 'm.',
                  ),
                  AppIntegerFormField(
                    labelText: _appLocalizations.height,
                    validator: _formValidators.and(
                      _formValidators.nonNull(),
                      _formValidators.numRangeValidator(100, 250),
                    ),
                    initialValue: initialUserProfile?.heightCm,
                    suffixText: 'cm',
                    onSaved: (v) => _userProfileBuilder.heightCm = v,
                  ),
                ],
              ),
              SmallSection(
                title: _appLocalizations
                    .userProfileSectionChronicKidneyDiseaseTitle,
                children: [
                  AppIntegerFormField(
                    labelText: _appLocalizations
                        .userProfileSectionChronicKidneyDiseaseAge,
                    validator: _formValidators.and(
                      _formValidators.nonNull(),
                      _formValidators.numRangeValidator(0, 100),
                    ),
                    initialValue: initialUserProfile?.chronicKidneyDiseaseYears,
                    suffixText: 'm.',
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
                        text:
                            _appLocalizations.userProfileSectionDiabetesTypeNo,
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
                          validator: _formValidators.or(
                            _formValidators.and(
                              _formValidators.nonNull(),
                              _formValidators.numRangeValidator(0, 100),
                            ),
                            (_) => !isDiabetic ? null : '',
                          ),
                          suffixText: _appLocalizations.ageSuffix,
                          onSaved: (v) => _userProfileBuilder.diabetesYears = v,
                        ),
                        AppSelectFormField<DiabetesComplicationsEnum>(
                          labelText: _appLocalizations
                              .userProfileSectionDiabetesComplications,
                          onSaved: (v) => _userProfileBuilder
                              .diabetesComplications = v?.value,
                          initialValue:
                              initialUserProfile?.diabetesComplications ??
                                  DiabetesComplicationsEnum.unknown,
                          validator: _formValidators.or(
                            _formValidators.nonNull(),
                            (_) => !isDiabetic ? null : '',
                          ),
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
      ),
    );
  }

  Future<UserProfile> _saveUserProfileToApi() async {
    final userProfile = _userProfileBuilder.build();

    return _apiService.createOrUpdateUserProfile(userProfile);
  }

  Future validateAndSaveUserProfile(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState.validate()) {
      await showAppDialog(
        context: context,
        title: _appLocalizations.error,
        message: _appLocalizations.formErrorDescription,
      );

      return false;
    }
    _formKey.currentState.save();

    final profile = await ProgressDialog(context)
        .showForFuture(_saveUserProfileToApi())
        .catchError(
      (e, stackTrace) async {
        await showAppDialog(
          context: context,
          title: _appLocalizations.error,
          message: _appLocalizations.serverErrorDescription,
        );
      },
    );

    if (profile != null) {
      await _appPreferences.setProfileCreated();

      await _navigateToAnotherScreen();
    }
  }

  Future _navigateToAnotherScreen() async {
    switch (widget.nextScreenType) {
      case UserProfileNextScreenType.close:
        Navigator.pop(context);
        break;
      case UserProfileNextScreenType.homeScreen:
        return Navigator.pushReplacementNamed(
          context,
          Routes.routeHome,
        );
    }
  }
}
