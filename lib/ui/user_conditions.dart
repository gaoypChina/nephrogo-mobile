import 'package:flutter/material.dart';

import 'forms.dart';

class UserConditionsScreen extends StatefulWidget {
  @override
  _UserConditionsScreenState createState() => _UserConditionsScreenState();
}

class _UserConditionsScreenState extends State<UserConditionsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mano būklė"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => validateAndSaveMeal(context),
        label: Text("IŠSAUGOTI"),
        icon: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 80,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                AppDropdownButtonFormField(
                  labelText: "Lytis",
                  onChanged: (value) {},
                  items: [
                    AppDropdownMenuItem(text: "Vyras", value: "Vyras"),
                    AppDropdownMenuItem(text: "Moteris", value: "Moteris"),
                  ],
                ),
                AppInputDatePickerFormField(
                  labelText: "Gimimo data",
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                  initialDate: null,
                  onDateSaved: (v) => print(v),
                ),
                AppIntegerFormField(
                  labelText: "Ūgis (centimetrais)",
                  suffixText: "cm",
                  onSaved: (v) => print(v),
                ),
                AppIntegerFormField(
                  labelText: "Svoris (kilogramais)",
                  helperText:
                      "Jeigu atliekate dializes, įrašykite savo sausąjį svorį",
                  suffixText: "kg",
                  onSaved: (v) => print(v),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                AppIntegerFormField(
                  labelText: "Kiek metų sergate lėtine inkstų liga",
                  onSaved: (v) => print(v),
                ),
                AppDropdownButtonFormField(
                  labelText: "Lėtinės inkstų ligos stadija",
                  helperText: "GFG – glomerulų filtracijos greitis",
                  onChanged: (value) {},
                  items: [
                    AppDropdownMenuItem(
                      text: "I – GFG > 90 ml/min./1,73 m²",
                      value: "1",
                    ),
                    AppDropdownMenuItem(
                      text: "II – GFG 89 – 60 ml/min./1,73 m²",
                      value: "2",
                    ),
                    AppDropdownMenuItem(
                      text: "III – GFG 59 – 30 ml/min./1,73 m²",
                      value: "3",
                    ),
                    AppDropdownMenuItem(
                      text: "IV – GFG 29 – 15 ml/min./1,73 m²",
                      value: "4",
                    ),
                    AppDropdownMenuItem(
                      text: "V – GFG < 15 ml/min./1,73 m²",
                      value: "5",
                    ),
                    AppDropdownMenuItem(text: "Nežinau", value: "6"),
                  ],
                ),
                AppDropdownButtonFormField(
                  labelText: "Atliekamos dializės tipas",
                  onChanged: (value) {},
                  items: [
                    AppDropdownMenuItem(
                      text: "Peritoninė dializė",
                      value: "1",
                    ),
                    AppDropdownMenuItem(
                      text: "Hemodializė",
                      value: "2",
                    ),
                    AppDropdownMenuItem(
                      text:
                          "Neatlieku, esu po inksto transplantacijos (6 savaitės ir ilgiau)",
                      value: "3",
                    ),
                    AppDropdownMenuItem(
                      text: "Neatlieku",
                      value: "4",
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                AppDropdownButtonFormField(
                  labelText: "Cukriniu diabeto tipas",
                  value: "3",
                  onChanged: (value) {},
                  items: [
                    AppDropdownMenuItem(
                      text: "1 tipo",
                      value: "1",
                    ),
                    AppDropdownMenuItem(
                      text: "2 tipo",
                      value: "2",
                    ),
                    AppDropdownMenuItem(
                      text: "Nesergu",
                      value: "3",
                    ),
                  ],
                ),
                Visibility(
                  child: Column(
                    children: [
                      AppIntegerFormField(
                        labelText: "Kiek metų sergate cukriniu diabetu",
                        suffixText: "m.",
                        onSaved: (v) => print(v),
                      ),
                      AppDropdownButtonFormField(
                        labelText:
                            "Ar jums pasireiškė cukrinio diabeto komplikacijos?",
                        onChanged: (value) {},
                        items: [
                          AppDropdownMenuItem(
                            text: "Taip",
                            value: "1",
                          ),
                          AppDropdownMenuItem(
                            text: "Ne",
                            value: "2",
                          ),
                          AppDropdownMenuItem(
                            text: "Nežinau",
                            value: "3",
                          ),
                        ],
                      ),
                    ],
                  ),
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

    _formKey.currentState.save();

    Navigator.pop(context);
  }
}
