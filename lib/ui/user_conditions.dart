import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/ui/components.dart';

import 'forms/forms.dart';

class UserConditionsScreen extends StatefulWidget {
  @override
  _UserConditionsScreenState createState() => _UserConditionsScreenState();
}

class _UserConditionsScreenState extends State<UserConditionsScreen> {
  static final _birthdayFormat = DateFormat.yMd();

  final _formKey = GlobalKey<FormState>();

  bool isDiabetic = false;

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
            bottom: 80,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SmallSection(
                  title: "Bendra informacija",
                  setLeftPadding: true,
                  child: Column(
                    children: [
                      AppSelectFormField<int>(
                        labelText: "Lytis",
                        onChanged: (v) {},
                        items: [
                          AppSelectFormFieldItem(
                            text: "Vyras",
                            value: 0,
                          ),
                          AppSelectFormFieldItem(
                            text: "Moteris",
                            value: 1,
                          ),
                        ],
                      ),
                      AppDatePickerFormField(
                        labelText: "Gimimo data",
                        firstDate: DateTime(1920),
                        lastDate: DateTime.now(),
                        initialDate: DateTime(1995, 6, 26),
                        initialDatePickerMode: DatePickerMode.year,
                        initialEntryMode: DatePickerEntryMode.input,
                        dateFormat: _birthdayFormat,
                        onDateSaved: (v) => print(v),
                      ),
                      AppIntegerFormField(
                        labelText: "Ūgis",
                        suffixText: "cm",
                        onSaved: (v) => print(v),
                      ),
                      AppFloatInputField(
                        labelText: "Svoris",
                        helperText:
                            "Jeigu atliekate dializes, įrašykite savo sausąjį svorį",
                        suffixText: "kg",
                        onSaved: (v) => print(v),
                      ),
                    ],
                  ),
                ),
                SmallSection(
                  title: "Lėtinė inkstų liga",
                  setLeftPadding: true,
                  child: Column(
                    children: [
                      AppIntegerFormField(
                        labelText: "Kiek metų sergate lėtine inkstų liga",
                        onSaved: (v) => print(v),
                      ),
                      AppSelectFormField<String>(
                        labelText: "Lėtinės inkstų ligos stadija",
                        helperText: "GFG – glomerulų filtracijos greitis",
                        onChanged: (value) {},
                        items: [
                          AppSelectFormFieldItem(
                            text: "I – GFG > 90 ml/min./1,73 m²",
                            value: "1",
                          ),
                          AppSelectFormFieldItem(
                            text: "II – GFG 89 – 60 ml/min./1,73 m²",
                            value: "2",
                          ),
                          AppSelectFormFieldItem(
                            text: "III – GFG 59 – 30 ml/min./1,73 m²",
                            value: "3",
                          ),
                          AppSelectFormFieldItem(
                            text: "IV – GFG 29 – 15 ml/min./1,73 m²",
                            value: "4",
                          ),
                          AppSelectFormFieldItem(
                            text: "V – GFG < 15 ml/min./1,73 m²",
                            value: "5",
                          ),
                          AppSelectFormFieldItem(text: "Nežinau", value: "6"),
                        ],
                      ),
                      AppSelectFormField<String>(
                        labelText: "Atliekamos dializės tipas",
                        onChanged: (value) {},
                        items: [
                          AppSelectFormFieldItem(
                            text: "Peritoninė dializė",
                            value: "1",
                          ),
                          AppSelectFormFieldItem(
                            text: "Hemodializė",
                            value: "2",
                          ),
                          AppSelectFormFieldItem(
                            text: "Neatlieku, esu po inksto transplantacijos",
                            description: "Praėjo daugiau 6 savaitės¬",
                            value: "3",
                          ),
                          AppSelectFormFieldItem(
                            text: "Neatlieku",
                            value: "4",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SmallSection(
                  title: "Cukrinis diabetas",
                  setLeftPadding: true,
                  child: Column(
                    children: [
                      AppSelectFormField<String>(
                        labelText: "Cukriniu diabeto tipas",
                        initialValue: "3",
                        onChanged: (item) {
                          setState(() {
                            isDiabetic = item.value != "3";
                          });
                        },
                        items: [
                          AppSelectFormFieldItem(
                            text: "1 tipo",
                            value: "1",
                          ),
                          AppSelectFormFieldItem(
                            text: "2 tipo",
                            value: "2",
                          ),
                          AppSelectFormFieldItem(
                            text: "Nesergu",
                            value: "3",
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isDiabetic,
                        child: Column(
                          children: [
                            AppIntegerFormField(
                              labelText: "Kiek metų sergate cukriniu diabetu",
                              suffixText: "m.",
                              onSaved: (v) => print(v),
                            ),
                            AppSelectFormField<String>(
                              labelText:
                                  "Ar jums pasireiškė cukrinio diabeto komplikacijos?",
                              onChanged: (value) {},
                              items: [
                                AppSelectFormFieldItem(
                                  text: "Taip",
                                  value: "1",
                                ),
                                AppSelectFormFieldItem(
                                  text: "Ne",
                                  value: "2",
                                ),
                                AppSelectFormFieldItem(
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
