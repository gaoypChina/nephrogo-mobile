import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/stepper.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/model/blood_pressure.dart';
import 'package:nephrogo_api_client/model/blood_pressure_request.dart';
import 'package:nephrogo_api_client/model/daily_health_status_request.dart';
import 'package:nephrogo_api_client/model/dialysate_color_enum.dart';
import 'package:nephrogo_api_client/model/dialysis_solution_enum.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis_request.dart';
import 'package:nephrogo_api_client/model/pulse.dart';
import 'package:nephrogo_api_client/model/pulse_request.dart';

class ManualPeritonealDialysisCreationScreenArguments {
  final ManualPeritonealDialysis dialysis;

  ManualPeritonealDialysisCreationScreenArguments(this.dialysis);
}

class ManualPeritonealDialysisCreationScreen extends StatefulWidget {
  final ManualPeritonealDialysis initialDialysis;

  const ManualPeritonealDialysisCreationScreen(
      {Key key, @required this.initialDialysis})
      : super(key: key);

  @override
  _ManualPeritonealDialysisCreationScreenState createState() =>
      _ManualPeritonealDialysisCreationScreenState();
}

class _ManualPeritonealDialysisCreationScreenState
    extends State<ManualPeritonealDialysisCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  final now = DateTime.now();
  ManualPeritonealDialysisRequestBuilder _requestBuilder;
  int _systolicBloodPressure;
  int _diastolicBloodPressure;
  int _pulse;
  double _weightKg;
  int _urineMl;

  int _currentStep = 0;

  bool get _isSecondStep => _currentStep == 1;

  FormValidators get _formValidators => FormValidators(context);

  @override
  void initState() {
    super.initState();

    _requestBuilder = widget.initialDialysis?.toRequestBuilder() ??
        ManualPeritonealDialysisRequestBuilder();

    _requestBuilder.startedAt ??= DateTime.now().toUtc();
    _currentStep = _requestBuilder.isCompleted == false ? 1 : 0;

    _requestBuilder.isCompleted ??= false;

    _systolicBloodPressure =
        widget.initialDialysis?.bloodPressure?.systolicBloodPressure;
    _diastolicBloodPressure =
        widget.initialDialysis?.bloodPressure?.diastolicBloodPressure;
    _pulse = widget.initialDialysis?.pulse?.pulse;

    _weightKg = widget.initialDialysis?.weightKg;
    _urineMl = widget.initialDialysis?.urineMl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.addHealthStatus),
        actions: <Widget>[
          if (_isSecondStep)
            AppBarTextButton(
              onPressed: _completeAndSubmit,
              child: Text(appLocalizations.finish.toUpperCase()),
            ),
          if (!_isSecondStep)
            AppBarTextButton(
              onPressed: _submit,
              child: Text(appLocalizations.save.toUpperCase()),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: AppStepper(
          type: AppStepperType.horizontal,
          currentStep: _currentStep,
          onStepTapped: _validateAndProceedToStep,
          steps: [
            AppStep(
              title: Text(appLocalizations.manualPeritonealDialysisStep1),
              isActive: _currentStep == 0,
              state: _currentStep == 0 ? StepState.indexed : StepState.complete,
              content: _getFirstStep(),
            ),
            AppStep(
              title: Text(appLocalizations.manualPeritonealDialysisStep2),
              isActive: _currentStep == 1,
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
          title: appLocalizations.dialysisStartDateTime,
          children: [
            Row(
              children: [
                Flexible(
                  child: AppDatePickerFormField(
                    initialDate: _requestBuilder.startedAt.toLocal(),
                    selectedDate: _requestBuilder.startedAt.toLocal(),
                    firstDate: Constants.earliestDate,
                    lastDate: DateTime.now(),
                    validator: _formValidators.nonNull(),
                    onDateChanged: (dt) {
                      _requestBuilder.startedAt = _requestBuilder.startedAt
                          .appliedDate(dt.toDate())
                          .toUtc();
                    },
                    labelText: appLocalizations.date,
                  ),
                ),
                Flexible(
                  child: AppTimePickerFormField(
                    initialTime: TimeOfDay.fromDateTime(
                        _requestBuilder.startedAt.toLocal()),
                    labelText: appLocalizations.mealCreationTime,
                    onTimeChanged: (t) => _requestBuilder.startedAt =
                        _requestBuilder.startedAt.applied(t).toUtc(),
                    onTimeSaved: (t) => _requestBuilder.startedAt =
                        _requestBuilder.startedAt.applied(t).toUtc(),
                  ),
                ),
              ],
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.bloodPressureAndPulse,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: AppIntegerFormField(
                    labelText: appLocalizations.healthStatusCreationSystolic,
                    suffixText: 'mmHg',
                    validator: _formValidators.and(
                      _formValidators.nonNull(),
                      _formValidators.numRangeValidator(1, 350),
                    ),
                    textInputAction: TextInputAction.next,
                    initialValue: _systolicBloodPressure,
                    onChanged: (value) => _systolicBloodPressure = value,
                  ),
                ),
                Flexible(
                  child: AppIntegerFormField(
                    labelText: appLocalizations.healthStatusCreationDiastolic,
                    suffixText: 'mmHg',
                    validator: _formValidators.and(
                      _formValidators.nonNull(),
                      _formValidators.numRangeValidator(1, 200),
                    ),
                    textInputAction: TextInputAction.next,
                    initialValue: _diastolicBloodPressure,
                    onChanged: (value) => _diastolicBloodPressure = value,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Text(
                appLocalizations.healthStatusCreationBloodPressureHelper,
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AppIntegerFormField(
                labelText: appLocalizations.pulse,
                suffixText: appLocalizations.pulseDimension,
                validator: _formValidators.and(
                  _formValidators.nonNull(),
                  _formValidators.numRangeValidator(10, 200),
                ),
                textInputAction: TextInputAction.next,
                initialValue: _pulse,
                onChanged: (p) => _pulse = p,
              ),
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
              validator: _formValidators.nonNull(),
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
              suffixText: "ml",
              validator: _formValidators.and(
                _formValidators.nonNull(),
                _formValidators.numRangeValidator(1, 5000),
              ),
              initialValue: _requestBuilder.solutionInMl,
              onChanged: (p) => _requestBuilder.solutionInMl = p,
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.dailyHealthStatusIndicatorsNotRequired,
          children: [
            AppDoubleInputField(
              labelText: appLocalizations.dryWeight,
              fractionDigits: 1,
              suffixText: 'kg',
              textInputAction: TextInputAction.next,
              helperText: appLocalizations.userProfileWeightHelper,
              initialValue: _weightKg,
              validator: _formValidators.numRangeValidator(30.0, 300.0),
              onChanged: (value) => _weightKg = value,
            ),
            AppIntegerFormField(
              labelText: appLocalizations.healthStatusCreationUrine,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              initialValue: _urineMl,
              validator: _formValidators.numRangeValidator(0, 10000),
              onChanged: (value) => _urineMl = value,
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
              suffixText: "ml",
              textInputAction: TextInputAction.next,
              validator: _formValidators.and(
                _isSecondStep ? _formValidators.nonNull() : (v) => null,
                _formValidators.numRangeValidator(1, 5000),
              ),
              initialValue: _requestBuilder.solutionOutMl,
              onChanged: (p) => _requestBuilder.solutionOutMl = p,
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.dialysisEndDateTime,
          children: [
            Row(
              children: [
                Flexible(
                  child: AppDatePickerFormField(
                    initialDate: _requestBuilder.finishedAt?.toLocal() ?? now,
                    selectedDate: _requestBuilder.finishedAt?.toLocal() ?? now,
                    firstDate: _requestBuilder.startedAt,
                    lastDate: now,
                    validator: _formValidators.nonNull(),
                    onDateChanged: (dt) {
                      _requestBuilder.finishedAt = _requestBuilder.finishedAt
                          .appliedDate(dt.toDate())
                          .toUtc();
                    },
                    labelText: appLocalizations.date,
                  ),
                ),
                Flexible(
                  child: AppTimePickerFormField(
                    initialTime: TimeOfDay.fromDateTime(
                        _requestBuilder.finishedAt?.toLocal() ?? now),
                    labelText: appLocalizations.mealCreationTime,
                    onTimeChanged: (t) => _requestBuilder.finishedAt =
                        _requestBuilder.finishedAt.applied(t).toUtc(),
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
              labelText: appLocalizations.notes,
              textInputAction: TextInputAction.next,
              maxLines: 3,
            ),
          ],
        ),
      ],
    );
  }

  Future<BloodPressure> _saveBloodPressure() {
    final builder = BloodPressureRequestBuilder();
    builder.diastolicBloodPressure = _diastolicBloodPressure;
    builder.systolicBloodPressure = _systolicBloodPressure;
    builder.measuredAt = _requestBuilder.startedAt.toUtc();

    final bloodPressureRequest = builder.build();

    return _apiService.createBloodPressure(bloodPressureRequest);
  }

  Future<Pulse> _savePulse() {
    final builder = PulseRequestBuilder();
    builder.pulse = _pulse;
    builder.measuredAt = _requestBuilder.startedAt.toUtc();

    final pulseRequest = builder.build();

    return _apiService.createPulse(pulseRequest);
  }

  Future<bool> _saveWeightAndUrine() async {
    final builder = DailyHealthStatusRequestBuilder();
    builder.date = _requestBuilder.startedAt.toLocal().toDate();
    builder.weightKg = _weightKg;
    builder.urineMl = _urineMl;

    if (builder.weightKg != null || builder.urineMl != null) {
      final healthStatusRequest = builder.build();

      await _apiService.partialUpdateDailyHealthStatus(healthStatusRequest);

      return true;
    }

    return false;
  }

  Future<ManualPeritonealDialysis> _saveManualDialysis(
    BloodPressure bloodPressure,
    Pulse pulse,
  ) {
    _requestBuilder.bloodPressureId = bloodPressure.id;
    _requestBuilder.pulseId = pulse.id;

    final request = _requestBuilder.build();

    if (widget.initialDialysis == null) {
      return _apiService.createManualPeritonealDialysis(request);
    }

    return _apiService.updateManualPeritonealDialysis(
      widget.initialDialysis.id,
      request,
    );
  }

  Future<ManualPeritonealDialysis> _save() async {
    final pulse = await _savePulse();
    final bloodPressure = await _saveBloodPressure();
    await _saveWeightAndUrine();

    return _saveManualDialysis(bloodPressure, pulse);
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
}
