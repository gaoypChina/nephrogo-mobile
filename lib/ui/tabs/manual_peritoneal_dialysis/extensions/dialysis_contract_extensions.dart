import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo_api_client/model/dialysate_color_enum.dart';
import 'package:nephrogo_api_client/model/solution_enum.dart';

extension DialysisSolutionExtension on SolutionEnum {
  String localizedName(AppLocalizations appLocalizations) {
    switch (this) {
      case SolutionEnum.green:
        return appLocalizations.dialysisSolutionGreen;
      case SolutionEnum.yellow:
        return appLocalizations.dialysisSolutionYellow;

      case SolutionEnum.orange:
        return appLocalizations.dialysisSolutionOrange;

      case SolutionEnum.blue:
        return appLocalizations.dialysisSolutionBlue;

      case SolutionEnum.purple:
        return appLocalizations.dialysisSolutionPurple;

      case SolutionEnum.unknown:
        return appLocalizations.unknown;
    }

    throw ArgumentError.value(this);
  }

  String localizedDescription(AppLocalizations appLocalizations) {
    switch (this) {
      case SolutionEnum.green:
        return appLocalizations.dialysisSolutionGreenDescription;
      case SolutionEnum.yellow:
        return appLocalizations.dialysisSolutionYellowDescription;

      case SolutionEnum.orange:
        return appLocalizations.dialysisSolutionOrangeDescription;

      case SolutionEnum.blue:
        return appLocalizations.dialysisSolutionBlueDescription;

      case SolutionEnum.purple:
        return appLocalizations.dialysisSolutionPurpleDescription;

      case SolutionEnum.unknown:
        return appLocalizations.unknown;
    }

    throw ArgumentError.value(this);
  }

  Color get color {
    switch (this) {
      case SolutionEnum.green:
        return Colors.teal;
      case SolutionEnum.yellow:
        return Colors.yellow;
      case SolutionEnum.orange:
        return Colors.deepOrange;
      case SolutionEnum.blue:
        return Colors.blue;
      case SolutionEnum.purple:
        return Colors.purple;
      case SolutionEnum.unknown:
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
}
