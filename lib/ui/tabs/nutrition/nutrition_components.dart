import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/nutrient_bar_chart.dart';
import 'package:nephrogo/ui/forms/forms.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/intake_edit.dart';
import 'package:nephrogo/ui/tabs/nutrition/product_search.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_daily_summary.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class IntakeCreationFloatingActionButton extends StatelessWidget {
  final _mealTypesWithColors = LinkedHashMap.fromEntries([
    const MapEntry(MealTypeEnum.snack, Colors.indigo),
    const MapEntry(MealTypeEnum.dinner, Colors.blue),
    const MapEntry(MealTypeEnum.lunch, Colors.teal),
    const MapEntry(MealTypeEnum.breakfast, Colors.deepOrange),
  ]);

  @override
  Widget build(BuildContext context) {
    return SpeedDialFloatingActionButton(
      label: context.appLocalizations.createMeals,
      children: _getMealTypeDials(context),
    );
  }

  List<SpeedDialChild> _getMealTypeDials(BuildContext context) {
    return _mealTypesWithColors.keys.map((mealType) {
      return SpeedDialChild(
        child: Icon(mealType.icon),
        backgroundColor: _mealTypesWithColors[mealType],
        labelStyle: const TextStyle(fontSize: 16),
        foregroundColor: Colors.white,
        label: _localizedAddLabel(context, mealType),
        onTap: () => _createProduct(context, mealType),
      );
    }).toList();
  }

  String _localizedAddLabel(BuildContext context, MealTypeEnum mealType) {
    switch (mealType) {
      case MealTypeEnum.breakfast:
        return context.appLocalizations.breakfast;
      case MealTypeEnum.lunch:
        return context.appLocalizations.lunch;
      case MealTypeEnum.dinner:
        return context.appLocalizations.dinner;
      case MealTypeEnum.snack:
        return context.appLocalizations.snacks;
      default:
        throw ArgumentError.value(mealType);
    }
  }

  Future _createProduct(BuildContext context, MealTypeEnum mealType) {
    return Navigator.pushNamed(
      context,
      Routes.routeProductSearch,
      arguments: ProductSearchScreenArguments(
        ProductSearchType.choose,
        mealType,
      ),
    );
  }
}

class MealTypeSelectionFormField extends StatelessWidget {
  final MealTypeEnum initialMealType;
  final FormFieldSetter<MealTypeEnum> onChanged;
  final FormFieldSetter<MealTypeEnum> onSaved;

  const MealTypeSelectionFormField({
    super.key,
    required this.initialMealType,
    required this.onChanged,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return AppSelectFormField<MealTypeEnum>(
      labelText: context.appLocalizations.mealType,
      initialValue: initialMealType.enumWithoutDefault(MealTypeEnum.unknown),
      onChanged: (dt) => onChanged(dt!.value),
      onSaved: (v) => onSaved(v!.value),
      items: [
        for (final mealType in MealTypeEnum.values)
          if (mealType != MealTypeEnum.unknown)
            AppSelectFormFieldItem(
              value: mealType,
              icon: Icon(mealType.icon),
              text: mealType.localizedName(context.appLocalizations),
            ),
      ],
    );
  }
}

class DailyIntakesReportSection extends StatelessWidget {
  final _dateFormat = DateFormat('EEEE, MMMM d');

  final DailyIntakesLightReport dailyIntakesLightReport;

  DailyIntakesReportSection(this.dailyIntakesLightReport)
      : super(key: ObjectKey(dailyIntakesLightReport));

  @override
  Widget build(BuildContext context) {
    final title = Text(
      _dateFormat.formatDate(dailyIntakesLightReport.date).capitalizeFirst(),
    );

    final sortedNutrients = dailyIntakesLightReport.nutrientNormsAndTotals
        .getSortedNutrientsByExistence();

    return BasicSection(
      header: AppListTile(
        leading: _getLeadingIndicator(),
        title: title,
        subtitle: Text(_getSubtitleText(context)),
        onTap: () => Navigator.of(context).pushNamed(
          Routes.routeNutritionDailySummary,
          arguments: NutritionDailySummaryScreenArguments(
            dailyIntakesLightReport.date,
          ),
        ),
      ),
      showDividers: true,
      showHeaderDivider: true,
      children: [
        for (final nutrient in sortedNutrients)
          DailyIntakesReportNutrientTile(
            dailyIntakesLightReport.nutrientNormsAndTotals,
            dailyIntakesLightReport.date,
            nutrient,
          ),
      ],
    );
  }

