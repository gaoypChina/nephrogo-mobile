import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/scroll_picker.dart';
import 'package:nephrogo/utils/formatters/date_formatter.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

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

class BirthdayStep extends UserProfileStep {
  Date? _parsedDate;
  final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');

  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final dateTime = _parsedDate?.toDateTime(utc: true);

    return SingleChildScrollView(
      child: LargeSection(
        title: Text(context.appLocalizations.dateOfBirth),
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextFormField(
                  labelText: null,
                  initialValue:
                      dateTime != null ? _dateFormat.format(dateTime) : null,
                  keyboardType: TextInputType.number,
                  autoFocus: true,
                  hintText: 'yyyy/mm/dd',
                  inputFormatters: [
                    DateInputFormatter(),
                  ],
                  onChanged: (text) {
                    setState(() {
                      try {
                        _parsedDate = text != null
                            ? _dateFormat.parseStrict(text, true).toDate()
                            : null;
                      } on FormatException catch (_) {
                        _parsedDate = null;
                      }
                    });
                  })),
        ],
      ),
    );
  }

  @override
  bool validate(UserProfileV2RequestBuilder builder) {
    return _parsedDate != null;
  }
}

class WeightStep extends UserProfileStep {
  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
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
              fractionDigits: 1,
              suffixText: 'kg',
              textInputAction: TextInputAction.next,
              helperText: context.appLocalizations.userProfileWeightHelper,
              initialValue: 45.1,
              validator: FormValidators(context).numRangeValidator(30.0, 300.0),
              // onChanged: (value) => _requestBuilder.weightKg = value,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool validate(UserProfileV2RequestBuilder builder) {
    return true;
  }
}

class HeightStep extends UserProfileStep {
  late final _heightValues = List.generate(151, (index) => 100 + index);

  late final List<String> _heightFormattedValues =
      _heightValues.map(_formatHeight).toList();

  late final Map<String, int> _heightFormattedMap = Map.fromIterables(
    _heightFormattedValues,
    _heightValues,
  );

  String _formatHeight(int height) => '$height cm';

  @override
  Widget build(
    BuildContext context,
    UserProfileV2RequestBuilder builder,
    void Function(VoidCallback fn) setState,
  ) {
    final height = builder.heightCm ??= _getInitialHeight(builder);

    return LargeSection(
      title: Text(context.appLocalizations.height),
      children: [
        Expanded(
          child: ScrollPicker(
            items: _heightFormattedValues,
            initialValue: _formatHeight(height),
            showDivider: false,
            onChanged: (v) => setState(
              () => builder.heightCm = _heightFormattedMap[v],
            ),
          ),
        ),
      ],
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
