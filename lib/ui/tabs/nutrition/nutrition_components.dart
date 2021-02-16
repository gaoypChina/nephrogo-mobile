import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_daily_summary.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/model/daily_nutrient_consumption.dart';
import 'package:nephrogo_api_client/model/daily_nutrient_norms_with_totals.dart';
import 'package:nephrogo_api_client/model/intake.dart';

import 'intake_edit.dart';

class DailyIntakesReportSection extends StatelessWidget {
  final _dateFormat = DateFormat('EEEE, MMMM d');

  final DailyIntakesLightReport dailyIntakesLightReport;

  DailyIntakesReportSection(this.dailyIntakesLightReport)
      : super(key: ObjectKey(dailyIntakesLightReport));

  @override
  Widget build(BuildContext context) {
    final title = Text(
        _dateFormat.format(dailyIntakesLightReport.date).capitalizeFirst());

    return BasicSection(
      header: AppListTile(
        leading: _getLeadingIndicator(),
        title: title,
        subtitle: Text(_getSubtitleText(context)),
        onTap: () => Navigator.of(context).pushNamed(
          Routes.routeNutritionDailySummary,
          arguments: NutritionDailySummaryScreenArguments(
              Date.from(dailyIntakesLightReport.date)),
        ),
      ),
      showDividers: true,
      showHeaderDivider: true,
      children: [
        for (final nutrient in Nutrient.values)
          DailyIntakesReportNutrientTile(
            dailyIntakesLightReport.nutrientNormsAndTotals,
            dailyIntakesLightReport.date.toDate(),
            nutrient,
          )
      ],
    );
  }

  String _getSubtitleText(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final exceededCount =
        dailyIntakesLightReport.nutrientNormsAndTotals.normsExceededCount();

    switch (exceededCount) {
      case 0:
        return appLocalizations.dailyNormsExceededZero;
      case 1:
        return appLocalizations.dailyNormsExceededOne;
      default:
        return appLocalizations.dailyNormsExceededOther(exceededCount);
    }
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

class IntakeWithNormsSection extends StatelessWidget {
  final Intake intake;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;

  IntakeWithNormsSection(
    this.intake,
    this.dailyNutrientNormsAndTotals,
  ) : super(key: ObjectKey(intake));

  @override
  Widget build(BuildContext context) {
    return BasicSection(
      header: IntakeTile(intake, dailyNutrientNormsAndTotals),
      showDividers: true,
      showHeaderDivider: true,
      children: [
        for (final nutrient in Nutrient.values)
          IntakeNutrientDenseTile(
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
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(intake.getAmountFormatted()),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed(
        Routes.routeIntakeEdit,
        arguments: IntakeEditScreenArguments(
          intake,
          dailyNutrientNormsAndTotals,
        ),
      ),
    );
  }
}

class IntakeExpandableTile extends StatelessWidget {
  static final dateFormat = DateFormat('E, d MMM HH:mm');

  final Intake intake;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final bool initiallyExpanded;
  final bool showSubtitle;

  IntakeExpandableTile(
    this.intake,
    this.dailyNutrientNormsAndTotals, {
    this.initiallyExpanded = false,
    this.showSubtitle = true,
  }) : super(key: PageStorageKey(intake));

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      selectedColor: Colors.blue,
      child: AppExpansionTile(
        title: Text(intake.product.name),
        subtitle: showSubtitle ? Text(_getSubtitleParts().join(" | ")) : null,
        onLongPress:
            (intake.id != null) ? () => _showLongClickDialog(context) : null,
        initiallyExpanded: initiallyExpanded,
        leading: ProductKindIcon(productKind: intake.product.productKind),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            for (final nutrient in Nutrient.values)
              IntakeNutrientDenseTile(
                intake,
                nutrient,
                dailyNutrientNormsAndTotals,
              )
          ],
        ).toList(),
      ),
    );
  }

  Iterable<String> _getSubtitleParts() sync* {
    if (intake.amountG != 0) {
      yield intake.getAmountFormatted();
    }

    yield dateFormat.format(intake.consumedAt.toLocal()).capitalizeFirst();
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
    return Navigator.of(context).pushReplacementNamed(
      Routes.routeIntakeEdit,
      arguments: IntakeEditScreenArguments(
        intake,
        dailyNutrientNormsAndTotals,
      ),
    );
  }
}

class IntakeNutrientDenseTile extends StatelessWidget {
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Intake intake;
  final Nutrient nutrient;