  String _getSubtitleText(BuildContext context) {
    final appLocalizations = context.appLocalizations;

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
  final EdgeInsets? margin;

  IntakeWithNormsSection(
    this.intake,
    this.dailyNutrientNormsAndTotals, {
    this.margin,
  }) : super(key: ObjectKey(intake));

  @override
  Widget build(BuildContext context) {
    final sortedNutrients =
        dailyNutrientNormsAndTotals.getSortedNutrientsByExistence();

    return BasicSection(
      header: IntakeTile(intake, dailyNutrientNormsAndTotals),
      margin: margin,
      showDividers: true,
      showHeaderDivider: true,
      children: [
        for (final nutrient in sortedNutrients)
          IntakeNutrientDenseTile(
            intake,
            nutrient,
            dailyNutrientNormsAndTotals,
          ),
      ],
    );
  }
}

class IntakeTile extends StatelessWidget {
  final dateFormat = DateFormat('E, d MMM');

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
      subtitle: Text(_getSubtitleParts(context).join(' | ')),
      leading: ProductKindIcon(productKind: intake.product.productKind!),
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

  Iterable<String> _getSubtitleParts(BuildContext context) sync* {
    yield dateFormat.format(intake.consumedAt.toLocal()).capitalizeFirst();

    if (intake.mealType != MealTypeEnum.unknown) {
      yield intake.mealType!.localizedName(context.appLocalizations);
    }
  }
}

class IntakeExpandableTile extends StatelessWidget {
  final dateFormat = DateFormat('E, d MMM');

  final Intake intake;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final bool initiallyExpanded;
  final bool showDate;
  final bool allowLongClick;

  IntakeExpandableTile(
    this.intake,
    this.dailyNutrientNormsAndTotals, {
    this.initiallyExpanded = false,
    this.showDate = true,
    this.allowLongClick = true,
  }) : super(key: PageStorageKey(intake));

  @override
  Widget build(BuildContext context) {
    final sortedNutrients =
        dailyNutrientNormsAndTotals.getSortedNutrientsByExistence();

    return ListTileTheme(
      selectedColor: Colors.blue,
      child: AppExpansionTile(
        title: Text(intake.product.name),
        subtitle: Text(_getSubtitleParts(context).join(' | ')),
        onLongPress:
            allowLongClick ? () => _showLongClickDialog(context) : null,
        initiallyExpanded: initiallyExpanded,
        leading: ProductKindIcon(productKind: intake.product.productKind!),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            for (final nutrient in sortedNutrients)
              IntakeNutrientDenseTile(
                intake,
                nutrient,
                dailyNutrientNormsAndTotals,
              ),
          ],
        ).toList(),
      ),
    );
  }

