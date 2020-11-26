import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/intake.dart';
import 'package:nephrolog/ui/search.dart';

import 'forms.dart';

class MealCreationScreen extends StatefulWidget {
  @override
  _MealCreationScreenState createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _dateFormat = DateFormat.yMMMMEEEEd();
  final _timeFormat = DateFormat.Hm();

  var _mealDate = DateTime.now();
  var _mealTimeOfDay = TimeOfDay.now();
  int _quantityInGrams;

  // AppSelectionFormField<Product> _productFormField;
  Product _selectedProduct;

  void initState() {
    super.initState();

    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => showSearch(context));
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
                  dateFormat: _dateFormat,
                  iconData: Icons.calendar_today,
                  labelText: "Data",
                ),
                AppDatePickerFormField(
                  initialDate: _mealDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  dateFormat: _dateFormat,
                  iconData: Icons.access_time,
                  labelText: "Laikas",
                ),
                AppSelectionFormField<Product>(
                  labelText: "Produktas",
                  iconData: Icons.restaurant_outlined,
                  autoFocus: true,
                  onTap: () async {
                    return await showProductSearch(context);
                  },
                  valueToTextConverter: (Product p) {
                    return p?.name ?? "Nepasirinktas";
                  },
                  initialValue: _selectedProduct,
                  // onSaved: (Product p) => print("p"),
                ),
                AppIntegerFormField(
                  labelText: "Kiekis",
                  helperText: "Kiekis gramais",
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

  void onSavedProduct<Product>(Product product) {
    // _selectedProduct = product;
  }

  String toProductText(dynamic p) {
    return (p as Product)?.name ?? "Nepasirinktas";

  }

  showMealDatePicker() async {
    final dateTime = await showDatePicker(
      context: context,
      initialDate: _mealDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (dateTime != null) {
      setState(() {
        _mealDate = dateTime;
      });
    }
  }

  showMealTimePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _mealTimeOfDay,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (time != null) {
      setState(() {
        _mealTimeOfDay = time;
      });
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

  // showSearch(BuildContext context) async {
  //   final product = await showProductSearch(context);
  //   setState(() {
  //     _selectedProduct = product ?? _selectedProduct;
  //   });
  // }
}