  const IntakeNutrientDenseTile(
    this.intake,
    this.nutrient,
    this.dailyNutrientNormsAndTotals, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final nutrientName = nutrient.name(appLocalizations);

    if (intake == null || intake.amountG == 0) {
      return AppListTile(
        title: Text(nutrientName),
        trailing: const Text('–'),
        dense: true,
      );
    }

    final amountText =
        intake.product.getFormattedTotalAmount(nutrient, intake.amountG);

    final subtitle = _getSubtitle(appLocalizations);

    final clickable = intake.id != null;

    return AppListTile(
      title: Text(nutrientName),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(amountText),
          ),
          if (clickable) const Icon(Icons.chevron_right),
        ],
      ),
      onTap: clickable ? () => _onTap(context) : null,
      dense: true,
    );
  }

  Future<void> _onTap(BuildContext context) {
    return Navigator.of(context).pushNamed(
      Routes.routeNutritionDailySummary,
      arguments: NutritionDailySummaryScreenArguments(
        intake.consumedAt.toDate(),
        nutrient: nutrient,
      ),
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
  final Date date;
  final Nutrient nutrient;

  const DailyIntakesReportNutrientTile(
    this.dailyNutrientNormsAndTotals,
    this.date,
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
      dense: true,
      trailing: SizedBox(
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (percentage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text('$percentage%'),
              ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        Routes.routeNutritionDailySummary,
        arguments: NutritionDailySummaryScreenArguments(
          date,
          nutrient: nutrient,
        ),
      ),
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

class NutrientDailyNutritionTile extends StatelessWidget {
  final _dateFormat = DateFormat('EEEE, MMMM d');

  final Date date;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Nutrient nutrient;

  NutrientDailyNutritionTile(
    this.date,
    this.dailyNutrientNormsAndTotals,
    this.nutrient, {
    Key key,
  })  : assert(dailyNutrientNormsAndTotals != null),
        assert(nutrient != null),
        assert(date != null),
        super(key: key);

  NutrientDailyNutritionTile.fromLightReport(
    this.nutrient,
    DailyIntakesLightReport lightReport,
  )   : date = lightReport.date.toDate(),
        dailyNutrientNormsAndTotals = lightReport.nutrientNormsAndTotals;

  DailyNutrientConsumption get consumption =>
      dailyNutrientNormsAndTotals.getDailyNutrientConsumption(nutrient);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final percentageRounded = consumption.totalConsumptionRoundedPercentage();

    return AppListTile(
      title: Text(_dateFormat.format(date).capitalizeFirst()),
      subtitle: Text(_getSubtitleText(appLocalizations)),
      leading: _leadingTotalConsumptionIndicator(),
      isThreeLine: consumption.isNormExceeded != null,
      trailing: SizedBox(
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (percentageRounded != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text('$percentageRounded%'),
              ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        Routes.routeNutritionDailySummary,
        arguments: NutritionDailySummaryScreenArguments(
          date,
          nutrient: nutrient,
        ),
      ),
    );
  }

  String _getConsumptionText(AppLocalizations appLocalizations) {
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

  String _getNormExceededText(AppLocalizations appLocalizations) {
    if (consumption.isNormExceeded == null) {
      return null;
    }

    if (consumption.isNormExceeded) {
      return appLocalizations.dailyNormExplanationExceeded;
    } else {
      return appLocalizations.dailyNormExplanationNotExceeded;
    }
  }

  String _getSubtitleText(AppLocalizations appLocalizations) {
    final consumptionText = _getConsumptionText(appLocalizations);
    final normExceededText = _getNormExceededText(appLocalizations);

    return [consumptionText, normExceededText]
        .where((s) => s != null)
        .join('\n');
  }

  Widget _leadingTotalConsumptionIndicator() {
    final percentageRounded = consumption.totalConsumptionRoundedPercentage();

    if (percentageRounded == null) {
      return CircleAvatar(
        backgroundColor: Colors.grey,
        child: Text(
          date.day.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (percentageRounded > 100) {
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

class NutrientIntakeTile extends StatelessWidget {
  final dateFormat = DateFormat('E, d MMM HH:mm');

  final Intake intake;
  final Nutrient nutrient;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;

  NutrientIntakeTile(
    this.intake,
    this.nutrient,
    this.dailyNutrientNormsAndTotals, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final nutrientAmountFormatted = intake.getNutrientAmountFormatted(nutrient);

    final normExists = dailyNutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .isNormExists;

    return AppListTile(
      title: Text(intake.product.name),
      subtitle: Text(_getSubtitle(appLocalizations)),
      leading: SizedBox(
        height: double.infinity,
        child: ProductKindIcon(productKind: intake.product.productKind),
      ),
      trailing: SizedBox(
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(nutrientAmountFormatted),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
      isThreeLine: normExists,
      onTap: () => Navigator.of(context).pushNamed(
        Routes.routeIntakeEdit,
        arguments: IntakeEditScreenArguments(
          intake,
          dailyNutrientNormsAndTotals,
        ),
      ),
    );
  }

  String _getConsumptionText(AppLocalizations appLocalizations) {
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

  String _getSubtitle(AppLocalizations appLocalizations) {
    final amount = intake.getAmountFormatted();
    final date =
        dateFormat.format(intake.consumedAt.toLocal()).capitalizeFirst();

    final intakeText = [amount, date].join(' | ');

    return [intakeText, _getConsumptionText(appLocalizations)]
        .where((t) => t != null)
        .join("\n");
  }
}
