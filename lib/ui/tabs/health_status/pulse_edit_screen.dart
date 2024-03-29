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

class PulseEditScreenArguments {
  final Pulse pulse;

  PulseEditScreenArguments(this.pulse);
}

class PulseEditScreen extends StatefulWidget {
  final Pulse pulse;

  const PulseEditScreen({
    super.key,
    required this.pulse,
  });

  @override
  _PulseEditScreenState createState() => _PulseEditScreenState();
}

class _PulseEditScreenState extends State<PulseEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  late PulseRequestBuilder _requestBuilder;

  FormValidators get _formValidators => FormValidators(context);

  @override
  void initState() {
    super.initState();

    _requestBuilder = widget.pulse.toRequestBuilder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.pulse),
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
                        initialDate: _requestBuilder.measuredAt?.toDate() ??
                            DateTime.now().toDate(),
                        selectedDate: _requestBuilder.measuredAt?.toDate() ??
                            DateTime.now().toDate(),
                        firstDate: Constants.earliestDate,
                        lastDate: DateTime.now().toDate(),
                        validator: _formValidators.nonNull(),
                        onDateChanged: (date) {
                          _requestBuilder.measuredAt =
                              (_requestBuilder.measuredAt ?? DateTime.now())
                                  .appliedDate(date)
                                  .toUtc();
                        },
                        labelText: appLocalizations.date,
                      ),
                    ),
                    Flexible(
                      child: AppTimePickerFormField(
                        initialTime:
                            _requestBuilder.measuredAt?.timeOfDayLocal ??
                                TimeOfDay.now(),
                        labelText: appLocalizations.mealCreationTime,
                        onTimeChanged: (t) {
                          _requestBuilder.measuredAt =
                              (_requestBuilder.measuredAt ?? DateTime.now())
                                  .appliedLocalTime(t)
                                  .toUtc();
                        },
                        onTimeSaved: (t) {
                          _requestBuilder.measuredAt =
                              (_requestBuilder.measuredAt ?? DateTime.now())
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
              title: appLocalizations.pulse,
              children: [
                AppIntegerFormField(
                  labelText: appLocalizations.pulse,
                  suffixText: appLocalizations.pulseDimension,
                  validator: _formValidators.and(
                    _formValidators.nonNull(),
                    _formValidators.numRangeValidator(10, 200),
                  ),
                  initialValue: _requestBuilder.pulse,
                  onChanged: (p) => _requestBuilder.pulse = p,
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
                    foregroundColor: Colors.redAccent,
                  ),
                  onPressed: _deletePulse,
                  child: Text(appLocalizations.delete.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Pulse> _updatePulse() {
    return _apiService.updatePulse(widget.pulse.id, _requestBuilder.build());
  }

  Future<bool> _submit() {
    return FormUtils.validateAndSave(
      context: context,
      formKey: _formKey,
      futureBuilder: _updatePulse,
    );
  }

  Future<void> _deletePulse() async {
    final isDeleted = await showDeleteDialog(
      context: context,
      onDelete: () => _apiService.deletePulse(widget.pulse.id),
    );

    if (isDeleted) {
      Navigator.pop(context);
    }
  }
}
