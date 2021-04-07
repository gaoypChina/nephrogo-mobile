import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:numberpicker/numberpicker.dart';

abstract class UserProfileStep {
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) setState,
  );

  bool validate(UserProfileRequestBuilder builder);

  Future<void> save() async {}
}

class GenderStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
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
    UserProfileRequestBuilder builder,
    GenderEnum? gender,
    void Function(VoidCallback fn) setState,
  ) {
    setState(() {
      builder.gender = gender;
    });
  }

  @override
  bool validate(UserProfileRequestBuilder builder) {
    return builder.gender != null;
  }
}

class HeightStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
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

  int _getInitialHeight(UserProfileRequestBuilder builder) {
    if (builder.gender == GenderEnum.female) {
      return 165;
    }
    return 180;
  }

  @override
  bool validate(UserProfileRequestBuilder builder) {
    return true;
  }
}

class ChronicKidneyDiseaseStageStep extends UserProfileStep {
  final _stages = <ChronicKidneyDiseaseStageEnum>[
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
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return Scrollbar(
      isAlwaysShown: true,
      child: SingleChildScrollView(
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
              _buildSelectionWidget(
                stage,
                appLocalizations,
                builder,
                setState,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionWidget(
    ChronicKidneyDiseaseStageEnum stage,
    AppLocalizations appLocalizations,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final description = stage.description(appLocalizations);

    return AppRadioListTile<ChronicKidneyDiseaseStageEnum>(
      title: Text(stage.title(appLocalizations)),
      subtitle: description != null ? Text(description) : null,
      value: stage,
      groupValue: builder.chronicKidneyDiseaseStage,
      onChanged: (s) => _onStageSelected(builder, s, setState),
    );
  }

  void _onStageSelected(
    UserProfileRequestBuilder builder,
    ChronicKidneyDiseaseStageEnum? stage,
    void Function(VoidCallback fn) setState,
  ) {
    setState(() {
      builder.chronicKidneyDiseaseStage = stage;
    });
  }

  @override
  bool validate(UserProfileRequestBuilder builder) {
    return builder.chronicKidneyDiseaseStage != null;
  }
}

class DialysisStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(appLocalizations.userProfileSectionDialysisType),
        showDividers: true,
        children: [
          AppRadioListTile<DialysisTypeEnum>(
            title: Text(
              appLocalizations.userProfileSectionDialysisTypePeriotonicDialysis,
            ),
            value: DialysisTypeEnum.periotonicDialysis,
            groupValue: builder.dialysisType,
            onChanged: (s) => _onDialysisSelected(builder, s, setState),
          ),
          AppRadioListTile<DialysisTypeEnum>(
            title: Text(
              appLocalizations.userProfileSectionDialysisTypeHemodialysis,
            ),
            value: DialysisTypeEnum.hemodialysis,
            groupValue: builder.dialysisType,
            onChanged: (s) => _onDialysisSelected(builder, s, setState),
          ),
          AppRadioListTile<DialysisTypeEnum>(
            title: Text(
              appLocalizations.userProfileSectionDialysisTypePostTransplant,
            ),
            subtitle: Text(appLocalizations
                .userProfileSectionDialysisTypePostTransplantDescription),
            value: DialysisTypeEnum.postTransplant,
            groupValue: builder.dialysisType,
            onChanged: (s) => _onDialysisSelected(builder, s, setState),
          ),
          AppRadioListTile<DialysisTypeEnum>(
            title: Text(
              appLocalizations.userProfileSectionDialysisTypeNotPerformed,
            ),
            value: DialysisTypeEnum.notPerformed,
            groupValue: builder.dialysisType,
            onChanged: (s) => _onDialysisSelected(builder, s, setState),
          ),
        ],
      ),
    );
  }

  void _onDialysisSelected(
    UserProfileRequestBuilder builder,
    DialysisTypeEnum? stage,
    void Function(VoidCallback fn) setState,
  ) {
    setState(() {
      builder.dialysisType = stage;
    });
  }

  @override
  bool validate(UserProfileRequestBuilder builder) {
    return builder.dialysisType != null &&
        builder.dialysisType != DialysisTypeEnum.unknown;
  }
}

class PeritonealDialysisTypeStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(appLocalizations.peritonealDialysisType),
        showDividers: true,
        children: [
          AppRadioListTile<PeriotonicDialysisTypeEnum>(
            title: Text(appLocalizations.peritonealDialysisTypeAutomatic),
            value: PeriotonicDialysisTypeEnum.automatic,
            groupValue: builder.periotonicDialysisType,
            onChanged: (s) => _onSelected(builder, s, setState),
          ),
          AppRadioListTile<PeriotonicDialysisTypeEnum>(
            title: Text(appLocalizations.peritonealDialysisTypeManual),
            value: PeriotonicDialysisTypeEnum.manual,
            groupValue: builder.periotonicDialysisType,
            onChanged: (s) => _onSelected(builder, s, setState),
          ),
        ],
      ),
    );
  }

  void _onSelected(
    UserProfileRequestBuilder builder,
    PeriotonicDialysisTypeEnum? type,
    void Function(VoidCallback fn) setState,
  ) {
    setState(() {
      builder.periotonicDialysisType = type;
    });
  }

  @override
  bool validate(UserProfileRequestBuilder builder) {
    return builder.periotonicDialysisType != null &&
        builder.periotonicDialysisType != PeriotonicDialysisTypeEnum.unknown;
  }
}

class DiabetesStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
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
    UserProfileRequestBuilder builder,
    DiabetesTypeEnum? type,
    void Function(VoidCallback fn) setState,
  ) {
    setState(() {
      builder.diabetesType = type;
    });
  }

  @override
  bool validate(UserProfileRequestBuilder builder) {
    return builder.diabetesType != null &&
        builder.diabetesType != DiabetesTypeEnum.unknown;
  }
}
