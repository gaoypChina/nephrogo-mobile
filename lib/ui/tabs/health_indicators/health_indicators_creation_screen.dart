import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/ui/components.dart';
import 'package:nephrolog/ui/forms/forms.dart';

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
                SmallSection(
                  title: "Bendra informacija",
                  setLeftPadding: true,
                  children: [
                    AppFloatInputField(
                      labelText: "Kūno svoris",
                      suffixText: "kg",
                      helperText:
                          "Jeigu atliekate dializes, įrašykite savo sausąjį svorį",
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
                    // TODO rodyti tik cukraligei
                    // mmol/l  - milimoliais litre, norma 3,33 - 5,55
                    AppFloatInputField(
                      labelText: "Gliukozės koncentracija kraujyje",
                      suffixText: "mmol/l",
                      onSaved: (value) {},
                    ),
                  ],
                ),
                SmallSection(
                  title: "Patinimai",
                  setLeftPadding: true,
                  children: [
                    AppSelectFormField<int>(
                      labelText: "Patinimų sunkumas",
                      items: [
                        AppSelectFormFieldItem(
                          text: "0+",
                          description: "TODO",
                          icon: Icons.sentiment_very_satisfied,
                          value: 0,
                        ),
                        AppSelectFormFieldItem(
                          text: "1+",
                          description: "TODO",
                          icon: Icons.sentiment_satisfied,
                          value: 1,
                        ),
                        AppSelectFormFieldItem(
                          text: "2+",
                          description: "TODO",
                          icon: Icons.sentiment_dissatisfied,
                          value: 2,
                        ),
                        AppSelectFormFieldItem(
                          text: "3+",
                          description: "TODO",
                          icon: Icons.sentiment_very_dissatisfied,
                          value: 3,
                        ),
                        AppSelectFormFieldItem(
                          text: "4+",
                          description: "TODO",
                          icon: Icons.sick,
                          value: 4,
                        ),
                      ],
                    ),
                    AppMultipleSelectFormField<String>(
                      labelText: "Patinimų lokalizacija",
                      onChanged: (value) {},
                      items: [
                        AppSelectFormFieldItem(
                          text: "Paakiai",
                          value: "1",
                        ),
                        AppSelectFormFieldItem(
                          text: "Visas veidas",
                          value: "2",
                        ),
                        AppSelectFormFieldItem(
                          text: "Plaštakos",
                          value: "3",
                        ),
                        AppSelectFormFieldItem(
                          text: "Visos rankos",
                          value: "4",
                        ),
                        AppSelectFormFieldItem(
                          text: "Pilvas",
                          value: "5",
                        ),
                        AppSelectFormFieldItem(
                          text: "Keliai",
                          value: "6",
                        ),
                        AppSelectFormFieldItem(
                          text: "Pėdos",
                          value: "7",
                        ),
                        AppSelectFormFieldItem(
                          text: "Visos kojos",
                          value: "8",
                        ),
                      ],
                    ),
                  ],
                ),
                SmallSection(
                  title: "Savijauta",
                  setLeftPadding: true,
                  children: [
                    AppSelectFormField<int>(
                      labelText: "Savijauta",
                      items: [
                        AppSelectFormFieldItem(
                          text: "Puiki",
                          description: "TODO description",
                          icon: Icons.sentiment_very_satisfied,
                          value: 0,
                        ),
                        AppSelectFormFieldItem(
                          text: "Gera",
                          description: "TODO description",
                          icon: Icons.sentiment_satisfied,
                          value: 1,
                        ),
                        AppSelectFormFieldItem(
                          text: "Vidutinė",
                          description: "TODO description",
                          icon: Icons.sentiment_dissatisfied,
                          value: 2,
                        ),
                        AppSelectFormFieldItem(
                          text: "Bloga",
                          description: "TODO description",
                          icon: Icons.sentiment_very_dissatisfied,
                          value: 3,
                        ),
                        AppSelectFormFieldItem(
                          text: "Labai bloga",
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
                          text: "Puikus",
                          description: "TODO description",
                          icon: Icons.sentiment_very_satisfied,
                          value: 0,
                        ),
                        AppSelectFormFieldItem(
                          text: "Geras",
                          description: "TODO description",
                          icon: Icons.sentiment_satisfied,
                          value: 1,
                        ),
                        AppSelectFormFieldItem(
                          text: "Vidutinis",
                          description: "TODO description",
                          icon: Icons.sentiment_dissatisfied,
                          value: 2,
                        ),
                        AppSelectFormFieldItem(
                          text: "Blogas",
                          description: "TODO description",
                          icon: Icons.sentiment_very_dissatisfied,
                          value: 3,
                        ),
                        AppSelectFormFieldItem(
                          text: "Labai blogas",
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
                          text: "Nėra",
                          description: "TODO description",
                          icon: Icons.sentiment_very_satisfied,
                          value: 0,
                        ),
                        AppSelectFormFieldItem(
                          text: "Lengvas",
                          description: "TODO description",
                          icon: Icons.sentiment_satisfied,
                          value: 1,
                        ),
                        AppSelectFormFieldItem(
                          text: "Vidutinis",
                          description: "TODO description",
                          icon: Icons.sentiment_dissatisfied,
                          value: 2,
                        ),
                        AppSelectFormFieldItem(
                          text: "Sunkus",
                          description: "TODO description",
                          icon: Icons.sentiment_very_dissatisfied,
                          value: 3,
                        ),
                        AppSelectFormFieldItem(
                          text: "Labai sunkus",
                          description: "TODO description",
                          icon: Icons.sick,
                          value: 4,
                        ),
                      ],
                    ),
                  ],
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
