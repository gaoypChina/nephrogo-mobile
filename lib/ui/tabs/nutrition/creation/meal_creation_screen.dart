import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/forms/forms.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/tabs/nutrition/creation/product_search.dart';
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

  final _dateFormat = DateFormat.yMEd();

  var _mealDate = DateTime.now();
  var _mealTimeOfDay = TimeOfDay.now();
  int _quantityInGrams;

  Product _selectedProduct;

  @override
  Widget build(BuildContext context) {
    final formValidators = FormValidators(context);

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
                  initialSelection: widget.initialProduct,
                  iconData: Icons.restaurant_outlined,
                  itemToStringConverter: (p) => p.name,
                  onTap: (context) => showProductSearch(
                    context,
                    ProductSearchType.change,
                  ),
                  validator: formValidators.nonNull(),
                  onSaved: (p) => _selectedProduct = p,
                ),
                AppIntegerFormField(
                  labelText: "Kiekis",
                  suffixText: "g",
                  validator: formValidators.numRangeValidator(1, 10000),
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
                  validator: formValidators.nonNull(),
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
