import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/general/components.dart';

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
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: <Widget>[
            SmallSection(
              title: "Bendra informacija",
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppSelectFormField<int>(
                  labelText: "Lytis",
                  validator: FormValidators.nonNull(),
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
                  lastDate: DateTime.now().subtract(Duration(days: 365 * 18)),
                  initialDate: DateTime(1995, 6, 26),
                  initialDatePickerMode: DatePickerMode.year,
                  initialEntryMode: DatePickerEntryMode.input,
                  dateFormat: _birthdayFormat,
                  validator: FormValidators.nonNull(),
                  onDateSaved: (v) => print(v),
                ),
                AppIntegerFormField(
                  labelText: "Ūgis",
                  validator: FormValidators.numRangeValidator(100, 250),
                  suffixText: "cm",
                  onSaved: (v) => print(v),
                ),
                AppDoubleInputField(
                  labelText: "Svoris",
                  validator: FormValidators.numRangeValidator(25, 250),
                  helperText:
                      "Jeigu atliekate dializes, įrašykite savo sausąjį svorį",
                  suffixText: "kg",
                  onSaved: (v) => print(v),
                ),
              ],
            ),
            SmallSection(
              title: "Lėtinė inkstų liga",
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppIntegerFormField(
                  labelText: "Kiek metų sergate lėtine inkstų liga",
                  validator: FormValidators.numRangeValidator(0, 100),
                  onSaved: (v) => print(v),
                ),
                AppSelectFormField<String>(
                  labelText: "Lėtinės inkstų ligos stadija",
                  helperText: "GFG – glomerulų filtracijos greitis",
                  onChanged: (value) {},
                  validator: FormValidators.nonNull(),
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
                  validator: FormValidators.nonNull(),
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
                      description: "Praėjo daugiau 6 savaitės",
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
            SmallSection(
              title: "Cukrinis diabetas",
              setLeftPadding: true,
              showDividers: false,
              children: [
                AppSelectFormField<String>(
                  labelText: "Cukriniu diabeto tipas",
                  validator: FormValidators.nonNull(),
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
                        validator: isDiabetic
                            ? FormValidators.numRangeValidator(0, 100)
                            : null,
                        suffixText: "m.",
                        onSaved: (v) => print(v),
                      ),
                      AppSelectFormField<String>(
                        labelText:
                            "Ar jums pasireiškė cukrinio diabeto komplikacijos?",
                        onChanged: (value) {},
                        validator: isDiabetic ? FormValidators.nonNull() : null,
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
          ],
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
