import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/ui/search.dart';

import 'forms.dart';

class MealCreationScreen extends StatefulWidget {
  @override
  _MealCreationScreenState createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dateFormat = DateFormat.yMMMMEEEEd();

  final _productTextEditingController = TextEditingController();

  var _mealDate = DateTime.now();
  var _mealTimeOfDay = TimeOfDay.now();
  int _quantityInGrams;

  Product _selectedProduct;

  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => showProductSearchScreen(context));
  }

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
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                AppDatePickerFormField(
                  initialDate: _mealDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  showInitialValue: true,
                  dateFormat: _dateFormat,
                  iconData: Icons.calendar_today,
                  onDateSaved: (dt) => print(dt),
                  labelText: "Data",
                ),
                AppTimePickerFormField(
                  labelText: "Laikas",
                  iconData: Icons.access_time,
                  initialTime: _mealTimeOfDay,
                  showInitialValue: true,
                  onTimeSaved: (t) => print(t),
                ),
                AppSelectionFormField(
                  labelText: "Produktas",
                  iconData: Icons.restaurant_outlined,
                  textEditingController: _productTextEditingController,
                  onTap: () => showProductSearchScreen(context),
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

  showProductSearchScreen(BuildContext context) async {
    final product = await showProductSearch(context);

    if (product != null) {
      _selectedProduct = product;
      _productTextEditingController.text = product.name;
    }
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

  @override
  void dispose() {
    super.dispose();
    _productTextEditingController.dispose();
  }
}
