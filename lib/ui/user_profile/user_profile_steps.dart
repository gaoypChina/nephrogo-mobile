import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

abstract class UserProfileStep {
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder userProfileBuilder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  );

  bool validate(
    UserProfileV2RequestBuilder userProfileBuilder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  );

  Future<void> save() async {}
}

class GenderStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  ) {
    return SingleChildScrollView(
      child: LargeSection(
        title: Text(context.appLocalizations.gender),
        children: [
          AppRadioListTile<GenderEnum>(
            title: Text(context.appLocalizations.male),
            value: GenderEnum.male,
            groupValue: builder.gender,
            onChanged: (g) => _onGenderSelected(builder, g, setState),
          ),
          AppRadioListTile<GenderEnum>(
            title: Text(context.appLocalizations.female),
            value: GenderEnum.female,
            groupValue: builder.gender,
            onChanged: (g) => _onGenderSelected(builder, g, setState),
          ),
        ],
      ),
    );
  }

  void _onGenderSelected(
    UserProfileV2RequestBuilder builder,
    GenderEnum? gender,
    void Function(VoidCallback fn) setState,
  ) {
    setState(() {
      builder.gender = gender;
    });
  }

  @override
  bool validate(
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  ) {
    return builder.gender != null;
  }
}

class BirthdayStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  ) {
    return SingleChildScrollView(
      child: LargeSection(
        title: Text(context.appLocalizations.dateOfBirth),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppDatePickerFormField(
              firstDate: Date(1900, 1, 1),
              lastDate: Date.now(),
              initialDate: builder.dateOfBirth ?? Date(1995, 1, 1),
              selectedDate: builder.dateOfBirth,
              initialDatePickerMode: DatePickerMode.year,
              initialEntryMode: DatePickerEntryMode.input,
              labelText: context.appLocalizations.dateOfBirth,
              onDateChanged: (d) => builder.dateOfBirth = d,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool validate(
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  ) {
    return builder.dateOfBirth != null;
  }
}

class HeightStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  ) {
    return SingleChildScrollView(
      child: LargeSection(
        title: Text(context.appLocalizations.height),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppIntegerFormField(
              labelText: context.appLocalizations.height,
              autoFocus: builder.heightCm == null,
              initialValue: builder.heightCm,
              suffixText: 'cm',
              textInputAction: TextInputAction.done,
              validator: FormValidators(context).numRangeValidator(15, 250),
              onChanged: (height) {
                builder.heightCm = height;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool validate(
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  ) {
    final heightCm = builder.heightCm;

    return heightCm != null && heightCm >= 15 && heightCm <= 250;
  }
}

class WeightStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  ) {
    return SingleChildScrollView(
      child: LargeSection(
        title: Text(context.appLocalizations.weight),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppDoubleInputField(
              labelText: context.appLocalizations.weight,
              autoFocus: true,
              fractionDigits: 1,
              suffixText: 'kg',
              textInputAction: TextInputAction.done,
              helperText: context.appLocalizations.userProfileWeightHelper,
              validator: FormValidators(context).numRangeValidator(1.0, 300.0),
              onChanged: (w) {
                healthStatusBuilder.date = Date.now(utc: true);
                healthStatusBuilder.weightKg = w;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool validate(
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  ) {
    final weightKg = healthStatusBuilder.weightKg;

    return weightKg != null && weightKg <= 300 && weightKg >= 1;
  }
}

class ChronicKidneyDiseaseAgeStep extends UserProfileStep {
  static const _intervals = <ChronicKidneyDiseaseAgeEnum>[
    ChronicKidneyDiseaseAgeEnum.lessThan1,
    ChronicKidneyDiseaseAgeEnum.n15,
    ChronicKidneyDiseaseAgeEnum.n610,
    ChronicKidneyDiseaseAgeEnum.greaterThan10,
  ];

  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(
          appLocalizations.userProfileSectionChronicKidneyDiseaseAge,
        ),
        children: [
          for (final interval in _intervals)
            AppRadioListTile<ChronicKidneyDiseaseAgeEnum>(
              title: Text(interval.title(appLocalizations)),
              value: interval,
              groupValue: builder.chronicKidneyDiseaseAge,
              onChanged: (s) {
                setState(() => builder.chronicKidneyDiseaseAge = s);
              },
            ),
        ],
      ),
    );
  }

  @override
  bool validate(
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  ) {
    return builder.chronicKidneyDiseaseAge != null &&
        builder.chronicKidneyDiseaseAge != ChronicKidneyDiseaseAgeEnum.unknown;
  }
}

class ChronicKidneyDiseaseStageStep extends UserProfileStep {
  static const _stages = <ChronicKidneyDiseaseStageEnum>[
    ChronicKidneyDiseaseStageEnum.stage1,
    ChronicKidneyDiseaseStageEnum.stage2,
    ChronicKidneyDiseaseStageEnum.stage3,
    ChronicKidneyDiseaseStageEnum.stage4,
    ChronicKidneyDiseaseStageEnum.stage5,
    ChronicKidneyDiseaseStageEnum.unknown,
  ];

  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(
          appLocalizations.userProfileSectionChronicKidneyDiseaseStage,
        ),
        subtitle: Text(
          appLocalizations.userProfileSectionChronicKidneyDiseaseStageHelper,
        ),
        children: [
          for (final stage in _stages)
            AppRadioListTile<ChronicKidneyDiseaseStageEnum>(
              title: Text(stage.title(appLocalizations)),
              subtitle: stage.description(appLocalizations)?.let(
                    (t) => Text(t),
                  ),
              value: stage,
              groupValue: builder.chronicKidneyDiseaseStage,
              onChanged: (s) {
                setState(() => builder.chronicKidneyDiseaseStage = stage);
              },
            ),
        ],
      ),
    );
  }

  @override
  bool validate(
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  ) {
    return builder.chronicKidneyDiseaseStage != null;
  }
}

class DialysisStep extends UserProfileStep {
  static const _dialysisSelections = <DialysisEnum>[
    DialysisEnum.manualPeritonealDialysis,
    DialysisEnum.automaticPeritonealDialysis,
    DialysisEnum.hemodialysis,
    DialysisEnum.postTransplant,
    DialysisEnum.notPerformed,
  ];

  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(appLocalizations.userProfileSectionDialysisType),
        children: [
          for (final dialysis in _dialysisSelections)
            AppRadioListTile<DialysisEnum>(
              title: Text(dialysis.title(appLocalizations)),
              subtitle: dialysis.description(appLocalizations)?.let(
                    (v) => Text(v),
                  ),
              value: dialysis,
              groupValue: builder.dialysis,
              onChanged: (s) {
                setState(() {
                  builder.dialysis = s;
                });
              },
            ),
        ],
      ),
    );
  }

