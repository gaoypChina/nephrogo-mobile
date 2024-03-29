import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_form.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class BloodPressureAndPulseCreationScreenArguments {
  final Date? date;

  BloodPressureAndPulseCreationScreenArguments({this.date});
}

class BloodPressureAndPulseCreationScreen extends StatefulWidget {
  final Date? initialDate;

  const BloodPressureAndPulseCreationScreen({
    super.key,
    required this.initialDate,
  });

  @override
  _BloodPressureAndPulseCreationScreenState createState() =>
      _BloodPressureAndPulseCreationScreenState();
}

class _BloodPressureAndPulseCreationScreenState
    extends State<BloodPressureAndPulseCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  late DateTime _measuredAt;
  int? _systolicBloodPressure;
  int? _diastolicBloodPressure;
  int? _pulse;

  FormValidators get _formValidators => FormValidators(context);

  bool get _isPulsePresent => _pulse != null;

  bool get _isBloodPressurePresent =>
      _systolicBloodPressure != null && _diastolicBloodPressure != null;

  @override
  void initState() {
    super.initState();

    _measuredAt = DateTime.now();

    if (widget.initialDate != null) {
      _measuredAt = _measuredAt.appliedDate(widget.initialDate!);
    }
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
      body: AppForm(
        formKey: _formKey,
        save: _submit,
        child: ListView(
          children: [
            SmallSection(
              title: appLocalizations.measureDateAndTime,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: AppDatePickerFormField(
                        initialDate: _measuredAt.toDate(),
                        selectedDate: _measuredAt.toDate(),
                        firstDate: Constants.earliestDate,
                        lastDate: DateTime.now().toDate(),
                        validator: _formValidators.nonNull(),
                        onDateChanged: (date) {
                          _measuredAt = _measuredAt.appliedDate(date).toUtc();
                        },
                        labelText: appLocalizations.date,
                      ),
                    ),
                    Flexible(
                      child: AppTimePickerFormField(
                        initialTime: _measuredAt.timeOfDayLocal,
                        labelText: appLocalizations.mealCreationTime,
                        onTimeChanged: (t) => _measuredAt =
                            _measuredAt.appliedLocalTime(t).toUtc(),
                        onTimeSaved: (t) => _measuredAt =
                            _measuredAt.appliedLocalTime(t).toUtc(),
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
                        labelText:
                            appLocalizations.healthStatusCreationSystolic,
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
                        labelText:
                            appLocalizations.healthStatusCreationDiastolic,
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
              title: appLocalizations.pulse,
              children: [
                AppIntegerFormField(
                  labelText: appLocalizations.pulse,
                  suffixText: appLocalizations.pulseDimension,
                  validator: _formValidators.numRangeValidator(10, 200),
                  initialValue: _pulse,
                  onChanged: (p) => _pulse = p,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<BloodPressure> _saveBloodPressure() {
    final builder = BloodPressureRequestBuilder();
    builder.diastolicBloodPressure = _diastolicBloodPressure;
    builder.systolicBloodPressure = _systolicBloodPressure;
    builder.measuredAt = _measuredAt.toUtc();

    final bloodPressureRequest = builder.build();

    return _apiService.createBloodPressure(bloodPressureRequest);
  }

  Future<Pulse> _savePulse() {
    final builder = PulseRequestBuilder();
    builder.pulse = _pulse;
    builder.measuredAt = _measuredAt.toUtc();

    final pulseRequest = builder.build();

    return _apiService.createPulse(pulseRequest);
  }

  Future<bool> _save() async {
    if (_isPulsePresent) {
      await _savePulse();
    }

    if (_isBloodPressurePresent) {
      await _saveBloodPressure();
    }

    return true;
  }

  Future<bool> _submit() {
    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: _save,
    );
  }
}
