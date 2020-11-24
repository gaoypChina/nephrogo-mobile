import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/DateExtensions.dart';

class MealCreationScreen extends StatefulWidget {
  @override
  _MealCreationScreenState createState() => _MealCreationScreenState();
}

class _MealCreationScreenState extends State<MealCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateFormat = DateFormat.yMMMMEEEEd('lt');
  final _timeFormat = DateFormat.Hm('lt');

  var _mealDate = DateTime.now();
  var _mealTimeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pridėti valgį"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: saveMeal,
        label: Text("IŠSAUGOTI"),
        icon: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.today),
                    onPressed: null,
                  ),
                  title: const Text('Data'),
                  subtitle: Text(_dateFormat.format(_mealDate)),
                  onTap: showMealDatePicker,
                ),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: null,
                  ),
                  title: const Text('Laikas'),
                  subtitle: Text(
                    _timeFormat.format(_mealDate.applied(_mealTimeOfDay)),
                  ),
                  onTap: showMealTimePicker,
                ),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.restaurant_outlined),
                    onPressed: null,
                  ),
                  title: const Text('Valgis'),
                  subtitle: const Text('Lašiša'),
                ),
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.kitchen),
                    onPressed: null,
                  ),
                  title: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Kiekis",
                      helperText: "Kiekis gramais",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Privalomas laukelis';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  saveMeal() {
    if (_formKey.currentState.validate()) {}
  }
}
