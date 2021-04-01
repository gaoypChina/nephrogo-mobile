import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/ui/forms/form_validators.dart';

extension StateExtensions<T extends StatefulWidget> on State<T> {
  AppLocalizations get appLocalizations => AppLocalizations.of(context)!;

  FormValidators get formValidators => FormValidators(context);
}

extension BuildContextExtensions on BuildContext {
  AppLocalizations get appLocalizations => AppLocalizations.of(this)!;
}

extension ColorsExtensions on Color {
  String toHexTriplet() {
    return '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}