  @override
  bool validate(
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  ) {
    return builder.dialysis != null && builder.dialysis != DialysisEnum.unknown;
  }
}

class DiabetesStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(appLocalizations.userProfileSectionDiabetesTitle),
        children: [
          AppRadioListTile<DiabetesTypeEnum>(
            title: Text(appLocalizations.userProfileSectionDiabetesType1),
            value: DiabetesTypeEnum.type1,
            groupValue: builder.diabetesType,
            onChanged: (s) => _onSelected(builder, s, setState),
          ),
          AppRadioListTile<DiabetesTypeEnum>(
            title: Text(appLocalizations.userProfileSectionDiabetesType2),
            value: DiabetesTypeEnum.type2,
            groupValue: builder.diabetesType,
            onChanged: (s) => _onSelected(builder, s, setState),
          ),
          AppRadioListTile<DiabetesTypeEnum>(
            title: Text(appLocalizations.userProfileSectionDiabetesTypeNo),
            value: DiabetesTypeEnum.no,
            groupValue: builder.diabetesType,
            onChanged: (s) => _onSelected(builder, s, setState),
          ),
        ],
      ),
    );
  }

  void _onSelected(
    UserProfileV2RequestBuilder builder,
    DiabetesTypeEnum? type,
    void Function(VoidCallback fn) setState,
  ) {
    setState(() {
      builder.diabetesType = type;
    });
  }

  @override
  bool validate(
    UserProfileV2RequestBuilder builder,
    DailyHealthStatusRequestBuilder healthStatusBuilder,
  ) {
    return builder.diabetesType != null &&
        builder.diabetesType != DiabetesTypeEnum.unknown;
  }
}
