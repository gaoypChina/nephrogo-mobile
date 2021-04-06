import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

import '../forms/forms.dart';
import '../general/app_form.dart';
import '../general/app_future_builder.dart';
import 'user_profile_steps.dart';

enum UserProfileNextScreenType {
  close,
  homeScreen,
}

class UserProfileScreen extends StatefulWidget {
  final UserProfileNextScreenType nextScreenType;

  const UserProfileScreen({Key? key, required this.nextScreenType})
      : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _apiService = ApiService();

  final _userProfileMemoizer =
      AsyncMemoizer<NullableApiResponse<UserProfile>>();

  @override
  void initState() {
    super.initState();

    _userProfileMemoizer.runOnce(() {
      return _apiService.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<NullableApiResponse<UserProfile>>(
      future: _userProfileMemoizer.future,
      builder: (context, data) {
        return _UserProfileScreenBody(userProfile: data.data);
      },
      loading: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.userProfileScreenTitle),
          centerTitle: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _UserProfileScreenBody extends StatefulWidget {
  final UserProfile? userProfile;

  const _UserProfileScreenBody({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  @override
  _UserProfileScreenBodyState createState() => _UserProfileScreenBodyState();
}

class _UserProfileScreenBodyState extends State<_UserProfileScreenBody> {
  final _controller = PageController(viewportFraction: 0.9999999);

  late UserProfileRequestBuilder _userProfileBuilder;

  int page = 0;

  final List<UserProfileStep> _steps = [
    GenderStep(),
    HeightStep(),
    ChronicKidneyDiseaseStageStep(),
    DialysisStep(),
    PeritonealDialysisTypeStep(),
    DiabetesStep(),
  ];

  List<UserProfileStep> get _enabledSteps {
    return _steps.where((s) => s.isEnabled(_userProfileBuilder)).toList();
  }

  int get _totalSteps => _enabledSteps.length;

  bool get isDone => page + 1 == _totalSteps;

  @override
  void initState() {
    super.initState();

    _userProfileBuilder =
        widget.userProfile?.toRequestBuilder() ?? UserProfileRequestBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: close,
      child: Scaffold(
        appBar: AppBar(
          leading: CloseButton(onPressed: close),
          title: _getTitle(),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _totalSteps,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _enabledSteps[index].build(
                    context,
                    _userProfileBuilder,
                    setState,
                  );
                },
                onPageChanged: (int p) {
                  setState(() {
                    page = p;
                  });
                },
              ),
            ),
            BasicSection.single(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: _steps[page].validate(_userProfileBuilder)
                        ? () => advancePageOrFinish(isDone: isDone)
                        : null,
                    label: isDone
                        ? Text(appLocalizations.finish.toUpperCase())
                        : Text(appLocalizations.further.toUpperCase()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTitle() {
    if (page == 0) {
      return Text(appLocalizations.userProfileScreenTitle);
    } else {
      return Text('${page + 1} / $_totalSteps');
    }
  }

  Future advancePageOrFinish({required bool isDone}) async {
    if (page + 1 == _totalSteps || isDone) {
    } else {
      await _controller.animateToPage(
        page + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Future<bool> close() {
    return advancePageOrFinish(isDone: true).then((value) => true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}

class UserProfileScreenLegacy extends StatefulWidget {
  final UserProfileNextScreenType nextScreenType;

  const UserProfileScreenLegacy({
    Key? key,
    required this.nextScreenType,
  }) : super(key: key);

  @override
  _UserProfileScreenStateLegacy createState() =>
      _UserProfileScreenStateLegacy();
}

class _UserProfileScreenStateLegacy extends State<UserProfileScreenLegacy> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();
  final _appPreferences = AppPreferences();

  FormValidators get _formValidators => FormValidators(context);

  final _userProfileMemoizer =
      AsyncMemoizer<NullableApiResponse<UserProfile>>();

  late UserProfileRequestBuilder _userProfileBuilder;

  bool _isInitial = true;

  bool get _isDiabetic =>
      _userProfileBuilder.diabetesType == DiabetesTypeEnum.type1 ||
      _userProfileBuilder.diabetesType == DiabetesTypeEnum.type2;

  bool get _isPeritonealDialysis =>
      _userProfileBuilder.dialysisType == DialysisTypeEnum.periotonicDialysis;

  @override
  void initState() {
    super.initState();

    _userProfileMemoizer.runOnce(() async {
      return _apiService.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.userProfileScreenTitle),
        actions: [
          AppBarTextButton(
            onPressed: () => validateAndSaveUserProfile(context),
            child: Text(appLocalizations.save.toUpperCase()),
          ),
        ],
      ),
      body: AppFutureBuilder<NullableApiResponse<UserProfile>>(
        future: _userProfileMemoizer.future,
        builder: (context, data) {
          final userProfile = data.data;
          _isInitial = userProfile == null;

          _userProfileBuilder =
              userProfile?.toRequestBuilder() ?? UserProfileRequestBuilder();

          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return AppForm(
      formKey: _formKey,
      save: () => validateAndSaveUserProfile(context),
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            BasicSection(
              header: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: AppListTile(
                  leading: const CircleAvatar(child: Icon(Icons.info_outline)),
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
              title: appLocalizations.userProfileSectionGeneralInformationTitle,
              children: [
                AppSelectFormField<GenderEnum>(
                  focusNextOnSelection: _isInitial,
                  labelText: appLocalizations.gender,
                  initialValue: _userProfileBuilder.gender,
                  validator: _formValidators.nonNull(),
                  onSaved: (v) => _userProfileBuilder.gender = v?.value,
                  onChanged: (v) => _userProfileBuilder.gender = v?.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: appLocalizations.male,
                      value: GenderEnum.male,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations.female,
                      value: GenderEnum.female,
                    ),
                  ],
                ),
                AppIntegerFormField(
                  labelText: appLocalizations.birthYear,
                  validator: _formValidators.and(
                    _formValidators.nonNull(),
                    _formValidators.numRangeValidator(1920, 2003),
                  ),
                  initialValue: _userProfileBuilder.yearOfBirth,
                  textInputAction: _isInitial ? TextInputAction.next : null,
                  onSaved: (v) => _userProfileBuilder.yearOfBirth = v,
                  onChanged: (v) => _userProfileBuilder.yearOfBirth = v,
                  suffixText: 'm.',
                ),
                AppIntegerFormField(
                  labelText: appLocalizations.height,
                  validator: _formValidators.and(
                    _formValidators.nonNull(),
                    _formValidators.numRangeValidator(100, 250),
                  ),
                  initialValue: _userProfileBuilder.heightCm,
                  textInputAction: _isInitial ? TextInputAction.next : null,
                  suffixText: 'cm',
                  onSaved: (v) => _userProfileBuilder.heightCm = v,
                  onChanged: (v) => _userProfileBuilder.heightCm = v,
                ),
              ],
            ),
            SmallSection(
              title:
                  appLocalizations.userProfileSectionChronicKidneyDiseaseTitle,
              children: [
                AppIntegerFormField(
                  labelText: appLocalizations
                      .userProfileSectionChronicKidneyDiseaseAge,
                  textInputAction: _isInitial ? TextInputAction.next : null,
                  validator: _formValidators.and(
                    _formValidators.nonNull(),
                    _formValidators.numRangeValidator(0, 100),
                  ),
                  initialValue: _userProfileBuilder.chronicKidneyDiseaseYears,
                  suffixText: 'm.',
                  onSaved: (v) {
                    _userProfileBuilder.chronicKidneyDiseaseYears = v;
                  },
                  onChanged: (v) {
                    _userProfileBuilder.chronicKidneyDiseaseYears = v;
                  },
                ),
                AppSelectFormField<ChronicKidneyDiseaseStageEnum>(
                  labelText: appLocalizations
                      .userProfileSectionChronicKidneyDiseaseStage,
                  helperText: appLocalizations
                      .userProfileSectionChronicKidneyDiseaseStageHelper,
                  onSaved: (v) {
                    _userProfileBuilder.chronicKidneyDiseaseStage =
                        v?.value ?? ChronicKidneyDiseaseStageEnum.unknown;
                  },
                  onChanged: (v) {
                    _userProfileBuilder.chronicKidneyDiseaseStage =
                        v?.value ?? ChronicKidneyDiseaseStageEnum.unknown;
                  },
                  initialValue: _userProfileBuilder.chronicKidneyDiseaseStage
                      ?.enumWithoutDefault(
                    ChronicKidneyDiseaseStageEnum.unknown,
                  ),
                  focusNextOnSelection: _isInitial,
                  validator: _formValidators.nonNull(),
                  items: [
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage1,
                      value: ChronicKidneyDiseaseStageEnum.stage1,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage2,
                      value: ChronicKidneyDiseaseStageEnum.stage2,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage3,
                      value: ChronicKidneyDiseaseStageEnum.stage3,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage4,
                      value: ChronicKidneyDiseaseStageEnum.stage4,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionChronicKidneyDiseaseStage5,
                      value: ChronicKidneyDiseaseStageEnum.stage5,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations.iDontKnown,
                      value: ChronicKidneyDiseaseStageEnum.unknown,
                    ),
                  ],
                ),
                AppSelectFormField<DialysisTypeEnum>(
                  labelText: appLocalizations.userProfileSectionDialysisType,
                  validator: _formValidators.nonNull(),
                  initialValue: _userProfileBuilder.dialysisType
                      ?.enumWithoutDefault(DialysisTypeEnum.unknown),
                  focusNextOnSelection: _isInitial,
                  onSaved: (v) => _userProfileBuilder.dialysisType =
                      v?.value ?? DialysisTypeEnum.unknown,
                  onChanged: (v) {
                    setState(() {
                      _userProfileBuilder.dialysisType =
                          v?.value ?? DialysisTypeEnum.unknown;
                    });
                  },
                  items: [
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionDialysisTypePeriotonicDialysis,
                      value: DialysisTypeEnum.periotonicDialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionDialysisTypeHemodialysis,
                      value: DialysisTypeEnum.hemodialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionDialysisTypePostTransplant,
                      description: appLocalizations
                          .userProfileSectionDialysisTypePostTransplantDescription,
                      value: DialysisTypeEnum.postTransplant,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations
                          .userProfileSectionDialysisTypeNotPerformed,
                      value: DialysisTypeEnum.notPerformed,
                    ),
                  ],
                ),
                if (_isPeritonealDialysis)
                  AppSelectFormField<PeriotonicDialysisTypeEnum>(
                    labelText: appLocalizations.peritonealDialysisType,
                    validator: _formValidators.nonNull(),
                    initialValue: _userProfileBuilder.periotonicDialysisType
                        ?.enumWithoutDefault(
                      PeriotonicDialysisTypeEnum.unknown,
                    ),
                    focusNextOnSelection: _isInitial,
                    onSaved: (v) => _userProfileBuilder.periotonicDialysisType =
                        v?.value ?? PeriotonicDialysisTypeEnum.unknown,
                    onChanged: (v) {
                      setState(() {
                        _userProfileBuilder.periotonicDialysisType =
                            v?.value ?? PeriotonicDialysisTypeEnum.unknown;
                      });
                    },
                    items: [
                      AppSelectFormFieldItem(
                        text: appLocalizations.peritonealDialysisTypeAutomatic,
                        value: PeriotonicDialysisTypeEnum.automatic,
                      ),
                      AppSelectFormFieldItem(
                        text: appLocalizations.peritonealDialysisTypeManual,
                        value: PeriotonicDialysisTypeEnum.manual,
                      ),
                    ],
                  ),
              ],
            ),
            SmallSection(
              title: appLocalizations.userProfileSectionDiabetesTitle,
              children: [
                AppSelectFormField<DiabetesTypeEnum>(
                  labelText: appLocalizations.userProfileSectionDiabetesType,
                  validator: _formValidators.nonNull(),
                  initialValue: _userProfileBuilder.diabetesType
                          ?.enumWithoutDefault(DiabetesTypeEnum.unknown) ??
                      DiabetesTypeEnum.no,
                  onChanged: (dt) {
                    setState(() {
                      _userProfileBuilder.diabetesType =
                          dt?.value ?? DiabetesTypeEnum.no;
                    });

                    if (_isDiabetic) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  onSaved: (v) => _userProfileBuilder.diabetesType =
                      v?.value ?? DiabetesTypeEnum.no,
                  items: [
                    AppSelectFormFieldItem(
                      text: appLocalizations.userProfileSectionDiabetesType1,
                      value: DiabetesTypeEnum.type1,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations.userProfileSectionDiabetesType2,
                      value: DiabetesTypeEnum.type2,
                    ),
                    AppSelectFormFieldItem(
                      text: appLocalizations.userProfileSectionDiabetesTypeNo,
                      value: DiabetesTypeEnum.no,
                    ),
                  ],
                ),
                if (_isDiabetic)
                  Column(
                    children: [
                      AppIntegerFormField(
                        labelText:
                            appLocalizations.userProfileSectionDiabetesAge,
                        initialValue: _userProfileBuilder.diabetesYears,
                        textInputAction:
                            _isInitial ? TextInputAction.next : null,
                        validator: _formValidators.and(
                          _formValidators.nonNull(),
                          _formValidators.numRangeValidator(0, 100),
                        ),
                        suffixText: appLocalizations.ageSuffix,
                        onSaved: (v) => _userProfileBuilder.diabetesYears = v,
                        onChanged: (v) => _userProfileBuilder.diabetesYears = v,
                      ),
                      AppSelectFormField<DiabetesComplicationsEnum>(
                        labelText: appLocalizations
                            .userProfileSectionDiabetesComplications,
                        onSaved: (v) => _userProfileBuilder
                            .diabetesComplications = v?.value,
                        onChanged: (v) => _userProfileBuilder
                            .diabetesComplications = v?.value,
                        initialValue:
                            _userProfileBuilder.diabetesComplications ??
                                DiabetesComplicationsEnum.unknown,
                        validator: _formValidators.nonNull(),
                        items: [
                          AppSelectFormFieldItem(
                            text: appLocalizations.yes,
                            value: DiabetesComplicationsEnum.yes,
                          ),
                          AppSelectFormFieldItem(
                            text: appLocalizations.no,
                            value: DiabetesComplicationsEnum.no,
                          ),
                          AppSelectFormFieldItem(
                            text: appLocalizations.iDontKnown,
                            value: DiabetesComplicationsEnum.unknown,
                          ),
                        ],
                      ),
                    ],
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

    return _apiService.createOrUpdateUserProfile(userProfile);
  }

  Future<bool> validateAndSaveUserProfile(BuildContext context) {
    if (!_isDiabetic) {
      _userProfileBuilder.diabetesYears = 0;
      _userProfileBuilder.diabetesComplications =
          DiabetesComplicationsEnum.unknown;
    }

    if (!_isPeritonealDialysis) {
      _userProfileBuilder.periotonicDialysisType =
          PeriotonicDialysisTypeEnum.unknown;
    }

    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: () => _saveUserProfileToApi(),
      onSuccess: _onSavedSuccess,
    );
  }

  Future<void> _onSavedSuccess() async {
    await _appPreferences.setProfileCreated();

    await _appPreferences.setPeritonealDialysisType(
      _userProfileBuilder.periotonicDialysisType ??
          PeriotonicDialysisTypeEnum.unknown,
    );

    await _navigateToAnotherScreen();
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
