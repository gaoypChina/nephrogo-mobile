import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/tabs/nutrition/creation/product_search.dart';
import 'package:nephrolog_api_client/model/intake_request.dart';
import 'package:nephrolog_api_client/model/product.dart';

class MealCreationScreenArguments extends Equatable {
  final Product product;

  MealCreationScreenArguments(this.product);

  @override
  List<Object> get props => [product];
}

class MealCreationScreen extends StatefulWidget {
  final Product initialProduct;

  const MealCreationScreen({Key key, this.initialProduct}) : super(key: key);

  @override
  _MealCreationScreenState createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  AppLocalizations _appLocalizations;

  final _apiService = ApiService();

  final _dateFormat = DateFormat.yMEd();

  var _intakeBuilder = IntakeRequestBuilder();
  var _consumedAt = DateTime.now().toLocal();

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);

    final formValidators = FormValidators(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocalizations.mealCreationTitle),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => validateAndSaveMeal(context),
        label: Text(_appLocalizations.save.toUpperCase()),
        icon: Icon(Icons.save),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 64),
          children: <Widget>[
            SmallSection(
              title: _appLocalizations.mealCreationMealSectionTitle,
              showDividers: false,
              children: [
                AppSelectionScreenFormField<Product>(
                  labelText: _appLocalizations.mealCreationProduct,
                  initialSelection: widget.initialProduct,
                  iconData: Icons.restaurant_outlined,
                  itemToStringConverter: (p) => p.name,
                  onTap: (context) => showProductSearch(
                    context,
                    ProductSearchType.change,
                  ),
                  validator: formValidators.nonNull(),
                  onSaved: (p) => _intakeBuilder.productId = p.id,
                ),
                AppIntegerFormField(
                  labelText: _appLocalizations.mealCreationQuantity,
                  suffixText: "g",
                  validator: formValidators.numRangeValidator(1, 10000),
                  iconData: Icons.kitchen,
                  onSaved: (value) => _intakeBuilder.amountG = value,
                ),
              ],
            ),
            SmallSection(
              title: _appLocalizations.mealCreationDatetimeSectionTitle,
              showDividers: false,
              children: [
                AppDatePickerFormField(
                  initialDate: _consumedAt,
                  selectedDate: _consumedAt,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  validator: formValidators.nonNull(),
                  dateFormat: _dateFormat,
                  iconData: Icons.calendar_today,
                  onDateChanged: (dt) {
                    final ldt = dt.toLocal();
                    _consumedAt = DateTime(
                      ldt.year,
                      ldt.month,
                      ldt.day,
                      _consumedAt.hour,
                      _consumedAt.minute,
                    );
                  },
                  onDateSaved: (dt) =>
                      _intakeBuilder.consumedAt = _consumedAt.toUtc(),
                  labelText: _appLocalizations.mealCreationDate,
                ),
                AppTimePickerFormField(
                  labelText: _appLocalizations.mealCreationTime,
                  iconData: Icons.access_time,
                  initialTime: TimeOfDay(
                    hour: _consumedAt.hour,
                    minute: _consumedAt.minute,
                  ),
                  onTimeChanged: (t) => _consumedAt = _consumedAt.applied(t),
                  onTimeSaved: (t) =>
                      _intakeBuilder.consumedAt = _consumedAt.toUtc(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future validateAndSaveMeal(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return false;
    }
    _formKey.currentState.save();

    if (_intakeBuilder.productId == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(_appLocalizations.mealCreationErrorNoProductSelected),
      ));

      return false;
    }

    await _apiService.createIntake(_intakeBuilder.build());

    Navigator.pop(context);
  }
}
