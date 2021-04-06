import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_form.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class ManualPeritonealDialysisCreationScreenArguments {
  final ManualPeritonealDialysis? dialysis;

  ManualPeritonealDialysisCreationScreenArguments(this.dialysis);
}

class ManualPeritonealDialysisCreationScreen extends StatefulWidget {
  final ManualPeritonealDialysis? initialDialysis;

  const ManualPeritonealDialysisCreationScreen({
    Key? key,
    required this.initialDialysis,
  }) : super(key: key);

  @override
  _ManualPeritonealDialysisCreationScreenState createState() =>
      _ManualPeritonealDialysisCreationScreenState();
}

class _ManualPeritonealDialysisCreationScreenState
    extends State<ManualPeritonealDialysisCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();
  final _dateFormat = DateFormat('MMM d');

  final now = DateTime.now();
  final today = Date.today();
  late ManualPeritonealDialysisRequestBuilder _requestBuilder;

  int _currentStep = 0;

  bool _formChanged = false;

  bool get _isFirstStep => _currentStep == 0;

  bool get _isSecondStep => _currentStep == 1;

  bool get _isCompleted => widget.initialDialysis?.isCompleted ?? false;

  @override
  void initState() {
    super.initState();

    _requestBuilder = widget.initialDialysis?.toRequestBuilder() ??
        ManualPeritonealDialysisRequestBuilder();

    _requestBuilder.startedAt ??= DateTime.now().toUtc();
    _currentStep = _requestBuilder.isCompleted == false ? 1 : 0;

    _requestBuilder.isCompleted ??= false;
    _requestBuilder.dialysateColor ??= DialysateColorEnum.unknown;
    _requestBuilder.notes ??= '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.peritonealDialysis),
        actions: <Widget>[
          if (_isFirstStep)
            AppBarTextButton(
              onPressed: _submit,
              child: Text(appLocalizations.save.toUpperCase()),
            ),
          if (_isSecondStep)
            AppBarTextButton(
              onPressed: _completeAndSubmit,
              child: Text(appLocalizations.finish.toUpperCase()),
            ),
        ],
      ),
      body: AppForm(
        formKey: _formKey,
        save: () {
          if (_isFirstStep) {
            return _submit();
          } else {
            return _completeAndSubmit();
          }
        },
        onChanged: () {
          _formChanged = true;
        },
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepTapped: _validateAndProceedToStep,
          controlsBuilder: (context, {onStepContinue, onStepCancel}) {
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
        SmallSection(
          title: appLocalizations.manualDialysisStartDateTime,
          children: [
            Row(
              children: [
                Flexible(
                  child: AppDatePickerFormField(
                    initialDate: _requestBuilder.startedAt!.toDate(),
                    firstDate: Constants.earliestDate,
                    lastDate: Date.today(),
                    dateFormat: _dateFormat,
                    validator: formValidators.nonNull(),
                    onDateChanged: (date) {
                      _requestBuilder.startedAt =
                          _requestBuilder.startedAt!.appliedDate(date).toUtc();
                    },
                    labelText: appLocalizations.date,
                  ),
                ),
                Flexible(
                  child: AppTimePickerFormField(
                    initialTime: _requestBuilder.startedAt!.timeOfDayLocal,
                    labelText: appLocalizations.mealCreationTime,
                    onTimeChanged: (t) => _requestBuilder.startedAt =
                        _requestBuilder.startedAt!.appliedLocalTime(t).toUtc(),
                    onTimeSaved: (t) => _requestBuilder.startedAt =
                        _requestBuilder.startedAt!.appliedLocalTime(t).toUtc(),
                  ),
                ),
              ],
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.dialysisSolution,
          children: [
            AppSelectFormField<DialysisSolutionEnum>(
              labelText: appLocalizations.dialysisSolution,
              initialValue: _requestBuilder.dialysisSolution
                  ?.enumWithoutDefault(DialysisSolutionEnum.unknown),
              focusNextOnSelection: true,
              validator: formValidators.nonNull(),
              onChanged: (v) => _requestBuilder.dialysisSolution = v?.value,
              items: [
                for (final solution in DialysisSolutionEnum.values
                    .where((v) => v != DialysisSolutionEnum.unknown))
                  AppSelectFormFieldItem(
                    text: solution.localizedName(appLocalizations),
                    description:
                        solution.localizedDescription(appLocalizations),
                    icon: Icon(Icons.circle, color: solution.color),
                    value: solution,
                  ),
              ],
            ),
            AppIntegerFormField(
              labelText: appLocalizations.dialysisSolutionIn,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.next_plan_outlined),
              validator: formValidators.and(
                formValidators.nonNull(),
                formValidators.numRangeValidator(500, 15000),
              ),
              initialValue: _requestBuilder.solutionInMl,
              onChanged: (p) => _requestBuilder.solutionInMl = p,
            ),
          ],
        ),
      ],
    );
  }

  Widget _getSecondStep() {
    return Column(
      children: [
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
            AppIntegerFormField(
              labelText: appLocalizations.dialysisSolutionOut,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.outbond_outlined),
              validator: formValidators.and(
                _isSecondStep ? formValidators.nonNull() : (v) => null,
                formValidators.numRangeValidator(0, 20000),
              ),
              initialValue: _requestBuilder.solutionOutMl,
              onChanged: (p) => _requestBuilder.solutionOutMl = p,
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

  Future<ManualPeritonealDialysis> _save() {
    final request = _requestBuilder.build();

    if (widget.initialDialysis == null) {
      return _apiService.createManualPeritonealDialysis(request);
    } else {
      return _apiService.updateManualPeritonealDialysis(
        widget.initialDialysis!.id,
        request,
      );
    }
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
    );
  }

  Future<bool> _validateAndProceedToStep(int step) async {
    var valid = true;
    if (_formChanged) {
      valid = await FormUtils.validate(
        context: context,
        formKey: _formKey,
      );
    }

    if (valid) {
      setState(() => _currentStep = step);
      return true;
    }
    return false;
  }

  Future<void> _delete() async {
    final isDeleted = await showDeleteDialog(
      context: context,
      onDelete: () => _apiService.deleteManualPeritonealDialysis(
        widget.initialDialysis!.id,
      ),
    );

    if (isDeleted) {
      Navigator.pop(context);
    }
  }
}
