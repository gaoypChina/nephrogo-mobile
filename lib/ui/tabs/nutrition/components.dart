import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/model/intake.dart';

class IntakeNutrientTile extends StatelessWidget {
  final Intake intake;
  final Nutrient nutrient;

  IntakeNutrientTile(this.intake, this.nutrient)
      : super(key: Key('IntakeNutrientTile-${intake.id}-$nutrient'));

  @override
  Widget build(BuildContext context) {
    final amountText =
        intake.product.getFormattedTotalAmount(nutrient, intake.amountG);

    return AppListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      title: Text(nutrient.name(AppLocalizations.of(context))),
      trailing: Text(amountText),
      dense: true,
    );
  }
}
