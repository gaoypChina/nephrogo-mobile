import 'package:async/async.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo_api_client/model/appetite_enum.dart';
import 'package:nephrogo_api_client/model/daily_health_status.dart';
import 'package:nephrogo_api_client/model/daily_health_status_request.dart';
import 'package:nephrogo_api_client/model/shortness_of_breath_enum.dart';
import 'package:nephrogo_api_client/model/swelling_difficulty_enum.dart';
import 'package:nephrogo_api_client/model/swelling_enum.dart';
import 'package:nephrogo_api_client/model/swelling_request.dart';
import 'package:nephrogo_api_client/model/well_feeling_enum.dart';

class HealthStatusCreationScreen extends StatefulWidget {
  @override
  _HealthStatusCreationScreenState createState() =>
      _HealthStatusCreationScreenState();
}

class _HealthStatusCreationScreenState
    extends State<HealthStatusCreationScreen> {
  final logger = Logger('HealthStatusCreationScreen');

  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();
  DailyHealthStatusRequestBuilder _healthStatusBuilder;
  AppLocalizations _appLocalizations;

  final _healthStatusMemoizer = AsyncMemoizer<DailyHealthStatus>();
  DailyHealthStatus _initialHealthStatus;

  @override
  void initState() {
    super.initState();

    _healthStatusBuilder = DailyHealthStatusRequestBuilder();
    _healthStatusBuilder.date = Date(DateTime.now());

    _healthStatusMemoizer.runOnce(
      () => _apiService.getDailyHealthStatus(_healthStatusBuilder.date),
    );
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocalizations.healthStatusCreationTodayTitle),
      ),
      bottomNavigationBar: BasicSection.single(
        SizedBox(
          width: double.infinity,
          child: AppElevatedButton(
            onPressed: () => validateAndSave(context),
            text: appLocalizations.save.toUpperCase(),
          ),
        ),
        padding: EdgeInsets.zero,
        innerPadding: const EdgeInsets.all(8),
      ),
      body: AppFutureBuilder<DailyHealthStatus>(
        future: _healthStatusMemoizer.future,
        builder: (context, healthStatus) {
          _initialHealthStatus = healthStatus;

          return _buildBody(context);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final formValidators = FormValidators(context);

    return Form(
      key: _formKey,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SmallSection(
                title: _appLocalizations.healthStatusCreationBloodPressure,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: AppIntegerFormField(
                          labelText:
                              _appLocalizations.healthStatusCreationSystolic,
                          suffixText: 'mmHg',
                          validator: formValidators.numRangeValidator(0, 350),
                          initialValue:
                              _initialHealthStatus?.systolicBloodPressure,
                          onSaved: (value) {
                            _healthStatusBuilder.systolicBloodPressure = value;
                          },
                        ),
                      ),
                      Flexible(
                        child: AppIntegerFormField(
                          labelText:
                              _appLocalizations.healthStatusCreationDiastolic,
                          suffixText: 'mmHg',
                          validator: formValidators.numRangeValidator(0, 200),
                          initialValue:
                              _initialHealthStatus?.diastolicBloodPressure,
                          onSaved: (value) {
                            _healthStatusBuilder.diastolicBloodPressure = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(_appLocalizations
                        .healthStatusCreationBloodPressureHelper),
                  ),
                ],
              ),
              SmallSection(
                title: _appLocalizations.healthStatusCreationSectionGeneralInfo,
                children: [
                  AppDoubleInputField(
                    labelText: _appLocalizations.weight,
                    fractionDigits: 1,
                    suffixText: 'kg',
                    helperText: _appLocalizations.userProfileWeightHelper,
                    initialValue: _initialHealthStatus?.weightKg,
                    validator: formValidators.numRangeValidator(30.0, 300.0),
                    onSaved: (value) {
                      _healthStatusBuilder.weightKg = value;
                    },
                  ),
                  AppIntegerFormField(
                    labelText: _appLocalizations.healthStatusCreationUrine,
                    suffixText: 'ml',
                    initialValue: _initialHealthStatus?.urineMl,
                    validator: formValidators.numRangeValidator(0, 10000),
                    onSaved: (value) {
                      _healthStatusBuilder.urineMl = value;
                    },
                  ),
                  AppDoubleInputField(
                    labelText: _appLocalizations.healthStatusCreationGlucose,
                    suffixText: 'mmol/l',
                    fractionDigits: 2,
                    validator: formValidators.numRangeValidator(0.01, 100.0),
                    initialValue: _initialHealthStatus?.glucose,
                    onSaved: (value) {
                      _healthStatusBuilder.glucose = value;
                    },
                  ),
                ],
              ),
              SmallSection(
                title: _appLocalizations.healthStatusCreationSwellings,
                children: [
                  AppSelectFormField<SwellingDifficultyEnum>(
                    labelText: _appLocalizations
                        .healthStatusCreationSwellingDifficulty,
                    dialogHelpText: _appLocalizations
                        .healthStatusCreationSwellingDifficultyHelper,
                    initialValue: _initialHealthStatus?.swellingDifficulty
                        ?.enumWithoutDefault(SwellingDifficultyEnum.unknown),
                    onSaved: (v) =>
                        _healthStatusBuilder.swellingDifficulty = v?.value,
                    items: [
                      AppSelectFormFieldItem(
                        text: '0+',
                        description: _appLocalizations
                            .healthStatusCreationSwellingDifficulty0,
                        icon: Icons.sentiment_very_satisfied,
                        value: SwellingDifficultyEnum.n0plus,
                      ),
                      AppSelectFormFieldItem(
                        text: '1+',
                        description: _appLocalizations
                            .healthStatusCreationSwellingDifficulty1,
                        icon: Icons.sentiment_satisfied,
                        value: SwellingDifficultyEnum.n1plus,
                      ),
                      AppSelectFormFieldItem(
                        text: '2+',
                        description: _appLocalizations
                            .healthStatusCreationSwellingDifficulty2,
                        icon: Icons.sentiment_dissatisfied,
                        value: SwellingDifficultyEnum.n2plus,
                      ),
                      AppSelectFormFieldItem(
                        text: '3+',
                        description: _appLocalizations
                            .healthStatusCreationSwellingDifficulty3,
                        icon: Icons.sentiment_very_dissatisfied,
                        value: SwellingDifficultyEnum.n3plus,
                      ),
                      AppSelectFormFieldItem(
                        text: '4+',
                        description: _appLocalizations
                            .healthStatusCreationSwellingDifficulty4,
                        icon: Icons.sick,
                        value: SwellingDifficultyEnum.n4plus,
                      ),
                    ],
                  ),
                  AppMultipleSelectFormField<SwellingEnum>(
                    initialValues: _initialHealthStatus?.swellings
                            ?.map((s) => s.swelling)
                            ?.where((s) => s != SwellingEnum.unknown)
                            ?.toList() ??
                        [],
                    labelText: _appLocalizations.healthStatusCreationSwellings,
                    onSaved: (v) {
                      final swellings = v?.map<SwellingRequest>((e) {
                        final swellingBuilder = SwellingRequestBuilder();
                        swellingBuilder.swelling = e.value;

                        return swellingBuilder.build();
                      })?.toList();
                      _healthStatusBuilder.swellings =
                          ListBuilder(swellings ?? []);
                    },
                    items: [
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationSwellingsLocalizationEyes,
                        value: SwellingEnum.eyes,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationSwellingsLocalizationWholeFace,
                        value: SwellingEnum.wholeFace,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationSwellingsLocalizationHandBreadth,
                        value: SwellingEnum.handBreadth,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationSwellingsLocalizationHands,
                        value: SwellingEnum.hands,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationSwellingsLocalizationBelly,
                        value: SwellingEnum.belly,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationSwellingsLocalizationKnees,
                        value: SwellingEnum.knees,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationSwellingsLocalizationFoot,
                        value: SwellingEnum.foot,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationSwellingsLocalizationWholeLegs,
                        value: SwellingEnum.wholeLegs,
                      ),
                    ],
                  ),
                ],
              ),
              SmallSection(
                title: _appLocalizations.healthStatusCreationWellFeeling,
                children: [
                  AppSelectFormField<WellFeelingEnum>(
                    labelText:
                        _appLocalizations.healthStatusCreationWellFeeling,
                    initialValue: _initialHealthStatus?.wellFeeling
                        ?.enumWithoutDefault(WellFeelingEnum.unknown),
                    onSaved: (v) => _healthStatusBuilder.wellFeeling = v?.value,
                    items: [
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationWellFeelingPerfect,
                        icon: Icons.sentiment_very_satisfied,
                        value: WellFeelingEnum.perfect,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationWellFeelingGood,
                        icon: Icons.sentiment_satisfied,
                        value: WellFeelingEnum.good,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationWellFeelingAverage,
                        icon: Icons.sentiment_dissatisfied,
                        value: WellFeelingEnum.average,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationWellFeelingBad,
                        icon: Icons.sentiment_very_dissatisfied,
                        value: WellFeelingEnum.bad,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationWellFeelingVeryBad,
                        icon: Icons.sick,
                        value: WellFeelingEnum.veryBad,
                      ),
                    ],
                  ),
                  AppSelectFormField<AppetiteEnum>(
                    labelText: _appLocalizations.healthStatusCreationAppetite,
                    onSaved: (v) => _healthStatusBuilder.appetite = v?.value,
                    initialValue: _initialHealthStatus?.appetite
                        ?.enumWithoutDefault(AppetiteEnum.unknown),
                    items: [
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationAppetitePerfect,
                        icon: Icons.sentiment_very_satisfied,
                        value: AppetiteEnum.perfect,
                      ),
                      AppSelectFormFieldItem(
                        text:
                            _appLocalizations.healthStatusCreationAppetiteGood,
                        icon: Icons.sentiment_satisfied,
                        value: AppetiteEnum.good,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationAppetiteAverage,
                        icon: Icons.sentiment_dissatisfied,
                        value: AppetiteEnum.average,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations.healthStatusCreationAppetiteBad,
                        icon: Icons.sentiment_very_dissatisfied,
                        value: AppetiteEnum.bad,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationAppetiteVeryBad,
                        icon: Icons.sick,
                        value: AppetiteEnum.veryBad,
                      ),
                    ],
                  ),
                  AppSelectFormField<ShortnessOfBreathEnum>(
                    labelText:
                        _appLocalizations.healthStatusCreationShortnessOfBreath,
                    initialValue: _initialHealthStatus?.shortnessOfBreath
                        ?.enumWithoutDefault(ShortnessOfBreathEnum.unknown),
                    onSaved: (v) =>
                        _healthStatusBuilder.shortnessOfBreath = v?.value,
                    items: [
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationShortnessOfBreathNo,
                        icon: Icons.sentiment_very_satisfied,
                        value: ShortnessOfBreathEnum.no,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationShortnessOfBreathLight,
                        description: _appLocalizations
                            .healthStatusCreationShortnessOfBreathLightHelper,
                        icon: Icons.sentiment_satisfied,
                        value: ShortnessOfBreathEnum.light,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationShortnessOfBreathAverage,
                        description: _appLocalizations
                            .healthStatusCreationShortnessOfBreathAverageHelper,
                        icon: Icons.sentiment_dissatisfied,
                        value: ShortnessOfBreathEnum.average,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationShortnessOfBreathSevere,
                        description: _appLocalizations
                            .healthStatusCreationShortnessOfBreathSevereHelper,
                        icon: Icons.sentiment_very_dissatisfied,
                        value: ShortnessOfBreathEnum.severe,
                      ),
                      AppSelectFormFieldItem(
                        text: _appLocalizations
                            .healthStatusCreationShortnessOfBreathBackbreaking,
                        description: _appLocalizations
                            .healthStatusCreationShortnessOfBreathBackbreakingHelper,
                        icon: Icons.sick,
                        value: ShortnessOfBreathEnum.backbreaking,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future validateAndSave(BuildContext context) async {
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

    final savingFuture = _apiService
        .createOrUpdateDailyHealthStatus(_healthStatusBuilder.build())
        .catchError(
      (e, stackTrace) async {
        await showAppDialog(
          context: context,
          title: _appLocalizations.error,
          message: _appLocalizations.serverErrorDescription,
        );
      },
    );

    final dailyHealthStatus =
        await ProgressDialog(context).showForFuture(savingFuture);

    if (dailyHealthStatus != null) {
      Navigator.of(context).pop(dailyHealthStatus);
    }
  }
}
