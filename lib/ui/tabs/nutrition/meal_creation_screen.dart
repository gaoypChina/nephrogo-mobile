import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/ui/search.dart';

import '../../forms/forms.dart';

class MealCreationScreen extends StatefulWidget {
  @override
  _MealCreationScreenState createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dateFormat = DateFormat.yMMMMEEEEd();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                AppDatePickerFormField(
                  initialDate: _mealDate,
                  selectedDate: _mealDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
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
                AppSelectionScreenFormField<Product>(
                  labelText: "Produktas",
                  iconData: Icons.restaurant_outlined,
                  itemToStringConverter: (p) => p.name,
                  onTap: showProductSearch,
                  onSaved: (p) => _selectedProduct = p,
                ),
                AppIntegerFormField(
                  labelText: "Kiekis",
                  suffixText: "g",
                  iconData: Icons.kitchen,
                  onSaved: (value) {
                    _quantityInGrams = value;
                  },
                ),
              ],
            ),
          ),
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
