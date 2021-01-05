import 'package:flutter/material.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog_api_client/model/daily_health_status.dart';

class HealthIndicatorsCreationScreen extends StatefulWidget {
  @override
  _HealthIndicatorsCreationScreenState createState() =>
      _HealthIndicatorsCreationScreenState();
}

class _HealthIndicatorsCreationScreenState
    extends State<HealthIndicatorsCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  DailyHealthStatusBuilder _statusBuilder;
  AppLocalizations _appLocalizations;

  @override
  void initState() {
    super.initState();

    _statusBuilder = DailyHealthStatusBuilder();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocalizations.healthStatusCreationTodayTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => validateAndSaveHealthIndicators(context),
        label: Text(_appLocalizations.save.toUpperCase()),
        icon: Icon(Icons.save),
      ),
      body: Form(
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
                        onSaved: (value) {
                          _statusBuilder.systolicBloodPressure = value;
                        },
                      ),
                    ),
                    Flexible(
                      child: AppIntegerFormField(
                        labelText:
                            _appLocalizations.healthStatusCreationDiastolic,
                        suffixText: "mmHg",
                        onSaved: (value) {
                          _statusBuilder.diastolicBloodPressure = value;
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
                  helperText: _appLocalizations.userConditionsWeightHelper,
                  onSaved: (value) {
                    _statusBuilder.weight = value;
                  },
                ),
                AppIntegerFormField(
                  labelText: _appLocalizations.healthStatusCreationUrine,
                  suffixText: "ml",
                  onSaved: (value) {
                    _statusBuilder.urineMl = value;
                  },
                ),
                // TODO rodyti tik cukraligei
                // mmol/l  - milimoliais litre, norma 3,33 - 5,55
                AppDoubleInputField(
                  labelText: _appLocalizations.healthStatusCreationGlucose,
                  suffixText: "mmol/l",
                  onSaved: (value) {},
                ),
              ],
            ),
            SmallSection(
              title: _appLocalizations.healthStatusCreationSwellings,
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppSelectFormField<int>(
                  labelText:
                      _appLocalizations.healthStatusCreationSwellingDifficulty,
                  dialogHelpText: _appLocalizations
                      .healthStatusCreationSwellingDifficultyHelper,
                  onSaved: (v) => _statusBuilder.severityOfSwelling = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: "0+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty0,
                      icon: Icons.sentiment_very_satisfied,
                      value: 0,
                    ),
                    AppSelectFormFieldItem(
                      text: "1+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty1,
                      icon: Icons.sentiment_satisfied,
                      value: 1,
                    ),
                    AppSelectFormFieldItem(
                      text: "2+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty2,
                      icon: Icons.sentiment_dissatisfied,
                      value: 2,
                    ),
                    AppSelectFormFieldItem(
                      text: "3+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty3,
                      icon: Icons.sentiment_very_dissatisfied,
                      value: 3,
                    ),
                    AppSelectFormFieldItem(
                      text: "4+",
                      description: _appLocalizations
                          .healthStatusCreationSwellingDifficulty4,
                      icon: Icons.sick,
                      value: 4,
                    ),
                  ],
                ),
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
                AppSelectFormField<int>(
                  labelText: _appLocalizations.healthStatusCreationWellFeeling,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationWellFeelingPerfect,
                      icon: Icons.sentiment_very_satisfied,
                      value: 0,
                    ),
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.healthStatusCreationWellFeelingGood,
                      icon: Icons.sentiment_satisfied,
                      value: 1,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationWellFeelingAverage,
                      icon: Icons.sentiment_dissatisfied,
                      value: 2,
                    ),
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.healthStatusCreationWellFeelingBad,
                      icon: Icons.sentiment_very_dissatisfied,
                      value: 3,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationWellFeelingVeryBad,
                      icon: Icons.sick,
                      value: 4,
                    ),
                  ],
                ),
                AppSelectFormField<int>(
                  labelText: _appLocalizations.healthStatusCreationAppetite,
                  items: [
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.healthStatusCreationAppetitePerfect,
                      icon: Icons.sentiment_very_satisfied,
                      value: 0,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.healthStatusCreationAppetiteGood,
                      icon: Icons.sentiment_satisfied,
                      value: 1,
                    ),
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.healthStatusCreationAppetiteAverage,
                      icon: Icons.sentiment_dissatisfied,
                      value: 2,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations.healthStatusCreationAppetiteBad,
                      icon: Icons.sentiment_very_dissatisfied,
                      value: 3,
                    ),
                    AppSelectFormFieldItem(
                      text:
                          _appLocalizations.healthStatusCreationAppetiteVeryBad,
                      icon: Icons.sick,
                      value: 4,
                    ),
                  ],
                ),
                AppSelectFormField<int>(
                  labelText:
                      _appLocalizations.healthStatusCreationShortnessOfBreath,
                  items: [
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationShortnessOfBreathNo,
                      icon: Icons.sentiment_very_satisfied,
                      value: 0,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationShortnessOfBreathLight,
                      description: _appLocalizations
                          .healthStatusCreationShortnessOfBreathLightHelper,
                      icon: Icons.sentiment_satisfied,
                      value: 1,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationShortnessOfBreathAverage,
                      description: _appLocalizations
                          .healthStatusCreationShortnessOfBreathAverageHelper,
                      icon: Icons.sentiment_dissatisfied,
                      value: 2,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationShortnessOfBreathSevere,
                      description: _appLocalizations
                          .healthStatusCreationShortnessOfBreathSevereHelper,
                      icon: Icons.sentiment_very_dissatisfied,
                      value: 3,
                    ),
                    AppSelectFormFieldItem(
                      text: _appLocalizations
                          .healthStatusCreationShortnessOfBreathBackbreaking,
                      description: _appLocalizations
                          .healthStatusCreationShortnessOfBreathBackbreakingHelper,
                      icon: Icons.sick,
                      value: 4,
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

  validateAndSaveHealthIndicators(BuildContext context) {}
}
