import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/my_daily_intakes_screen.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/model/daily_nutrient_norms_with_totals.dart';
import 'package:nephrogo_api_client/model/intake.dart';

import 'intake_create.dart';

class DailyIntakesReportTile extends StatelessWidget {
  final _dateFormat = DateFormat('EEEE, MMMM d');

  final DailyIntakesLightReport dailyIntakesLightReport;

  DailyIntakesReportTile(this.dailyIntakesLightReport)
      : super(key: ObjectKey(dailyIntakesLightReport));

  @override
  Widget build(BuildContext context) {
    final title = Text(
        _dateFormat.format(dailyIntakesLightReport.date).capitalizeFirst());

    return BasicSection(
      header: AppListTile(
        leading: _getLeadingIndicator(),
        title: title,
        onTap: () => Navigator.of(context).pushNamed(
          Routes.routeMyDailyIntakesScreen,
          arguments:
              MyDailyIntakesScreenArguments(Date(dailyIntakesLightReport.date)),
        ),
      ),
      showDividers: true,
      children: [
        for (final nutrient in Nutrient.values)
          DailyIntakesReportNutrientTile(
            dailyIntakesLightReport.nutrientNormsAndTotals,
            nutrient,
          )
      ],
    );
  }

  Widget _getLeadingIndicator() {
    if (dailyIntakesLightReport.nutrientNormsAndTotals
        .isAtLeastOneNormExceeded()) {
      return const CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.error, color: Colors.white),
      );
    }

    return const CircleAvatar(
      backgroundColor: Colors.teal,
      child: Icon(Icons.check_circle, color: Colors.white),
    );
  }
}

class IntakeWithNormsTile extends StatelessWidget {
  final Intake intake;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;

  IntakeWithNormsTile(
    this.intake,
    this.dailyNutrientNormsAndTotals,
  ) : super(key: ObjectKey(intake));

  @override
  Widget build(BuildContext context) {
    return BasicSection(
      header: IntakeTile(intake, dailyNutrientNormsAndTotals),
      showDividers: true,
      children: [
        for (final nutrient in Nutrient.values)
          IntakeNutrientTile(
            intake,
            nutrient,
            dailyNutrientNormsAndTotals,
          )
      ],
    );
  }
}

class IntakeTile extends StatelessWidget {
  static final dateFormat = DateFormat('E, d MMM HH:mm');

  final Intake intake;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;

  IntakeTile(
    this.intake,
    this.dailyNutrientNormsAndTotals,
  ) : super(key: ObjectKey(intake));

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: Text(intake.product.name),
      subtitle: Text(
        dateFormat.format(intake.consumedAt.toLocal()).capitalizeFirst(),
      ),
      leading: ProductKindIcon(productKind: intake.product.productKind),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(intake.getAmountFormatted()),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed(
        Routes.routeIntakeCreate,
        arguments: IntakeCreateScreenArguments(
          intake: intake,
          dailyNutrientNormsAndTotals: dailyNutrientNormsAndTotals,
        ),
      ),
    );
  }
}

class IntakeExpandableTile extends StatelessWidget {
  static final dateFormat = DateFormat('E, d MMM HH:mm');

  final Intake intake;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;

  IntakeExpandableTile(
    this.intake,
    this.dailyNutrientNormsAndTotals,
  ) : super(key: ObjectKey(intake));

  @override
  Widget build(BuildContext context) {
    final dateFormatted =
        dateFormat.format(intake.consumedAt.toLocal()).capitalizeFirst();

    return ListTileTheme(
      selectedColor: Colors.blue,
      child: AppExpansionTile(
        title: Text(
          intake.product.name,
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          '${intake.getAmountFormatted()} | $dateFormatted',
          style: TextStyle(color: Theme.of(context).textTheme.caption.color),
        ),
        onLongPress: () => _showLongClickDialog(context),
        leading: ProductKindIcon(productKind: intake.product.productKind),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            for (final nutrient in Nutrient.values)
              IntakeNutrientTile(
                intake,
                nutrient,
                dailyNutrientNormsAndTotals,
              )
          ],
        ).toList(),
      ),
    );
  }

  Future<void> _showLongClickDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppListTile(
                  title: Text(AppLocalizations.of(context).edit),
                  onTap: () => _editIntake(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _editIntake(BuildContext context) {
    return Navigator.of(context).pushNamed(
      Routes.routeIntakeCreate,
      arguments: IntakeCreateScreenArguments(
        intake: intake,
        dailyNutrientNormsAndTotals: dailyNutrientNormsAndTotals,
      ),
    );
  }
}

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

class DailyIntakesReportNutrientTile extends StatelessWidget {
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Nutrient nutrient;

  const DailyIntakesReportNutrientTile(
    this.dailyNutrientNormsAndTotals,
    this.nutrient, {
    Key key,
  })  : assert(dailyNutrientNormsAndTotals != null),
        assert(nutrient != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final nutrientName = nutrient.name(appLocalizations);

    final percentage = dailyNutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .totalConsumptionRoundedPercentage();

    return AppListTile(
      title: Text(nutrientName),
      subtitle: Text(_getSubtitleText(appLocalizations)),
      leading: _leadingTotalConsumptionIndicator(percentage),
      trailing: percentage != null ? Text('$percentage%') : null,
      dense: true,
    );
  }

  String _getSubtitleText(AppLocalizations appLocalizations) {
    final totalFormatted =
        dailyNutrientNormsAndTotals.getNutrientTotalAmountFormatted(nutrient);

    final normFormatted =
        dailyNutrientNormsAndTotals.getNutrientNormFormatted(nutrient);
    if (normFormatted != null) {
      return appLocalizations.consumptionWithNorm(
          totalFormatted, normFormatted);
    }

    return appLocalizations.consumptionWithoutNorm(totalFormatted);
  }

  Widget _leadingTotalConsumptionIndicator(int percentageRounded) {
    if (percentageRounded == null) {
      return const SizedBox();
    }

    if (percentageRounded > 100) {
      return const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(Icons.error, color: Colors.redAccent),
      );
    }

    return const CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Icon(Icons.check_circle, color: Colors.teal),
    );
  }
}
