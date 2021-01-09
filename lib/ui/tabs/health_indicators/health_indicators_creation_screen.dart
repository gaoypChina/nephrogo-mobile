import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nephrolog/extensions/extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/models/date.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/progress_indicator.dart';
import 'package:nephrolog_api_client/model/appetite_enum.dart';
import 'package:nephrolog_api_client/model/daily_health_status.dart';
import 'package:nephrolog_api_client/model/daily_health_status_request.dart';
import 'package:nephrolog_api_client/model/shortness_of_breath_enum.dart';
import 'package:nephrolog_api_client/model/swelling_difficulty_enum.dart';
import 'package:nephrolog_api_client/model/well_feeling_enum.dart';

class HealthIndicatorsCreationScreen extends StatefulWidget {
  @override
  _HealthIndicatorsCreationScreenState createState() =>
      _HealthIndicatorsCreationScreenState();
}

class _HealthIndicatorsCreationScreenState
    extends State<HealthIndicatorsCreationScreen> {
  final logger = Logger("HealthIndicatorsCreationScreen");

  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();
  DailyHealthStatusRequestBuilder _healthStatusBuilder;
  AppLocalizations _appLocalizations;
  bool isSubmitting = false;

  var _healthStatusMemoizer = AsyncMemoizer<DailyHealthStatus>();
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
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton.extended(
          onPressed: isSubmitting
              ? null
              : () => validateAndSaveHealthIndicators(context),
          label: Text(_appLocalizations.save.toUpperCase()),
          icon: Icon(Icons.save),
        ),
      ),
      body: AppFutureBuilder(
        future: _healthStatusMemoizer.future,
        builder: (context, healthStatus) {
          _initialHealthStatus = healthStatus;

          return _buildBody(context);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Visibility(
      visible: !isSubmitting,
      replacement: Center(
        child: AppProgressIndicator(),
      ),
      maintainState: true,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 64),
          children: <Widget>[
            SmallSection(
              title: _appLocalizations.healthStatusCreationBloodPressure,
              setLeftPadding: true,
              showDividers: false,
              headerPadding: EdgeInsets.all(8),
              children: [
                Row(
                  children: [
                    Flexible(
                      child: AppIntegerFormField(
                        labelText:
                            _appLocalizations.healthStatusCreationSystolic,
                        suffixText: "mmHg",
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
                        suffixText: "mmHg",
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
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppDoubleInputField(
                  labelText: _appLocalizations.weight,
                  suffixText: "kg",
                  helperText: _appLocalizations.userProfileWeightHelper,
                  initialValue: _initialHealthStatus?.weightKg,
                  onSaved: (value) {
                    _healthStatusBuilder.weightKg = value;
                  },
                ),
                AppIntegerFormField(
                  labelText: _appLocalizations.healthStatusCreationUrine,
                  suffixText: "ml",
                  initialValue: _initialHealthStatus?.urineMl,
                  onSaved: (value) {
                    _healthStatusBuilder.urineMl = value;
                  },
                ),
                // TODO rodyti tik cukraligei
                // mmol/l  - milimoliais litre, norma 3,33 - 5,55
                AppDoubleInputField(
                  labelText: _appLocalizations.healthStatusCreationGlucose,
                  suffixText: "mmol/l",
                  initialValue: _initialHealthStatus?.glucose,
                  onSaved: (value) {
                    _healthStatusBuilder.glucose = value;
                  },
                ),
              ],
            ),
            SmallSection(
              title: _appLocalizations.healthStatusCreationSwellings,
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppSelectFormField<SwellingDifficultyEnum>(
                  labelText:
                      _appLocalizations.healthStatusCreationSwellingDifficulty,
                  dialogHelpText: _appLocalizations
                      .healthStatusCreationSwellingDifficultyHelper,
                  initialValue: _initialHealthStatus?.swellingDifficulty
                      ?.enumWithoutDefault(SwellingDifficultyEnum.unknown),
                  onSaved: (v) =>
                      _healthStatusBuilder.swellingDifficulty = v?.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: "0+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty0,
                      icon: Icons.sentiment_very_satisfied,
                      value: SwellingDifficultyEnum.n0plus,
                    ),
                    AppSelectFormFieldItem(
                      text: "1+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty1,
                      icon: Icons.sentiment_satisfied,
                      value: SwellingDifficultyEnum.n1plus,
                    ),
                    AppSelectFormFieldItem(
                      text: "2+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty2,
                      icon: Icons.sentiment_dissatisfied,
                      value: SwellingDifficultyEnum.n2plus,
                    ),
                    AppSelectFormFieldItem(
                      text: "3+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty3,
                      icon: Icons.sentiment_very_dissatisfied,
                      value: SwellingDifficultyEnum.n3plus,
                    ),
                    AppSelectFormFieldItem(
                      text: "4+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty4,
                      icon: Icons.sick,
                      value: SwellingDifficultyEnum.n4plus,
                    ),
                  ],
                ),
                // TODO change to enums
                AppMultipleSelectFormField<String>(
                  labelText:
                      _appLocalizations.healthStatusCreationSwellingDifficulty,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationSwellingsLocalizationEyes,
                      value: "1",
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationSwellingsLocalizationWholeFace,
                      value: "2",
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationSwellingsLocalizationHandBreadth,
                      value: "3",
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationSwellingsLocalizationHands,
                      value: "4",
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationSwellingsLocalizationBelly,
                      value: "5",
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationSwellingsLocalizationKnees,
                      value: "6",
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationSwellingsLocalizationFoot,
                      value: "7",
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationSwellingsLocalizationWholeLegs,
                      value: "8",
                    ),
                  ],
                ),
              ],
            ),
            SmallSection(
              title: _appLocalizations.healthStatusCreationWellFeeling,
              showDividers: false,
              setLeftPadding: true,
              children: [
                AppSelectFormField<WellFeelingEnum>(
                  labelText: _appLocalizations.healthStatusCreationWellFeeling,
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
                      text:
                          _appLocalizations.healthStatusCreationWellFeelingGood,
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
                      text:
                          _appLocalizations.healthStatusCreationWellFeelingBad,
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
                      text:
                          _appLocalizations.healthStatusCreationAppetitePerfect,
                      icon: Icons.sentiment_very_satisfied,
                      value: AppetiteEnum.perfect,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.healthStatusCreationAppetiteGood,
                      icon: Icons.sentiment_satisfied,
                      value: AppetiteEnum.good,
                    ),
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.healthStatusCreationAppetiteAverage,
                      icon: Icons.sentiment_dissatisfied,
                      value: AppetiteEnum.average,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.healthStatusCreationAppetiteBad,
                      icon: Icons.sentiment_very_dissatisfied,
                      value: AppetiteEnum.bad,
                    ),
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.healthStatusCreationAppetiteVeryBad,
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
    );
  }

  Future validateAndSaveHealthIndicators(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return null;
    }

    setState(() {
      isSubmitting = true;
    });

    _formKey.currentState.save();

    DailyHealthStatus dailyHealthStatus;
    try {
      dailyHealthStatus = await _apiService
          .createOrUpdateDailyHealthStatus(_healthStatusBuilder.build());
    } catch (ex, st) {
      logger.warning(
        "Got error from API while submitting health status",
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

    Navigator.of(context).pop(dailyHealthStatus);
  }
}
