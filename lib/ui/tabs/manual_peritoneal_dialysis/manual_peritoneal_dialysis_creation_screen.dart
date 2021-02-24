import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/stepper.dart';
import 'package:nephrogo/ui/tabs/manual_peritoneal_dialysis/extensions/dialysis_contract_extensions.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/model/blood_pressure.dart';
import 'package:nephrogo_api_client/model/blood_pressure_request.dart';
import 'package:nephrogo_api_client/model/create_manual_peritoneal_dialysis.dart';
import 'package:nephrogo_api_client/model/create_manual_peritoneal_dialysis_request.dart';
import 'package:nephrogo_api_client/model/daily_health_status_request.dart';
import 'package:nephrogo_api_client/model/dialysate_color_enum.dart';
import 'package:nephrogo_api_client/model/pulse.dart';
import 'package:nephrogo_api_client/model/pulse_request.dart';
import 'package:nephrogo_api_client/model/solution_enum.dart';

class ManualPeritonealDialysisCreationScreen extends StatefulWidget {
  @override
  _ManualPeritonealDialysisCreationScreenState createState() =>
      _ManualPeritonealDialysisCreationScreenState();
}

class _ManualPeritonealDialysisCreationScreenState
    extends State<ManualPeritonealDialysisCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  final now = DateTime.now();
  CreateManualPeritonealDialysisRequestBuilder _requestBuilder;
  int _systolicBloodPressure;
  int _diastolicBloodPressure;
  int _pulse;
  double _weightKg;
  int _urineMl;

  int _currentStep = 0;

  FormValidators get _formValidators => FormValidators(context);

  @override
  void initState() {
    super.initState();

    _requestBuilder = CreateManualPeritonealDialysisRequestBuilder();

    _requestBuilder.startedAt = DateTime.now().toUtc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.addHealthStatus),
        actions: <Widget>[
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
          onStepTapped: (i) {
            setState(() => _currentStep = i);
          },
          steps: [
            AppStep(
              title: Text("Dializės pradžia"),
              isActive: _currentStep == 0,
              state: _currentStep == 0 ? StepState.indexed : StepState.complete,
              content: _getFirstStep(),
            ),
            AppStep(
              title: Text("Dializės pabaiga"),
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
                    labelText: appLocalizations.mealCreationDate,
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
                      _formValidators.numRangeValidator(1, 350),
                      (v) {
                        if (v == null && _diastolicBloodPressure != null) {
                          return _formValidators.nonNull()(v);
                        }
                        return null;
                      },
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
                      _formValidators.numRangeValidator(1, 200),
                      (v) {
                        if (v == null && _systolicBloodPressure != null) {
                          return _formValidators.nonNull()(v);
                        }
                        return null;
                      },
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
                validator: _formValidators.numRangeValidator(10, 200),
                textInputAction: TextInputAction.next,
                initialValue: _pulse,
                onChanged: (p) => _pulse = p,
              ),
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.dailyHealthStatusIndicators,
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
        SmallSection(
          title: appLocalizations.dialysisSolution,
          children: [
            AppSelectFormField<SolutionEnum>(
              labelText: appLocalizations.dialysisSolution,
              initialValue: _requestBuilder.solution
                  ?.enumWithoutDefault(SolutionEnum.unknown),
              focusNextOnSelection: true,
              onChanged: (v) => _requestBuilder.solution = v?.value,
              items: [
                for (final solution in SolutionEnum.values
                    .where((v) => v != SolutionEnum.unknown))
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
              validator: _formValidators.numRangeValidator(1, 5000),
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
          title: appLocalizations.dialysisSolutionSection,
          children: [
            AppIntegerFormField(
              labelText: appLocalizations.dialysisSolutionOut,
              suffixText: "ml",
              textInputAction: TextInputAction.next,
              validator: _formValidators.numRangeValidator(1, 5000),
              initialValue: _requestBuilder.solutionOutMl,
              onChanged: (p) => _requestBuilder.solutionOutMl = p,
            ),
            AppSelectFormField<DialysateColorEnum>(
              labelText: appLocalizations.dialysateColor,
              initialValue: _requestBuilder.dialysateColor
                  ?.enumWithoutDefault(DialysateColorEnum.unknown),
              focusNextOnSelection: true,
              onChanged: (v) => _requestBuilder.dialysateColor = v?.value,
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
            AppTextFormField(
              labelText: appLocalizations.notes,
              textInputAction: TextInputAction.next,
              maxLines: 3,
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
                    labelText: appLocalizations.mealCreationDate,
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
      ],
    );
  }

  Widget _getList() {
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
                    labelText: appLocalizations.mealCreationDate,
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
          title: appLocalizations.healthStatusCreationBloodPressure,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: AppIntegerFormField(
                    labelText: appLocalizations.healthStatusCreationSystolic,
                    suffixText: 'mmHg',
                    validator: _formValidators.and(
                      _formValidators.numRangeValidator(1, 350),
                      (v) {
                        if (v == null && _diastolicBloodPressure != null) {
                          return _formValidators.nonNull()(v);
                        }
                        return null;
                      },
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
                      _formValidators.numRangeValidator(1, 200),
                      (v) {
                        if (v == null && _systolicBloodPressure != null) {
                          return _formValidators.nonNull()(v);
                        }
                        return null;
                      },
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
          ],
        ),
        SmallSection(
          title: appLocalizations.mandatoryHealthStatusIndicators,
          children: [
            AppDoubleInputField(
              labelText: appLocalizations.dryWeight,
              fractionDigits: 1,
              suffixText: 'kg',
              textInputAction: TextInputAction.next,
              helperText: appLocalizations.userProfileWeightHelper,
              // initialValue: _builder.,
              validator: _formValidators.numRangeValidator(30.0, 300.0),
              // onChanged: (value) => _builder.weightKg = value,
            ),
            AppIntegerFormField(
              labelText: appLocalizations.healthStatusCreationUrine,
              suffixText: 'ml',
              textInputAction: TextInputAction.next,
              // initialValue: _builder.uri,
              validator: _formValidators.numRangeValidator(0, 10000),
              // onChanged: (value) => _requestBuilder.urineMl = value,
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.dialysisSolutionSection,
          children: [
            AppSelectFormField<SolutionEnum>(
              labelText: appLocalizations.dialysisSolution,
              initialValue: _requestBuilder.solution
                  ?.enumWithoutDefault(SolutionEnum.unknown),
              focusNextOnSelection: true,
              onChanged: (v) => _requestBuilder.solution = v?.value,
              items: [
                for (final solution in SolutionEnum.values
                    .where((v) => v != SolutionEnum.unknown))
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
              validator: _formValidators.numRangeValidator(1, 5000),
              initialValue: _requestBuilder.solutionInMl,
              onChanged: (p) => _requestBuilder.solutionInMl = p,
            ),
          ],
        ),
        SmallSection(
          title: appLocalizations.dialysisSolutionSection,
          children: [
            AppIntegerFormField(
              labelText: appLocalizations.dialysisSolutionOut,
              suffixText: "ml",
              textInputAction: TextInputAction.next,
              validator: _formValidators.numRangeValidator(1, 5000),
              initialValue: _requestBuilder.solutionOutMl,
              onChanged: (p) => _requestBuilder.solutionOutMl = p,
            ),
            AppSelectFormField<DialysateColorEnum>(
              labelText: appLocalizations.dialysateColor,
              initialValue: _requestBuilder.dialysateColor
                  ?.enumWithoutDefault(DialysateColorEnum.unknown),
              focusNextOnSelection: true,
              onChanged: (v) => _requestBuilder.dialysateColor = v?.value,
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
            AppTextFormField(
              labelText: appLocalizations.notes,
              textInputAction: TextInputAction.next,
              maxLines: 3,
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
                    labelText: appLocalizations.mealCreationDate,
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

  Future<CreateManualPeritonealDialysis> _saveManualDialysis(
    BloodPressure bloodPressure,
    Pulse pulse,
  ) {
    _requestBuilder.bloodPressureId = bloodPressure.id;
    _requestBuilder.pulseId = pulse.id;

    final request = _requestBuilder.build();

    return _apiService.createManualPeritonealDialysis(request);
  }

  Future<CreateManualPeritonealDialysis> _save() async {
    final pulse = await _savePulse();
    final bloodPressure = await _saveBloodPressure();
    await _saveWeightAndUrine();

    return _saveManualDialysis(bloodPressure, pulse);
  }

  Future<bool> _submit() {
    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: _save,
    );
  }
}
