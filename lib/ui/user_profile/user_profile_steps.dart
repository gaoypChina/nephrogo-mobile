import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:numberpicker/numberpicker.dart';

abstract class UserProfileStep {
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) reloadState,
  );

  bool validate(UserProfileRequestBuilder builder);

  bool isEnabled(UserProfileRequestBuilder builder) => true;

  Future<void> save() async {}
}

class GenderStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) reloadState,
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
            onChanged: (g) => _onGenderSelected(builder, g, reloadState),
          ),
          AppRadioListTile<GenderEnum>(
            title: Text(context.appLocalizations.female),
            value: GenderEnum.female,
            groupValue: builder.gender,
            onChanged: (g) => _onGenderSelected(builder, g, reloadState),
          ),
        ],
      ),
    );
  }

  void _onGenderSelected(
    UserProfileRequestBuilder builder,
    GenderEnum? gender,
    void Function(VoidCallback fn) reloadState,
  ) {
    reloadState(() {
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
    void Function(VoidCallback fn) reloadState,
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
                  reloadState(() => builder.heightCm = height);
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
  @override
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) reloadState,
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
          AppRadioListTile<ChronicKidneyDiseaseStageEnum>(
            leading: const CircleAvatar(child: Text('1')),
            title: Text(
              appLocalizations.userProfileSectionChronicKidneyDiseaseStage1,
            ),
            value: ChronicKidneyDiseaseStageEnum.stage1,
            groupValue: builder.chronicKidneyDiseaseStage,
            onChanged: (s) => _onStageSelected(builder, s, reloadState),
          ),
          AppRadioListTile<ChronicKidneyDiseaseStageEnum>(
            leading: const CircleAvatar(child: Text('2')),
            title: Text(
              appLocalizations.userProfileSectionChronicKidneyDiseaseStage2,
            ),
            value: ChronicKidneyDiseaseStageEnum.stage2,
            groupValue: builder.chronicKidneyDiseaseStage,
            onChanged: (s) => _onStageSelected(builder, s, reloadState),
          ),
          AppRadioListTile<ChronicKidneyDiseaseStageEnum>(
            leading: const CircleAvatar(child: Text('3')),
            title: Text(
              appLocalizations.userProfileSectionChronicKidneyDiseaseStage3,
            ),
            value: ChronicKidneyDiseaseStageEnum.stage3,
            groupValue: builder.chronicKidneyDiseaseStage,
            onChanged: (s) => _onStageSelected(builder, s, reloadState),
          ),
          AppRadioListTile<ChronicKidneyDiseaseStageEnum>(
            leading: const CircleAvatar(child: Text('4')),
            title: Text(
              appLocalizations.userProfileSectionChronicKidneyDiseaseStage4,
            ),
            value: ChronicKidneyDiseaseStageEnum.stage4,
            groupValue: builder.chronicKidneyDiseaseStage,
            onChanged: (s) => _onStageSelected(builder, s, reloadState),
          ),
          AppRadioListTile<ChronicKidneyDiseaseStageEnum>(
            leading: const CircleAvatar(child: Text('5')),
            title: Text(
              appLocalizations.userProfileSectionChronicKidneyDiseaseStage5,
            ),
            value: ChronicKidneyDiseaseStageEnum.stage5,
            groupValue: builder.chronicKidneyDiseaseStage,
            onChanged: (s) => _onStageSelected(builder, s, reloadState),
          ),
          AppRadioListTile<ChronicKidneyDiseaseStageEnum>(
            leading: const CircleAvatar(child: Text('?')),
            title: Text(appLocalizations.iDontKnown),
            value: ChronicKidneyDiseaseStageEnum.unknown,
            groupValue: builder.chronicKidneyDiseaseStage,
            onChanged: (s) => _onStageSelected(builder, s, reloadState),
          ),
        ],
      ),
    );
  }

  void _onStageSelected(
    UserProfileRequestBuilder builder,
    ChronicKidneyDiseaseStageEnum? stage,
    void Function(VoidCallback fn) reloadState,
  ) {
    reloadState(() {
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
    void Function(VoidCallback fn) reloadState,
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
            onChanged: (s) => _onDialysisSelected(builder, s, reloadState),
          ),
          AppRadioListTile<DialysisTypeEnum>(
            title: Text(
              appLocalizations.userProfileSectionDialysisTypeHemodialysis,
            ),
            value: DialysisTypeEnum.hemodialysis,
            groupValue: builder.dialysisType,
            onChanged: (s) => _onDialysisSelected(builder, s, reloadState),
          ),
          AppRadioListTile<DialysisTypeEnum>(
            title: Text(
              appLocalizations.userProfileSectionDialysisTypePostTransplant,
            ),
            subtitle: Text(appLocalizations
                .userProfileSectionDialysisTypePostTransplantDescription),
            value: DialysisTypeEnum.postTransplant,
            groupValue: builder.dialysisType,
            onChanged: (s) => _onDialysisSelected(builder, s, reloadState),
          ),
          AppRadioListTile<DialysisTypeEnum>(
            title: Text(
              appLocalizations.userProfileSectionDialysisTypeNotPerformed,
            ),
            value: DialysisTypeEnum.notPerformed,
            groupValue: builder.dialysisType,
            onChanged: (s) => _onDialysisSelected(builder, s, reloadState),
          ),
        ],
      ),
    );
  }

  void _onDialysisSelected(
    UserProfileRequestBuilder builder,
    DialysisTypeEnum? stage,
    void Function(VoidCallback fn) reloadState,
  ) {
    reloadState(() {
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
    void Function(VoidCallback fn) reloadState,
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
            onChanged: (s) => _onSelected(builder, s, reloadState),
          ),
          AppRadioListTile<PeriotonicDialysisTypeEnum>(
            title: Text(appLocalizations.peritonealDialysisTypeManual),
            value: PeriotonicDialysisTypeEnum.manual,
            groupValue: builder.periotonicDialysisType,
            onChanged: (s) => _onSelected(builder, s, reloadState),
          ),
        ],
      ),
    );
  }

  void _onSelected(
    UserProfileRequestBuilder builder,
    PeriotonicDialysisTypeEnum? type,
    void Function(VoidCallback fn) reloadState,
  ) {
    reloadState(() {
      builder.periotonicDialysisType = type;
    });
  }

  @override
  bool validate(UserProfileRequestBuilder builder) {
    return builder.periotonicDialysisType != null &&
        builder.periotonicDialysisType != PeriotonicDialysisTypeEnum.unknown;
  }

  @override
  bool isEnabled(UserProfileRequestBuilder builder) {
    return builder.dialysisType == DialysisTypeEnum.periotonicDialysis;
  }
}

class DiabetesStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) reloadState,
  ) {
    final appLocalizations = context.appLocalizations;

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(appLocalizations.userProfileSectionDiabetesType),
        showDividers: true,
        children: [
          AppRadioListTile<DiabetesTypeEnum>(
            title: Text(appLocalizations.userProfileSectionDiabetesType1),
            value: DiabetesTypeEnum.type1,
            groupValue: builder.diabetesType,
            onChanged: (s) => _onSelected(builder, s, reloadState),
          ),
          AppRadioListTile<DiabetesTypeEnum>(
            title: Text(appLocalizations.userProfileSectionDiabetesType2),
            value: DiabetesTypeEnum.type2,
            groupValue: builder.diabetesType,
            onChanged: (s) => _onSelected(builder, s, reloadState),
          ),
          AppRadioListTile<DiabetesTypeEnum>(
            title: Text(appLocalizations.userProfileSectionDiabetesTypeNo),
            value: DiabetesTypeEnum.no,
            groupValue: builder.diabetesType,
            onChanged: (s) => _onSelected(builder, s, reloadState),
          ),
        ],
      ),
    );
  }

  void _onSelected(
    UserProfileRequestBuilder builder,
    DiabetesTypeEnum? type,
    void Function(VoidCallback fn) reloadState,
  ) {
    reloadState(() {
      builder.diabetesType = type;
    });
  }

  @override
  bool validate(UserProfileRequestBuilder builder) {
    return builder.diabetesType != null &&
        builder.diabetesType != DiabetesTypeEnum.unknown;
  }
}
