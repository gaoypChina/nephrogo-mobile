import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_form.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/automatic/beta_banner.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/peritoneal_dialysis_components.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class AutomaticPeritonealDialysisCreationScreenArguments {
  final AutomaticPeritonealDialysis? dialysis;

  AutomaticPeritonealDialysisCreationScreenArguments(this.dialysis);
}

class AutomaticPeritonealDialysisCreationScreen extends StatefulWidget {
  final AutomaticPeritonealDialysis? initialDialysis;

  const AutomaticPeritonealDialysisCreationScreen({
    Key? key,
    required this.initialDialysis,
  }) : super(key: key);

  @override
  _AutomaticPeritonealDialysisCreationScreenState createState() =>
      _AutomaticPeritonealDialysisCreationScreenState();
}

class _AutomaticPeritonealDialysisCreationScreenState
    extends State<AutomaticPeritonealDialysisCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();
  final _dateFormat = DateFormat('MMM d');

  final now = DateTime.now();
  final today = DateTime.now().toDate();

  late AutomaticPeritonealDialysisRequestBuilder _requestBuilder;

  int _currentStep = 0;

  bool get _isFirstStep => _currentStep == 0;

  bool get _isSecondStep => _currentStep == 1;

  FormValidators get _formValidators => FormValidators(context);

  bool get _isCompleted => widget.initialDialysis?.isCompleted ?? false;

  @override
  void initState() {
    super.initState();

    _requestBuilder = widget.initialDialysis?.toRequestBuilder() ??
        AutomaticPeritonealDialysisRequestBuilder();

    _requestBuilder.startedAt ??= DateTime.now().toUtc();

    _requestBuilder.solutionBlueInMl ??= 0;
    _requestBuilder.solutionGreenInMl ??= 0;
    _requestBuilder.solutionOrangeInMl ??= 0;
    _requestBuilder.solutionYellowInMl ??= 0;
    _requestBuilder.solutionPurpleInMl ??= 0;

    _requestBuilder.dialysateColor ??= DialysateColorEnum.unknown;
    _requestBuilder.notes ??= '';

    _currentStep = _requestBuilder.isCompleted == false ? 1 : 0;

    _requestBuilder.isCompleted ??= false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.peritonealDialysisTypeAutomatic),
        actions: <Widget>[
          if (_isSecondStep)
            AppBarTextButton(
              onPressed: _completeAndSubmit,
              child: Text(appLocalizations.finish.toUpperCase()),
            )
          else
            AppBarTextButton(
              onPressed: _submit,
              child: Text(appLocalizations.save.toUpperCase()),
            )
        ],
      ),
      body: AppForm(
        formKey: _formKey,
        save: () {
          if (_isSecondStep) {
            return _completeAndSubmit();
          } else {
            return _submit();
          }
        },
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepTapped: _validateAndProceedToStep,
          onStepContinue: () async {
            if (_currentStep == 0) {
              await _validateAndProceedToStep(_currentStep + 1);
            } else {
              await _completeAndSubmit();
            }
          },
          onStepCancel: _submit,
          controlsBuilder: (context, details) {
            return BasicSection(
              innerPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                if (_isFirstStep || _isCompleted)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppElevatedButton(
                        label:
                            Text(context.appLocalizations.save.toUpperCase()),
                        onPressed: _submit,
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppElevatedButton(
                        label: Text(context.appLocalizations.finishDialysis
                            .toUpperCase()),
                        onPressed: _completeAndSubmit,
                      ),
                    ),
                  ),
                if (widget.initialDialysis != null &&
                    (_isCompleted || _isFirstStep))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.redAccent,
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        onPressed: _delete,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            context.appLocalizations.delete.toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
          steps: [
            Step(
              title: Text(appLocalizations.manualPeritonealDialysisStep1),
              isActive: _currentStep == 0,
              state: _currentStep == 0 ? StepState.indexed : StepState.complete,
              content: _getFirstStep(),
            ),
            Step(
              title: Text(appLocalizations.manualPeritonealDialysisStep2),
              isActive: _currentStep == 1,
              state: _isCompleted && _currentStep != 1
                  ? StepState.complete
                  : StepState.indexed,
              content: _getSecondStep(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFirstStep() {
    return Column(
      children: [
        BetaBanner(),
        SmallSection(
          title: appLocalizations.automaticDialysisStartDateTime,
          children: [
            Row(
              children: [
                Flexible(
                  child: AppDatePickerFormField(
                    initialDate: _requestBuilder.startedAt?.toDate() ?? today,
                    firstDate: Constants.earliestDate,
                    lastDate: DateTime.now().toDate(),
                    dateFormat: _dateFormat,
                    validator: _formValidators.nonNull(),
                    onDateChanged: (date) {
                      _requestBuilder.startedAt =
                          (_requestBuilder.startedAt ?? now)
                              .appliedDate(date)
                              .toUtc();
                    },
                    labelText: appLocalizations.date,
                  ),
                ),
                Flexible(
                  child: AppTimePickerFormField(
                    initialTime: _requestBuilder.startedAt?.timeOfDayLocal ??
                        TimeOfDay.now(),
                    labelText: appLocalizations.mealCreationTime,
                    onTimeChanged: (t) => _requestBuilder.startedAt =
                        (_requestBuilder.startedAt ?? now)
                            .appliedLocalTime(t)
                            .toUtc(),
                    onTimeSaved: (t) => _requestBuilder.startedAt =
                        (_requestBuilder.startedAt ?? now)
                            .appliedLocalTime(t)
                            .toUtc(),
                  ),
                ),
              ],
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.dialysisSolutionVolumes,
          children: [
            AppIntegerFormField(
              icon: const DialysisSolutionAvatar(
                dialysisSolution: DialysisSolutionEnum.yellow,
              ),
              labelText: appLocalizations.dialysisSolutionYellow,
              helperText: appLocalizations.dialysisSolutionYellowDescription,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _validateSolution,
              initialValue: _requestBuilder.solutionYellowInMl != 0
                  ? _requestBuilder.solutionYellowInMl
                  : null,
              onChanged: (p) => _requestBuilder.solutionYellowInMl = p ?? 0,
            ),
            AppIntegerFormField(
              icon: const DialysisSolutionAvatar(
                dialysisSolution: DialysisSolutionEnum.green,
              ),
              labelText: appLocalizations.dialysisSolutionGreen,
              helperText: appLocalizations.dialysisSolutionGreenDescription,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _validateSolution,
              initialValue: _requestBuilder.solutionGreenInMl != 0
                  ? _requestBuilder.solutionGreenInMl
                  : null,
              onChanged: (p) => _requestBuilder.solutionGreenInMl = p ?? 0,
            ),
            AppIntegerFormField(
              icon: const DialysisSolutionAvatar(
                dialysisSolution: DialysisSolutionEnum.orange,
              ),
              labelText: appLocalizations.dialysisSolutionOrange,
              helperText: appLocalizations.dialysisSolutionOrangeDescription,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _validateSolution,
              initialValue: _requestBuilder.solutionOrangeInMl != 0
                  ? _requestBuilder.solutionOrangeInMl
                  : null,
              onChanged: (p) => _requestBuilder.solutionOrangeInMl = p ?? 0,
            ),
            AppIntegerFormField(
              icon: const DialysisSolutionAvatar(
                dialysisSolution: DialysisSolutionEnum.blue,
              ),
              labelText: appLocalizations.dialysisSolutionBlue,
              helperText: appLocalizations.dialysisSolutionBlueDescription,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _validateSolution,
              initialValue: _requestBuilder.solutionBlueInMl != 0
                  ? _requestBuilder.solutionBlueInMl
                  : null,
              onChanged: (p) => _requestBuilder.solutionBlueInMl = p ?? 0,
            ),
            AppIntegerFormField(
              icon: const DialysisSolutionAvatar(
                dialysisSolution: DialysisSolutionEnum.purple,
              ),
              labelText: appLocalizations.dialysisSolutionPurple,
              helperText: appLocalizations.dialysisSolutionPurpleDescription,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _validateSolution,
              initialValue: _requestBuilder.solutionPurpleInMl != 0
                  ? _requestBuilder.solutionPurpleInMl
                  : null,
              onChanged: (p) => _requestBuilder.solutionPurpleInMl = p ?? 0,
            ),
          ],
        ),
      ],
    );
  }

  FormFieldValidator<int> get _validateSolution {
    return _formValidators.and(
      _formValidators.numRangeValidator(0, 15000),
      _validateAtLeastOneSolutionSelected,
    );
  }

  String? _validateAtLeastOneSolutionSelected(int? v) {
    final totalSolution = (_requestBuilder.solutionGreenInMl ?? 0) +
        (_requestBuilder.solutionPurpleInMl ?? 0) +
        (_requestBuilder.solutionYellowInMl ?? 0) +
        (_requestBuilder.solutionOrangeInMl ?? 0) +
        (_requestBuilder.solutionBlueInMl ?? 0);

    if (totalSolution == 0) {
      return appLocalizations.errorNoDialysisSolutionSelected;
    }
    return null;
  }

  Widget _getSecondStep() {
    return Column(
      children: [
        SmallSection(
          title: appLocalizations.machineReadings,
          children: [
            AppIntegerFormField(
              labelText: appLocalizations.initialDraining,
              helperText: appLocalizations.initialDrainingHelper,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _formValidators.and(
                _formValidators.nonNull(),
                _formValidators.numRangeValidator(0, 20000),
              ),
              initialValue: _requestBuilder.initialDrainingMl,
              onChanged: (p) => _requestBuilder.initialDrainingMl = p,
            ),
            AppIntegerFormField(
              labelText: appLocalizations.totalDrainVolume,
              helperText: appLocalizations.totalDrainVolumeHelper,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _formValidators.and(
                _formValidators.nonNull(),
                _formValidators.numRangeValidator(0, 20000),
              ),
              initialValue: _requestBuilder.totalDrainVolumeMl,
              onChanged: (p) => _requestBuilder.totalDrainVolumeMl = p,
            ),
            AppIntegerFormField(
              labelText: appLocalizations.lastFill,
              helperText: appLocalizations.lastFillHelper,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _formValidators.and(
                _formValidators.nonNull(),
                _formValidators.numRangeValidator(0, 15000),
              ),
              initialValue: _requestBuilder.lastFillMl,
              onChanged: (p) => _requestBuilder.lastFillMl = p,
            ),
            AppIntegerFormField(
              labelText: appLocalizations.totalUltraFiltration,
              helperText: appLocalizations.totalUltraFiltrationHelper,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              validator: _formValidators.and(
                _formValidators.nonNull(),
                _formValidators.numRangeValidator(0, 40000),
              ),
              initialValue: _requestBuilder.totalUltrafiltrationMl,
              onChanged: (p) => _requestBuilder.totalUltrafiltrationMl = p,
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.dialysate,
          children: [
            AppSelectFormField<DialysateColorEnum>(
              labelText: appLocalizations.dialysateColor,
              initialValue: _requestBuilder.dialysateColor
                      ?.enumWithoutDefault(DialysateColorEnum.unknown) ??
                  DialysateColorEnum.transparent,
              focusNextOnSelection: true,
              dialogHelpText: appLocalizations.dialysateColorWarning,
              onChanged: (v) => _requestBuilder.dialysateColor = v?.value,
              onSaved: (v) {
                if (_isSecondStep) {
                  _requestBuilder.dialysateColor = v?.value;
                }
              },
              items: [
                for (final color in DialysateColorEnum.values
                    .where((v) => v != DialysateColorEnum.unknown))
                  AppSelectFormFieldItem(
                    text: color.localizedName(appLocalizations),
                    icon: Icon(Icons.circle, color: color.color),
                    value: color,
                  ),
              ],
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.automaticDialysisEndDateTime,
          children: [
            Row(
              children: [
                Flexible(
                  child: AppDatePickerFormField(
                    initialDate: _requestBuilder.finishedAt?.toDate() ?? today,
                    firstDate: _requestBuilder.startedAt?.toDate() ??
                        Constants.earliestDate,
                    lastDate: today,
                    dateFormat: _dateFormat,
                    validator: _formValidators.nonNull(),
                    onDateChanged: (date) {
                      _requestBuilder.finishedAt =
                          (_requestBuilder.finishedAt ?? now)
                              .appliedDate(date)
                              .toUtc();
                    },
                    labelText: appLocalizations.date,
                  ),
                ),
                Flexible(
                  child: AppTimePickerFormField(
                    initialTime:
                        (_requestBuilder.finishedAt ?? now).timeOfDayLocal,
                    labelText: appLocalizations.mealCreationTime,
                    onTimeChanged: (t) => _requestBuilder.finishedAt =
                        (_requestBuilder.finishedAt ?? now)
                            .appliedLocalTime(t)
                            .toUtc(),
                    onTimeSaved: (t) {
                      if (_isSecondStep) {
                        _requestBuilder.finishedAt =
                            (_requestBuilder.finishedAt ?? now)
                                .appliedLocalTime(t)
                                .toUtc();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.notes,
          children: [
            AppTextFormField(
              textCapitalization: TextCapitalization.sentences,
              labelText: appLocalizations.notes,
              initialValue: _requestBuilder.notes,
              textInputAction: TextInputAction.next,
              onChanged: (s) => _requestBuilder.notes = s,
              onSaved: (s) => _requestBuilder.notes = s,
              maxLines: 3,
            ),
          ],
        ),
      ],
    );
  }

  Future<AutomaticPeritonealDialysis> _save() {
    final request = _requestBuilder.build();

    if (widget.initialDialysis == null) {
      return _apiService.createAutomaticPeritonealDialysis(request);
    }

    return _apiService.updateAutomaticPeritonealDialysis(
      widget.initialDialysis?.date ?? today,
      request,
    );
  }

  Future<bool> _completeAndSubmit() {
    _requestBuilder.isCompleted = true;

    return _submit();
  }

  Future<bool> _submit() {
    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: _save,
      onServerValidationError: _onServerValidationError,
    );
  }

  String _onServerValidationError(String data) {
    if (data.contains('same date')) {
      return appLocalizations.errorAutomaticDialysisWithSameDateExists;
    }
    return appLocalizations.serverErrorDescription;
  }

  Future<bool> _validateAndProceedToStep(int step) async {
    final valid = await FormUtils.validate(
      context: context,
      formKey: _formKey,
    );

    if (valid) {
      setState(() => _currentStep = step);
      return true;
    }
    return false;
  }

  Future<void> _delete() async {
    final isDeleted = await showDeleteDialog(
      context: context,
      onDelete: () => _apiService.deleteAutomaticPeritonealDialysis(
        widget.initialDialysis!.date,
      ),
    );

    if (isDeleted) {
      Navigator.pop(context);
    }
  }
}
