import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/ui/components.dart';
import 'package:nephrolog/ui/forms.dart';

class HealthIndicatorsCreationScreen extends StatefulWidget {
  @override
  _HealthIndicatorsCreationScreenState createState() =>
      _HealthIndicatorsCreationScreenState();
}

class _HealthIndicatorsCreationScreenState
    extends State<HealthIndicatorsCreationScreen> {
  final _dateFormat = DateFormat.yMMMMEEEEd();

  final _formKey = GlobalKey<FormState>();

  int _systolicBloodPressure;
  int _diastolicBloodPressure;
  double _weight;
  int _urineMl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Šiandienos sveikatos rodikliai"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => validateAndSaveHealthIndicators(context),
        label: Text("IŠSAUGOTI"),
        icon: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 64),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SmallSection(
                  title: "Kraujo spaudimas",
                  setLeftPadding: true,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: AppIntegerFormField(
                              labelText: "Sistolinis",
                              suffixText: "mmHg",
                              onSaved: (value) {
                                _systolicBloodPressure = value;
                              },
                            ),
                          ),
                          Flexible(
                            child: AppIntegerFormField(
                              labelText: "Diastolinis",
                              suffixText: "mmHg",
                              onSaved: (value) {
                                _diastolicBloodPressure = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Jei vartojate kraujo spaudimą reguliuojančius vaistus, "
                          "kraujo spaudimą matuokite tik po vaistų suvartojimo!",
                        ),
                      ),
                    ],
                  ),
                ),
                SmallSection(
                  title: "Bendra informacija",
                  setLeftPadding: true,
                  child: Column(
                    children: [
                      AppIntegerFormField(
                        labelText: "Kūno svoris",
                        suffixText: "kg",
                        onSaved: (value) {
                          _weight = value.toDouble();
                        },
                      ),
                      AppIntegerFormField(
                        labelText: "Šlapimo kiekis",
                        suffixText: "ml",
                        onSaved: (value) {
                          _urineMl = value;
                        },
                      ),
                    ],
                  ),
                ),
                SmallSection(
                  title: "Patinimai",
                  setLeftPadding: true,
                  child: Column(
                    children: [
                      AppSelectFormField(
                        labelText: "Patinimų sunkumas",
                        onChanged: (int value) {
                          print(value);
                          print(value.runtimeType);
                        },
                        items: [
                          AppSelectFormFieldItem(
                            title: "0+",
                            description: "TODO",
                            icon: Icons.sentiment_very_satisfied,
                            value: 0,
                          ),
                          AppSelectFormFieldItem(
                            title: "1+",
                            icon: Icons.sentiment_satisfied,
                            value: 1,
                          ),
                          AppSelectFormFieldItem(
                            title: "2+",
                            icon: Icons.sentiment_dissatisfied,
                            value: 2,
                          ),
                          AppSelectFormFieldItem(
                            title: "3+",
                            icon: Icons.sentiment_very_dissatisfied,
                            value: 3,
                          ),
                          AppSelectFormFieldItem(
                            title: "4+",
                            icon: Icons.sick,
                            value: 4,
                          ),
                        ],
                      ),
                      AppDropdownButtonFormField(
                        labelText: "Patinimų lokalizacija",
                        onChanged: (value) {},
                        items: [
                          AppDropdownMenuItem(
                            text: "Paakiai",
                            value: "1",
                          ),
                          AppDropdownMenuItem(
                            text: "Visas veidas",
                            value: "2",
                          ),
                          AppDropdownMenuItem(
                            text: "Plaštakos",
                            value: "3",
                          ),
                          AppDropdownMenuItem(
                            text: "Visos rankos",
                            value: "4",
                          ),
                          AppDropdownMenuItem(
                            text: "Pilvas",
                            value: "5",
                          ),
                          AppDropdownMenuItem(
                            text: "Keliai",
                            value: "6",
                          ),
                          AppDropdownMenuItem(
                            text: "Pėdos",
                            value: "7",
                          ),
                          AppDropdownMenuItem(
                            text: "Visos kojos",
                            value: "8",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SmallSection(
                  title: "Dabartinė būsena",
                  setLeftPadding: true,
                  child: Column(
                    children: [
                      AppDropdownButtonFormField(
                        labelText: "Savijauta",
                        onChanged: (value) {},
                        items: [
                          AppDropdownMenuItem(
                            text: "Puiki",
                            value: "1",
                          ),
                          AppDropdownMenuItem(
                            text: "Gera",
                            value: "2",
                          ),
                          AppDropdownMenuItem(
                            text: "Vidutinė",
                            value: "3",
                          ),
                          AppDropdownMenuItem(
                            text: "Bloga",
                            value: "4",
                          ),
                          AppDropdownMenuItem(
                            text: "Labai bloga",
                            value: "5",
                          ),
                        ],
                      ),
                      AppDropdownButtonFormField(
                        labelText: "Apetitas",
                        onChanged: (value) {},
                        items: [
                          AppDropdownMenuItem(
                            text: "Puikus",
                            value: "1",
                          ),
                          AppDropdownMenuItem(
                            text: "Geras",
                            value: "2",
                          ),
                          AppDropdownMenuItem(
                            text: "Vidutinis",
                            value: "3",
                          ),
                          AppDropdownMenuItem(
                            text: "Prastas",
                            value: "4",
                          ),
                          AppDropdownMenuItem(
                            text: "Labai prastas",
                            value: "5",
                          ),
                        ],
                      ),
                      AppDropdownButtonFormField(
                        labelText: "Dusulys",
                        onChanged: (value) {},
                        items: [
                          AppDropdownMenuItem(
                            text: "Nėra",
                            value: "1",
                          ),
                          AppDropdownMenuItem(
                            text: "Lengvas",
                            value: "2",
                          ),
                          AppDropdownMenuItem(
                            text: "Vidutinis",
                            value: "3",
                          ),
                          AppDropdownMenuItem(
                            text: "Sunkus",
                            value: "4",
                          ),
                          AppDropdownMenuItem(
                            text: "Labai sunkus",
                            value: "5",
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

  validateAndSaveHealthIndicators(BuildContext context) {}
}
