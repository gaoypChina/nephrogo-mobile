import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo_api_client/model/dialysate_color_enum.dart';
import 'package:nephrogo_api_client/model/dialysis_solution_enum.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis.dart';

extension DialysisSolutionExtension on DialysisSolutionEnum {
  String localizedName(AppLocalizations appLocalizations) {
    switch (this) {
      case DialysisSolutionEnum.green:
        return appLocalizations.dialysisSolutionGreen;
      case DialysisSolutionEnum.yellow:
        return appLocalizations.dialysisSolutionYellow;

      case DialysisSolutionEnum.orange:
        return appLocalizations.dialysisSolutionOrange;

      case DialysisSolutionEnum.blue:
        return appLocalizations.dialysisSolutionBlue;

      case DialysisSolutionEnum.purple:
        return appLocalizations.dialysisSolutionPurple;

      case DialysisSolutionEnum.unknown:
        return appLocalizations.unknown;
    }

    throw ArgumentError.value(this);
  }

  String localizedDescription(AppLocalizations appLocalizations) {
    switch (this) {
      case DialysisSolutionEnum.green:
        return appLocalizations.dialysisSolutionGreenDescription;
      case DialysisSolutionEnum.yellow:
        return appLocalizations.dialysisSolutionYellowDescription;

      case DialysisSolutionEnum.orange:
        return appLocalizations.dialysisSolutionOrangeDescription;

      case DialysisSolutionEnum.blue:
        return appLocalizations.dialysisSolutionBlueDescription;

      case DialysisSolutionEnum.purple:
        return appLocalizations.dialysisSolutionPurpleDescription;

      case DialysisSolutionEnum.unknown:
        return appLocalizations.unknown;
    }

    throw ArgumentError.value(this);
  }

  Color get color {
    switch (this) {
      case DialysisSolutionEnum.green:
        return Colors.teal;
      case DialysisSolutionEnum.yellow:
        return Colors.yellow;
      case DialysisSolutionEnum.orange:
        return Colors.deepOrange;
      case DialysisSolutionEnum.blue:
        return Colors.blue;
      case DialysisSolutionEnum.purple:
        return Colors.purple;
      case DialysisSolutionEnum.unknown:
        return Colors.black;
    }

    throw ArgumentError.value(this);
  }
}

extension DialysateColorExtensions on DialysateColorEnum {
  String localizedName(AppLocalizations appLocalizations) {
    switch (this) {
      case DialysateColorEnum.transparent:
        return appLocalizations.dialysateColorTransparent;
      case DialysateColorEnum.pink:
        return appLocalizations.dialysateColorPink;

      case DialysateColorEnum.cloudyYellowish:
        return appLocalizations.dialysateColorCloudyYellowish;

      case DialysateColorEnum.greenish:
        return appLocalizations.dialysateColorGreenish;

      case DialysateColorEnum.brown:
        return appLocalizations.dialysateColorBrown;

      case DialysateColorEnum.cloudyWhite:
        return appLocalizations.dialysateColorCloudyWhite;

      case DialysateColorEnum.unknown:
        return appLocalizations.unknown;
    }

    throw ArgumentError.value(this);
  }

  Color get color {
    switch (this) {
      case DialysateColorEnum.transparent:
        return Colors.transparent;
      case DialysateColorEnum.pink:
        return Colors.pink;
      case DialysateColorEnum.cloudyYellowish:
        return Colors.yellowAccent;
      case DialysateColorEnum.greenish:
        return Colors.lightGreen;
      case DialysateColorEnum.brown:
        return Colors.brown;
      case DialysateColorEnum.cloudyWhite:
        return Colors.grey;
      case DialysateColorEnum.unknown:
        return Colors.black;
    }

    throw ArgumentError.value(this);
  }

  Color get textColor {
    switch (this) {
      case DialysateColorEnum.transparent:
      case DialysateColorEnum.cloudyWhite:
        return Colors.black;
      case DialysateColorEnum.pink:
      case DialysateColorEnum.cloudyYellowish:
      case DialysateColorEnum.greenish:
      case DialysateColorEnum.brown:
      case DialysateColorEnum.unknown:
        return Colors.white;
    }

    throw ArgumentError.value(this);
  }
}

extension ManualPeritonealDialysisExtensions on ManualPeritonealDialysis {
  int get balance => solutionOutMl - solutionInMl;
}
