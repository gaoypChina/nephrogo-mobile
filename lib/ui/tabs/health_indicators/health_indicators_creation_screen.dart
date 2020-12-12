import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/ui/general/components.dart';
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
                  showDividers: false,
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
                  showDividers: false,
                  children: [
                    AppDoubleInputField(
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
                    AppDoubleInputField(
                      labelText: "Gliukozės koncentracija kraujyje",
                      suffixText: "mmol/l",
                      onSaved: (value) {},
                    ),
                  ],
                ),
                SmallSection(
                  title: "Patinimai",
                  setLeftPadding: true,
                  showDividers: false,
                  children: [
                    AppSelectFormField<int>(
                      labelText: "Patinimų sunkumas",
                      helperText:
                          "Patinimą tikrinkite švelniai pirštais paspausdami odą blauzdos priekyje ant kaulo.",
                      items: [
                        AppSelectFormFieldItem(
                          text: "0+",
                          description: "Nesusidaro duobutė",
                          icon: Icons.sentiment_very_satisfied,
                          value: 0,
                        ),
                        AppSelectFormFieldItem(
                          text: "1+",
                          description:
                              "Susidaro negili apie 2 mm duobutė, kuri "
                              "atkėlus pirštus tuoj pat išnyksta.",
                          icon: Icons.sentiment_satisfied,
                          value: 1,
                        ),
                        AppSelectFormFieldItem(
                          text: "2+",
                          description: "Susidaro apie 4 mm duobutė, kuri "
                              "išnyksta po 10-15 sekundžių.",
                          icon: Icons.sentiment_dissatisfied,
                          value: 2,
                        ),
                        AppSelectFormFieldItem(
                          text: "3+",
                          description: "Susidaro apie 6 mm duobutė, kuri "
                              "išnyksta po 1 minutės.",
                          icon: Icons.sentiment_very_dissatisfied,
                          value: 3,
                        ),
                        AppSelectFormFieldItem(
                          text: "4+",
                          description: "Susidaro apie 8 mm duobutė, kuri "
                              "išnyksta po 2 minučių.",
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
                  showDividers: false,
                  setLeftPadding: true,
                  children: [
                    AppSelectFormField<int>(
                      labelText: "Savijauta",
                      items: [
                        AppSelectFormFieldItem(
                          text: "Puiki",
                          icon: Icons.sentiment_very_satisfied,
                          value: 0,
                        ),
                        AppSelectFormFieldItem(
                          text: "Gera",
                          icon: Icons.sentiment_satisfied,
                          value: 1,
                        ),
                        AppSelectFormFieldItem(
                          text: "Vidutinė",
                          icon: Icons.sentiment_dissatisfied,
                          value: 2,
                        ),
                        AppSelectFormFieldItem(
                          text: "Bloga",
                          icon: Icons.sentiment_very_dissatisfied,
                          value: 3,
                        ),
                        AppSelectFormFieldItem(
                          text: "Labai bloga",
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
                          icon: Icons.sentiment_very_satisfied,
                          value: 0,
                        ),
                        AppSelectFormFieldItem(
                          text: "Geras",
                          icon: Icons.sentiment_satisfied,
                          value: 1,
                        ),
                        AppSelectFormFieldItem(
                          text: "Vidutinis",
                          icon: Icons.sentiment_dissatisfied,
                          value: 2,
                        ),
                        AppSelectFormFieldItem(
                          text: "Blogas",
                          icon: Icons.sentiment_very_dissatisfied,
                          value: 3,
                        ),
                        AppSelectFormFieldItem(
                          text: "Labai blogas",
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
                          icon: Icons.sentiment_very_satisfied,
                          value: 0,
                        ),
                        AppSelectFormFieldItem(
                          text: "Lengvas",
                          description: "Dūstama esant labai dideliam fiziniam "
                              "krūviui, uždūstama nuėjus vidutiniu greičiu be "
                              "sustojimo iki 500 m. arba užlipus į 5 aukštą.",
                          icon: Icons.sentiment_satisfied,
                          value: 1,
                        ),
                        AppSelectFormFieldItem(
                          text: "Vidutinis",
                          description: "Dūstama esant vidutiniam fiziniam "
                              "krūviui, uždūstama nuėjus vidutiniu greičiu be "
                              "sustojimo iki 200 m. arba užlipus į 3-4 aukštą.",
                          icon: Icons.sentiment_dissatisfied,
                          value: 2,
                        ),
                        AppSelectFormFieldItem(
                          text: "Sunkus",
                          description: "Dūstama esant mažam fiziniam krūviui, "
                              "uždūstama nuėjus vidutiniu greičiu be sustojimo "
                              "iki 100 m. arba užlipus į 2 aukštą.",
                          icon: Icons.sentiment_very_dissatisfied,
                          value: 3,
                        ),
                        AppSelectFormFieldItem(
                          text: "Labai sunkus",
                          description: "Dūstama esant labai mažam fiziniam "
                              "krūviui (atsikėlus iš lovos, apsirengus, "
                              "nusiprausus, pavaikščiojus po kambarį) ir ramybėje.",
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
