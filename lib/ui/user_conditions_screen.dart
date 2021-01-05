import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/forms/form_validators.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog_api_client/model/chronic_kidney_disease.dart';
import 'package:nephrolog_api_client/model/chronic_kidney_disease_stage.dart';
import 'package:nephrolog_api_client/model/diabetes.dart';
import 'package:nephrolog_api_client/model/diabetes_type.dart';
import 'package:nephrolog_api_client/model/dialysis_type.dart';
import 'package:nephrolog_api_client/model/gender.dart';
import 'package:nephrolog_api_client/model/user_profile.dart';

import 'forms/forms.dart';
import 'general/progress_indicator.dart';

class UserConditionsScreen extends StatefulWidget {
  @override
  _UserConditionsScreenState createState() => _UserConditionsScreenState();
}

class _UserConditionsScreenState extends State<UserConditionsScreen> {
  static final _birthdayFormat = DateFormat.yMd();

  final _formKey = GlobalKey<FormState>();

  final _apiService = ApiService();

  UserProfileBuilder _userProfileBuilder;
  ChronicKidneyDiseaseBuilder _chronicKidneyDiseaseBuilder;
  DiabetesBuilder _diabetesBuilder;

  bool isDiabetic = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _userProfileBuilder = UserProfileBuilder();
    _chronicKidneyDiseaseBuilder = _userProfileBuilder.chronicKidneyDisease;
    _diabetesBuilder = _userProfileBuilder.diabetes;
  }

  @override
  Widget build(BuildContext context) {
    final formValidators = FormValidators(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Mano būklė"),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton.extended(
          onPressed: () => validateAndSaveUserProfile(context),
          label: Text("IŠSAUGOTI"),
          icon: Icon(Icons.save),
        );
      }),
      body: _buildBody(formValidators),
    );
  }

  Widget _buildBody(FormValidators formValidators) {
    return Visibility(
      visible: !isLoading,
      replacement: Center(
        child: AppProgressIndicator(),
      ),
      maintainState: true,
      child: Form(
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
                AppSelectFormField<Gender>(
                  labelText: "Lytis",
                  validator: formValidators.nonNull(),
                  onSaved: (v) => _userProfileBuilder.gender = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: "Vyras",
                      value: Gender.male,
                    ),
                    AppSelectFormFieldItem(
                      text: "Moteris",
                      value: Gender.female,
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
                  validator: formValidators.nonNull(),
                  onDateSaved: (date) =>
                      _userProfileBuilder.birthday = date.toDate(),
                ),
                AppIntegerFormField(
                  labelText: "Ūgis",
                  validator: formValidators.numRangeValidator(100, 250),
                  suffixText: "cm",
                  onSaved: (v) => _userProfileBuilder.heightCm = v,
                ),
                AppDoubleInputField(
                  labelText: "Svoris",
                  validator: formValidators.numRangeValidator(25, 250),
                  helperText:
                      "Jeigu atliekate dializes, įrašykite savo sausąjį svorį",
                  suffixText: "kg",
                  onSaved: (v) => _userProfileBuilder.weightKg = v.toInt(),
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
                  validator: formValidators.numRangeValidator(0, 100),
                  onSaved: (v) => _chronicKidneyDiseaseBuilder.age = v,
                ),
                AppSelectFormField<ChronicKidneyDiseaseStage>(
                  labelText: "Lėtinės inkstų ligos stadija",
                  helperText: "GFG – glomerulų filtracijos greitis",
                  onSaved: (v) => _chronicKidneyDiseaseBuilder.stage = v.value,
                  validator: formValidators.nonNull(),
                  items: [
                    AppSelectFormFieldItem(
                      text: "I – GFG > 90 ml/min./1,73 m²",
                      value: ChronicKidneyDiseaseStage.stage1,
                    ),
                    AppSelectFormFieldItem(
                      text: "II – GFG 89 – 60 ml/min./1,73 m²",
                      value: ChronicKidneyDiseaseStage.stage2,
                    ),
                    AppSelectFormFieldItem(
                      text: "III – GFG 59 – 30 ml/min./1,73 m²",
                      value: ChronicKidneyDiseaseStage.stage3,
                    ),
                    AppSelectFormFieldItem(
                      text: "IV – GFG 29 – 15 ml/min./1,73 m²",
                      value: ChronicKidneyDiseaseStage.stage4,
                    ),
                    AppSelectFormFieldItem(
                      text: "V – GFG < 15 ml/min./1,73 m²",
                      value: ChronicKidneyDiseaseStage.stage5,
                    ),
                    AppSelectFormFieldItem(
                      text: "Nežinau",
                      value: ChronicKidneyDiseaseStage.unknown,
                    ),
                  ],
                ),
                AppSelectFormField<DialysisType>(
                  labelText: "Atliekamos dializės tipas",
                  validator: formValidators.nonNull(),
                  onSaved: (v) =>
                      _chronicKidneyDiseaseBuilder.dialysisType = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: "Peritoninė dializė",
                      value: DialysisType.periotonicDialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: "Hemodializė",
                      value: DialysisType.hemodialysis,
                    ),
                    AppSelectFormFieldItem(
                      text: "Neatlieku, esu po inksto transplantacijos",
                      description: "Praėjo daugiau 6 savaitės",
                      value: DialysisType.postTransplant,
                    ),
                    AppSelectFormFieldItem(
                      text: "Neatlieku",
                      value: DialysisType.notPerformed,
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
                AppSelectFormField<DiabetesType>(
                  labelText: "Cukriniu diabeto tipas",
                  validator: formValidators.nonNull(),
                  initialValue: DiabetesType.unknown,
                  onChanged: (item) {
                    setState(() {
                      isDiabetic = item.value != DiabetesType.unknown;
                    });
                  },
                  onSaved: (v) => _diabetesBuilder.type = v.value,
                  items: [
                    AppSelectFormFieldItem(
                      text: "1 tipo",
                      value: DiabetesType.type1,
                    ),
                    AppSelectFormFieldItem(
                      text: "2 tipo",
                      value: DiabetesType.type1,
                    ),
                    AppSelectFormFieldItem(
                      text: "Nesergu",
                      value: DiabetesType.unknown,
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
                            ? formValidators.numRangeValidator(0, 100)
                            : null,
                        suffixText: "m.",
                        onSaved: (v) => print(v),
                      ),
                      AppSelectFormField<String>(
                        labelText:
                            "Ar jums pasireiškė cukrinio diabeto komplikacijos?",
                        onChanged: (value) {},
                        validator: isDiabetic ? formValidators.nonNull() : null,
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

  Future<UserProfile> _saveUserProfile() async {
    _formKey.currentState.save();

    final userProfile = _userProfileBuilder.build();

    return await _apiService.setUserProfile(userProfile);
  }

  Future validateAndSaveUserProfile(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return null;
    }

    UserProfile userProfile;

    try {
      setState(() {
        isLoading = true;
      });

      userProfile = await _saveUserProfile();
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(ex.toString())));

      return null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    Navigator.pop(context, userProfile);
  }
}
