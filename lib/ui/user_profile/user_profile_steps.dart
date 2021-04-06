import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

abstract class UserProfileStep {
  Widget build(
    BuildContext context,
    UserProfileRequestBuilder builder,
    void Function(VoidCallback fn) reloadState,
  );

  bool validate(UserProfileRequestBuilder builder);

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
            leading: const CircleAvatar(child: Icon(Icons.help)),
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
