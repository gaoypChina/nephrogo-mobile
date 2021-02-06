import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/model/daily_nutrient_norms_with_totals.dart';
import 'package:nephrogo_api_client/model/intake.dart';

class IntakeNutrientTile extends StatelessWidget {
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Intake intake;
  final Nutrient nutrient;

  const IntakeNutrientTile(
    this.intake,
    this.nutrient,
    this.dailyNutrientNormsAndTotals, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final nutrientName = nutrient.name(appLocalizations);

    if (intake == null) {
      return AppListTile(
        title: Text(nutrientName),
        trailing: const Text('-'),
        dense: true,
      );
    }

    final amountText =
        intake.product.getFormattedTotalAmount(nutrient, intake.amountG);

    final subtitle = _getSubtitle(appLocalizations);

    return AppListTile(
      title: Text(nutrientName),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Text(amountText),
      dense: true,
    );
  }

  String _getSubtitle(AppLocalizations appLocalizations) {
    final nutrientAmount = intake.getNutrientAmount(nutrient);

    final percentage = dailyNutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .normPercentage(nutrientAmount)
        ?.toString();

    if (percentage != null) {
      return appLocalizations.percentageOfDailyNorm(percentage);
    }

    return null;
  }
}
