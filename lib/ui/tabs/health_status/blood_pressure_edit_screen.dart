import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/app_form.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class BloodPressureEditScreenArguments {
  final BloodPressure bloodPressure;

  BloodPressureEditScreenArguments(this.bloodPressure);
}

class BloodPressureEditScreen extends StatefulWidget {
  final BloodPressure bloodPressure;

  const BloodPressureEditScreen({
    super.key,
    required this.bloodPressure,
  });

  @override
  _BloodPressureEditScreenState createState() =>
      _BloodPressureEditScreenState();
}

class _BloodPressureEditScreenState extends State<BloodPressureEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  late BloodPressureRequestBuilder _requestBuilder;

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
                        initialDate: _requestBuilder.measuredAt!.toDate(),
                        selectedDate: _requestBuilder.measuredAt!.toDate(),
                        firstDate: Constants.earliestDate,
                        lastDate: DateTime.now().toDate(),
                        validator: _formValidators.nonNull(),
                        onDateChanged: (date) {
                          _requestBuilder.measuredAt = _requestBuilder
                              .measuredAt!
                              .appliedDate(date)
                              .toUtc();
                        },
                        labelText: appLocalizations.date,
                      ),
                    ),
                    Flexible(
                      child: AppTimePickerFormField(
                        initialTime: _requestBuilder.measuredAt!.timeOfDayLocal,
                        labelText: appLocalizations.mealCreationTime,
                        onTimeChanged: (t) {
                          _requestBuilder.measuredAt = _requestBuilder
                              .measuredAt!
                              .appliedLocalTime(t)
                              .toUtc();
                        },
                        onTimeSaved: (t) {
                          _requestBuilder.measuredAt = _requestBuilder
                              .measuredAt!
                              .appliedLocalTime(t)
                              .toUtc();
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
            BasicSection.single(
              innerPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent),
                  onPressed: _deleteBloodPressure,
                  child: Text(appLocalizations.delete.toUpperCase()),
                ),
              ),
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

  Future<void> _deleteBloodPressure() async {
    final isDeleted = await showDeleteDialog(
      context: context,
      onDelete: () => _apiService.deleteBloodPressure(widget.bloodPressure.id),
    );

    if (isDeleted) {
      Navigator.pop(context);
    }
  }

  Future<bool> _submit() {
    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: _updateBloodPressure,
    );
  }
}
