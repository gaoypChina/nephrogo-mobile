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
                      AppSelectFormField<int>(
                        labelText: "Patinimų sunkumas",
                        items: [
                          AppSelectFormFieldItem(
                            title: "0+",
                            description: "TODO",
                            icon: Icons.sentiment_very_satisfied,
                            value: 0,
                          ),
                          AppSelectFormFieldItem(
                            title: "1+",
                            description: "TODO",
                            icon: Icons.sentiment_satisfied,
                            value: 1,
                          ),
                          AppSelectFormFieldItem(
                            title: "2+",
                            description: "TODO",
                            icon: Icons.sentiment_dissatisfied,
                            value: 2,
                          ),
                          AppSelectFormFieldItem(
                            title: "3+",
                            description: "TODO",
                            icon: Icons.sentiment_very_dissatisfied,
                            value: 3,
                          ),
                          AppSelectFormFieldItem(
                            title: "4+",
                            description: "TODO",
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
                  title: "Savijauta",
                  setLeftPadding: true,
                  child: Column(
                    children: [
                      AppSelectFormField<int>(
                        labelText: "Savijauta",
                        items: [
                          AppSelectFormFieldItem(
                            title: "Puiki",
                            description: "TODO description",
                            icon: Icons.sentiment_very_satisfied,
                            value: 0,
                          ),
                          AppSelectFormFieldItem(
                            title: "Gera",
                            description: "TODO description",
                            icon: Icons.sentiment_satisfied,
                            value: 1,
                          ),
                          AppSelectFormFieldItem(
                            title: "Vidutinė",
                            description: "TODO description",
                            icon: Icons.sentiment_dissatisfied,
                            value: 2,
                          ),
                          AppSelectFormFieldItem(
                            title: "Bloga",
                            description: "TODO description",
                            icon: Icons.sentiment_very_dissatisfied,
                            value: 3,
                          ),
                          AppSelectFormFieldItem(
                            title: "Labai bloga",
                            description: "TODO description",
                            icon: Icons.sick,
                            value: 4,
                          ),
                        ],
                      ),
                      AppSelectFormField<int>(
                        labelText: "Apetitas",
                        items: [
                          AppSelectFormFieldItem(
                            title: "Puikus",
                            description: "TODO description",
                            icon: Icons.sentiment_very_satisfied,
                            value: 0,
                          ),
                          AppSelectFormFieldItem(
                            title: "Geras",
                            description: "TODO description",
                            icon: Icons.sentiment_satisfied,
                            value: 1,
                          ),
                          AppSelectFormFieldItem(
                            title: "Vidutinis",
                            description: "TODO description",
                            icon: Icons.sentiment_dissatisfied,
                            value: 2,
                          ),
                          AppSelectFormFieldItem(
                            title: "Blogas",
                            description: "TODO description",
                            icon: Icons.sentiment_very_dissatisfied,
                            value: 3,
                          ),
                          AppSelectFormFieldItem(
                            title: "Labai blogas",
                            description: "TODO description",
                            icon: Icons.sick,
                            value: 4,
                          ),
                        ],
                      ),
                      AppSelectFormField<int>(
                        labelText: "Dusulys",
                        items: [
                          AppSelectFormFieldItem(
                            title: "Nėra",
                            description: "TODO description",
                            icon: Icons.sentiment_very_satisfied,
                            value: 0,
                          ),
                          AppSelectFormFieldItem(
                            title: "Lengvas",
                            description: "TODO description",
                            icon: Icons.sentiment_satisfied,
                            value: 1,
                          ),
                          AppSelectFormFieldItem(
                            title: "Vidutinis",
                            description: "TODO description",
                            icon: Icons.sentiment_dissatisfied,
                            value: 2,
                          ),
                          AppSelectFormFieldItem(
                            title: "Sunkus",
                            description: "TODO description",
                            icon: Icons.sentiment_very_dissatisfied,
                            value: 3,
                          ),
                          AppSelectFormFieldItem(
                            title: "Labai sunkus",
                            description: "TODO description",
                            icon: Icons.sick,
                            value: 4,
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
