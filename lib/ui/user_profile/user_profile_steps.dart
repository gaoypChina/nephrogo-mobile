import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:numberpicker/numberpicker.dart';

abstract class UserProfileStep {
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    void Function(VoidCallback fn) setState,
  );

  bool validate(UserProfileV2RequestBuilder builder);

  Future<void> save() async {}
}

class GenderStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    return SingleChildScrollView(
      child: LargeSection(
        title: Text(context.appLocalizations.gender),
        showDividers: true,
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
  bool validate(UserProfileV2RequestBuilder builder) {
    return builder.gender != null;
  }
}

class HeightStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final height = builder.heightCm ??= _getInitialHeight(builder);

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(context.appLocalizations.height),
        showDividers: true,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return NumberPicker(
                value: height,
                itemWidth: constraints.maxWidth,
                itemHeight: 80,
                minValue: 100,
                maxValue: 250,
                haptics: true,
                textMapper: (s) => '$s cm',
                onChanged: (height) {
                  setState(() => builder.heightCm = height);
                });
          }),
        ],
      ),
    );
  }

  int _getInitialHeight(UserProfileV2RequestBuilder builder) {
    if (builder.gender == GenderEnum.female) {
      return 165;
    }
    return 180;
  }

  @override
  bool validate(UserProfileV2RequestBuilder builder) {
    return true;
  }
}

class ChronicKidneyDiseaseAgeStep extends UserProfileStep {
  static const _invervals = <ChronicKidneyDiseaseAgeEnum>[
    ChronicKidneyDiseaseAgeEnum.lessThan1,
    ChronicKidneyDiseaseAgeEnum.n25,
    ChronicKidneyDiseaseAgeEnum.n610,
    ChronicKidneyDiseaseAgeEnum.greaterThan10,
  ];

  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(
          appLocalizations.userProfileSectionChronicKidneyDiseaseAge,
        ),
        showDividers: true,
        children: [
          for (final interval in _invervals)
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
  bool validate(UserProfileV2RequestBuilder builder) {
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
        showDividers: true,
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
            )
        ],
      ),
    );
  }

  @override
  bool validate(UserProfileV2RequestBuilder builder) {
    return builder.chronicKidneyDiseaseStage != null;
  }
}

class DialysisStep extends UserProfileStep {
  static const _dialysisSelections = <DialysisEnum>[
    DialysisEnum.automaticPeritonealDialysis,
    DialysisEnum.manualPeritonealDialysis,
    DialysisEnum.hemodialysis,
    DialysisEnum.postTransplant,
    DialysisEnum.notPerformed,
  ];

  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(appLocalizations.userProfileSectionDialysisType),
        showDividers: true,
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
  bool validate(UserProfileV2RequestBuilder builder) {
    return builder.dialysis != null && builder.dialysis != DialysisEnum.unknown;
  }
}

class DiabetesStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(appLocalizations.userProfileSectionDiabetesTitle),
        showDividers: true,
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
  bool validate(UserProfileV2RequestBuilder builder) {
    return builder.diabetesType != null &&
        builder.diabetesType != DiabetesTypeEnum.unknown;
  }
}
