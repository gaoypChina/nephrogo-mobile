import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
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

enum _ManualDialysisState {
  initial,
  secondStep,
  completed,
}

class _ManualPeritonealDialysisCreationScreenState
    extends State<ManualPeritonealDialysisCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();
  final _dateFormat = DateFormat('MMM d');

  final now = DateTime.now();
  final today = DateTime.now().toDate();
  late ManualPeritonealDialysisRequestBuilder _requestBuilder;

  _ManualDialysisState get _dialysisState {
    if (widget.initialDialysis == null) {
      return _ManualDialysisState.initial;
    } else if (widget.initialDialysis?.isCompleted == true) {
      return _ManualDialysisState.completed;
    } else {
      return _ManualDialysisState.secondStep;
    }
  }

  @override
  void initState() {
    super.initState();

    _requestBuilder = widget.initialDialysis?.toRequestBuilder() ??
        ManualPeritonealDialysisRequestBuilder();

    _requestBuilder.startedAt ??= DateTime.now().toUtc();

    _requestBuilder.isCompleted ??= false;
    _requestBuilder.dialysateColor ??= DialysateColorEnum.unknown;
    _requestBuilder.notes ??= '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.peritonealDialysisTypeManual),
        actions: <Widget>[
          if (_dialysisState == _ManualDialysisState.secondStep)
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
          if (_dialysisState == _ManualDialysisState.initial) {
            return _submit();
          } else {
            return _completeAndSubmit();
          }
        },
        child: ListView(
          children: [
            ..._getDialysisFormWidgets(),
            BasicSection(
              innerPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: _getFormButtons().toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getDialysisFormWidgets() {
    switch (_dialysisState) {
      case _ManualDialysisState.initial:
        return _getFirstStepWidgets();
      case _ManualDialysisState.secondStep:
        return [
          ..._getSecondStepWidgets(),
          ..._getFirstStepWidgets(),
        ];
      case _ManualDialysisState.completed:
        return [
          ..._getFirstStepWidgets(),
          ..._getSecondStepWidgets(),
        ];
    }
  }

  List<Widget> _getFirstStepWidgets() {
    return [
      LargeSection(
        title: Text(appLocalizations.manualPeritonealDialysisStep1),
        leading: const CircleAvatar(
          child: Icon(Icons.opacity),
        ),
        children: const [],
      ),
      SmallSection(
        title: appLocalizations.manualDialysisStartDateTime,
        children: [
          Row(
            children: [
              Flexible(
                child: AppDatePickerFormField(
                  initialDate: _requestBuilder.startedAt!.toDate(),
                  selectedDate: _requestBuilder.startedAt!.toDate(),
                  firstDate: Constants.earliestDate,
                  lastDate: DateTime.now().toDate(),
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
                  description: solution.localizedDescription(appLocalizations),
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
    ];
  }

  List<Widget> _getSecondStepWidgets() {
    return [
      LargeSection(
        title: Text(appLocalizations.manualPeritonealDialysisStep2),
        leading: const CircleAvatar(
          child: Icon(Icons.outbound),
        ),
        children: const [],
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
            onSaved: (v) => _requestBuilder.dialysateColor = v?.value,
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
              formValidators.nonNull(),
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
    ];
  }

  Iterable<Widget> _getFormButtons() sync* {
    if (_dialysisState == _ManualDialysisState.secondStep) {
      yield _completeAndSubmitButton();
    } else {
      yield _submitButton();
    }

    if (_dialysisState != _ManualDialysisState.initial) {
      yield _deleteButton();
    }
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

  Widget _deleteButton() {
    return ListFullWidthButton(
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
    );
  }

  Widget _completeAndSubmitButton() {
    return ListFullWidthButton(
      child: AppElevatedButton(
        label: Text(
          context.appLocalizations.finishDialysis.toUpperCase(),
        ),
        onPressed: _completeAndSubmit,
      ),
    );
  }

  Widget _submitButton() {
    return ListFullWidthButton(
      child: AppElevatedButton(
        label: Text(context.appLocalizations.save.toUpperCase()),
        onPressed: _submit,
      ),
    );
  }
}