  Iterable<String> _getSubtitleParts(BuildContext context) sync* {
    yield intake.getAmountFormatted();

    if (showDate) {
      yield dateFormat.format(intake.consumedAt.toLocal()).capitalizeFirst();

      if (intake.mealType != MealTypeEnum.unknown) {
        yield intake.mealType!.localizedName(context.appLocalizations);
      }
    }
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
                  title: Text(context.appLocalizations.edit),
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
  final _percentageFormatter = NumberFormat.percentPattern();

  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Intake? intake;
  final Nutrient nutrient;

  IntakeNutrientDenseTile(
    this.intake,
    this.nutrient,
    this.dailyNutrientNormsAndTotals, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final nutrientName = nutrient.name(appLocalizations);

    if (intake == null || intake!.amountG == 0) {
      return AppListTile(
        title: Text(nutrientName),
        trailing: const Text('–'),
        dense: true,
      );
    }

    final amountText =
        intake!.product.getFormattedTotalAmount(nutrient, intake!.amountG);

    final subtitle = _getSubtitle(appLocalizations);

    final clickable = intake!.id != 0;

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
        intake!.consumedAt.toDate(),
        nutrient: nutrient,
      ),
    );
  }

  String? _getSubtitle(AppLocalizations appLocalizations) {
    final nutrientAmount = intake!.getNutrientAmount(nutrient);

    final percentage = dailyNutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .normPercentageWithAmount(nutrientAmount);

    if (percentage != null) {
      return appLocalizations.percentageOfDailyNorm(
        _percentageFormatter.format(percentage),
      );
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final nutrientName = nutrient.name(appLocalizations);
    final percentageFormatter = NumberFormat.percentPattern();

    final percentage = dailyNutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .normPercentage;

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
                child: Text(percentageFormatter.format(percentage)),
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
    final consumptionFormatted = dailyNutrientNormsAndTotals
        .getNutrientConsumptionFormatted(nutrient, appLocalizations);

    return appLocalizations.consumed(consumptionFormatted);
  }

  Widget _leadingTotalConsumptionIndicator(double? percentageRounded) {
    if (percentageRounded == null) {
      return const SizedBox();
    }

    if (percentageRounded > 1) {
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
  final _percentageFormatter = NumberFormat.percentPattern();

  final Date date;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;
  final Nutrient nutrient;

  NutrientDailyNutritionTile(
    this.date,
    this.dailyNutrientNormsAndTotals,
    this.nutrient, {
    super.key,
  });

  NutrientDailyNutritionTile.fromLightReport(
    this.nutrient,
    DailyIntakesLightReport lightReport,
  )   : date = lightReport.date,
        dailyNutrientNormsAndTotals = lightReport.nutrientNormsAndTotals;

  DailyNutrientConsumption get consumption =>
      dailyNutrientNormsAndTotals.getDailyNutrientConsumption(nutrient);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    final percentage = consumption.normPercentage;

    return AppListTile(
      title: Text(_dateFormat.formatDate(date).capitalizeFirst()),
      subtitle: Text(_getSubtitleText(appLocalizations)),
      leading: _leadingTotalConsumptionIndicator(),
      isThreeLine: consumption.normExceeded != null,
      trailing: SizedBox(
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (percentage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(_percentageFormatter.format(percentage)),
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
    final consumptionFormatted =
        dailyNutrientNormsAndTotals.getNutrientConsumptionFormatted(
      nutrient,
      appLocalizations,
    );

    return appLocalizations.consumed(consumptionFormatted);
  }

  String? _getNormExceededText(AppLocalizations appLocalizations) {
    if (consumption.normExceeded == null) {
      return null;
    }

    if (consumption.normExceeded ?? false) {
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
    final percentage = consumption.normPercentage;

    if (percentage == null) {
      return CircleAvatar(
        backgroundColor: Colors.brown,
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

    if (percentage > 1) {
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
  final dateFormat = DateFormat('E, d MMM');
  final _percentageFormat = NumberFormat.percentPattern();

  final Intake intake;
  final Nutrient nutrient;
  final DailyNutrientNormsWithTotals dailyNutrientNormsAndTotals;

  NutrientIntakeTile(
    this.intake,
    this.nutrient,
    this.dailyNutrientNormsAndTotals, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final nutrientAmountFormatted = intake.getNutrientAmountFormatted(nutrient);

    final normExists = dailyNutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .isNormExists;

    return AppListTile(
      title: Text(intake.product.name),
      subtitle: Text(_getSubtitle(context.appLocalizations)),
      leading: SizedBox(
        height: double.infinity,
        child: ProductKindIcon(productKind: intake.product.productKind!),
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

  String? _getConsumptionText(AppLocalizations appLocalizations) {
    final nutrientAmount = intake.getNutrientAmount(nutrient);

    final percentage = dailyNutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .normPercentageWithAmount(nutrientAmount);

    if (percentage != null) {
      return appLocalizations.percentageOfDailyNorm(
        _percentageFormat.format(percentage),
      );
    }

    return null;
  }

  Iterable<String> _getFirstSubtitleLineParts(
    AppLocalizations appLocalizations,
  ) sync* {
    yield intake.getAmountFormatted();

    yield dateFormat.format(intake.consumedAt.toLocal()).capitalizeFirst();

    if (intake.mealType != MealTypeEnum.unknown) {
      yield intake.mealType!.localizedName(appLocalizations);
    }
  }

  String _getSubtitle(AppLocalizations appLocalizations) {
    final firstLine = _getFirstSubtitleLineParts(appLocalizations).join(' | ');

    return [firstLine, _getConsumptionText(appLocalizations)]
        .where((t) => t != null && t.isNotEmpty)
        .join('\n');
  }
}

class NutrientChartSection extends StatelessWidget {
  final List<DailyIntakesLightReport> reports;
  final NutritionSummaryStatistics? nutritionSummaryStatistics;
  final Nutrient nutrient;

  const NutrientChartSection({
    super.key,
    required this.reports,
    required this.nutrient,
    this.nutritionSummaryStatistics,
  });

  Future openWeeklyNutritionScreen(
    BuildContext context,
    NutritionSummaryStatistics? nutritionSummaryStatistics,
    Nutrient nutrient,
  ) {
    return Navigator.pushNamed(
      context,
      Routes.routeNutritionSummary,
      arguments: NutritionSummaryScreenArguments(
        nutritionSummaryStatistics: nutritionSummaryStatistics,
        nutrient: nutrient,
        screenType: NutritionSummaryScreenType.weekly,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().toDate();

    final todaysReport = reports.where((r) => r.date == today).firstOrNull();

    final showGraph =
        reports.any((r) => r.nutrientNormsAndTotals.isAtLeastOneTotalNonZeo());

    String subtitle;
    if (todaysReport == null) {
      subtitle = context.appLocalizations.todayConsumptionWithoutNorm(
        context.appLocalizations.noInfo,
      );
    } else {
      subtitle = context.appLocalizations.todayConsumptionWithoutNorm(
        todaysReport.nutrientNormsAndTotals.getNutrientConsumptionFormatted(
          nutrient,
          context.appLocalizations,
        ),
      );
    }

    return LargeSection(
      title: Text(
        nutrient.consumptionName(context.appLocalizations).overflow,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(subtitle),
      trailing: OutlinedButton(
        onPressed: () => openWeeklyNutritionScreen(
          context,
          nutritionSummaryStatistics,
          nutrient,
        ),
        child: Text(context.appLocalizations.more.toUpperCase()),
      ),
      children: [
        if (showGraph)
          Padding(
            padding: const EdgeInsets.all(8),
            child: NutrientBarChart(
              dailyIntakeLightReports: reports,
              nutrient: nutrient,
              maximumDate: today.toDateTime(),
              minimumDate: today.toDateTime().subtract(const Duration(days: 6)),
              showDataLabels: true,
            ),
          ),
      ],
    );
  }
}
