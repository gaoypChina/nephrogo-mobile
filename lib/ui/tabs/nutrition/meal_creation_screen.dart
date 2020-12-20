import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/search.dart';

import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog_api_client/model/product.dart';

class MealCreationScreen extends StatefulWidget {
  @override
  _MealCreationScreenState createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dateFormat = DateFormat.yMEd();

  var _mealDate = DateTime.now();
  var _mealTimeOfDay = TimeOfDay.now();
  int _quantityInGrams;

  Product _selectedProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pridėti valgį"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => validateAndSaveMeal(context),
        label: Text("IŠSAUGOTI"),
        icon: Icon(Icons.save),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 64),
          children: <Widget>[
            SmallSection(
              title: "Valgis arba gėrimas",
              showDividers: false,
              children: [
                AppSelectionScreenFormField<Product>(
                  labelText: "Produktas",
                  iconData: Icons.restaurant_outlined,
                  itemToStringConverter: (p) => p.name,
                  onTap: showProductSearch,
                  validator: FormValidators.nonNull(),
                  onSaved: (p) => _selectedProduct = p,
                ),
                AppIntegerFormField(
                  labelText: "Kiekis",
                  suffixText: "g",
                  validator: FormValidators.numRangeValidator(1, 10000),
                  iconData: Icons.kitchen,
                  onSaved: (value) {
                    _quantityInGrams = value;
                  },
                ),
              ],
            ),
            SmallSection(
              title: "Data ir laikas",
              showDividers: false,
              children: [
                AppDatePickerFormField(
                  initialDate: _mealDate,
                  selectedDate: _mealDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  validator: FormValidators.nonNull(),
                  dateFormat: _dateFormat,
                  iconData: Icons.calendar_today,
                  onDateSaved: (dt) => print(dt),
                  labelText: "Data",
                ),
                AppTimePickerFormField(
                  labelText: "Laikas",
                  iconData: Icons.access_time,
                  initialTime: _mealTimeOfDay,
                  onTimeSaved: (t) => print(t),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  validateAndSaveMeal(BuildContext context) {
    if (!_formKey.currentState.validate()) {
      return false;
    }
    if (_selectedProduct == null) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Nepasirinktas produktas!')));

      return false;
    }

    _formKey.currentState.save();

    print(_quantityInGrams);

    Navigator.pop(context);
  }
}
