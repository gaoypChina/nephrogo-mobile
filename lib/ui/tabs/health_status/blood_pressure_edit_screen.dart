import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/model/blood_pressure.dart';
import 'package:nephrogo_api_client/model/blood_pressure_request.dart';

class BloodPressureEditScreenArguments {
  final BloodPressure bloodPressure;

  BloodPressureEditScreenArguments(this.bloodPressure);
}

class BloodPressureEditScreen extends StatefulWidget {
  final BloodPressure bloodPressure;

  const BloodPressureEditScreen({
    Key key,
    @required this.bloodPressure,
  }) : super(key: key);

  @override
  _BloodPressureEditScreenState createState() =>
      _BloodPressureEditScreenState();
}

class _BloodPressureEditScreenState extends State<BloodPressureEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  BloodPressureRequestBuilder _requestBuilder;

  FormValidators get _formValidators => FormValidators(context);

  @override
  void initState() {
    super.initState();

    _requestBuilder = widget.bloodPressure.toRequestBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.healthStatusCreationBloodPressure),
        actions: <Widget>[
          AppBarTextButton(
            onPressed: _submit,
            child: Text(appLocalizations.save.toUpperCase()),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SmallSection(
              title: appLocalizations.measureDateAndTime,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: AppDatePickerFormField(
                        initialDate: _requestBuilder.measuredAt.toLocal(),
                        selectedDate: _requestBuilder.measuredAt.toLocal(),
                        firstDate: Constants.earliestDate,
                        lastDate: DateTime.now(),
                        validator: _formValidators.nonNull(),
                        onDateChanged: (dt) {
                          _requestBuilder.measuredAt = _requestBuilder
                              .measuredAt
                              .appliedDate(dt.toDate())
                              .toUtc();
                        },
                        labelText: appLocalizations.date,
                      ),
                    ),
                    Flexible(
                      child: AppTimePickerFormField(
                        initialTime: TimeOfDay.fromDateTime(
                          _requestBuilder.measuredAt.toLocal(),
                        ),
                        labelText: appLocalizations.mealCreationTime,
                        onTimeChanged: (t) {
                          _requestBuilder.measuredAt =
                              _requestBuilder.measuredAt.applied(t).toUtc();
                        },
                        onTimeSaved: (t) {
                          _requestBuilder.measuredAt =
                              _requestBuilder.measuredAt.applied(t).toUtc();
                        },
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
                          _formValidators.nonNull(),
                          _formValidators.numRangeValidator(1, 350),
                        ),
                        textInputAction: TextInputAction.next,
                        initialValue: _requestBuilder.systolicBloodPressure,
                        onChanged: (value) {
                          _requestBuilder.systolicBloodPressure = value;
                        },
                      ),
                    ),
                    Flexible(
                      child: AppIntegerFormField(
                        labelText:
                            appLocalizations.healthStatusCreationDiastolic,
                        suffixText: 'mmHg',
                        validator: _formValidators.and(
                          _formValidators.nonNull(),
                          _formValidators.numRangeValidator(1, 200),
                        ),
                        initialValue: _requestBuilder.diastolicBloodPressure,
                        onChanged: (value) {
                          _requestBuilder.diastolicBloodPressure = value;
                        },
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
          ],
        ),
      ),
    );
  }

  Future<BloodPressure> _updateBloodPressure() {
    return _apiService.updateBloodPressure(
      widget.bloodPressure.id,
      _requestBuilder.build(),
    );
  }

  Future<bool> _submit() {
    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: _updateBloodPressure,
    );
  }
}
