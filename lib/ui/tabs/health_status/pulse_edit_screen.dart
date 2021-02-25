import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/form_utils.dart';
import 'package:nephrogo_api_client/model/pulse.dart';
import 'package:nephrogo_api_client/model/pulse_request.dart';

class PulseEditScreenArguments {
  final Pulse pulse;

  PulseEditScreenArguments(this.pulse);
}

class PulseEditScreen extends StatefulWidget {
  final Pulse pulse;

  const PulseEditScreen({
    Key key,
    @required this.pulse,
  }) : super(key: key);

  @override
  _PulseEditScreenState createState() => _PulseEditScreenState();
}

class _PulseEditScreenState extends State<PulseEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  PulseRequestBuilder _requestBuilder;

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
}
