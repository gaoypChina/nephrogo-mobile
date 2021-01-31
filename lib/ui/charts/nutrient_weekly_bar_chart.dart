import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/models/graph.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report.dart';

import 'bar_chart.dart';

class NutrientWeeklyBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

  final Date today = Date(DateTime.now());

  final Nutrient nutrient;
  final DateTime maximumDate;
  final List<DailyIntakesReport> dailyIntakeReports;
  final bool fitInsideVertically;

  NutrientWeeklyBarChart({
    Key key,
    @required this.dailyIntakeReports,
    @required this.nutrient,
    @required this.maximumDate,
    this.fitInsideVertically = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: AspectRatio(
        aspectRatio: 2,
        child: AppBarChart(
          data: _getChartData(AppLocalizations.of(context)),
        ),
      ),
    );
  }

  AppBarChartData _getChartData(AppLocalizations appLocalizations) {
    final sortedDailyIntakeReports =
        dailyIntakeReports.sortedBy((e) => e.date).toList();

    final dailyNutrientConsumptions = dailyIntakeReports
        .map((e) => e.getDailyNutrientConsumption(nutrient))
        .toList();

    final lastNorm = sortedDailyIntakeReports
        .lastOrNull()
        ?.getDailyNutrientConsumption(nutrient)
        ?.norm
        ?.toDouble();

    final maximumAmount =
        dailyNutrientConsumptions.map((c) => c.total).max?.toDouble();

    assert(maximumAmount != null, 'Maximum amount can not be null');

    double interval;
    if (lastNorm != null) {
      interval = lastNorm / 2;

      if (maximumAmount ~/ lastNorm > 3) {
        interval = lastNorm;
      }
    }

    final scaleValue =
        (nutrient == Nutrient.energy || nutrient == Nutrient.liquids)
            ? 1.0
            : 1e-3;

    final days =
        List.generate(7, (d) => Date(maximumDate.add(Duration(days: -d))))
            .reversed;

    final dailyIntakeReportsGrouped =
        dailyIntakeReports.groupBy((v) => Date(v.date)).map((key, values) {
      if (values.length > 1) {
        throw ArgumentError.value(values, 'values',
            'Multiple daily intakes with same formatted date');
      }
      return MapEntry(key, values.firstOrNull());
    });

    final groups = days.mapIndexed((i, day) {
      final di = dailyIntakeReportsGrouped[day];

      final dateFormatted = _dateFormatter.format(day);
      final dayFormatted = _dayFormatter.format(day).capitalizeFirst();

      if (di == null) {
        return AppBarChartGroup(
          text: dayFormatted,
          isSelected: day.compareTo(today) == 0,
          x: i,
          rods: [
            AppBarChartRod(
              tooltip: dateFormatted,
              y: 0,
              barColor: Colors.teal,
            )
          ],
        );
      }

      final consumption = di.getDailyNutrientConsumption(nutrient);

      final y = consumption.total.toDouble();
      final norm = consumption.norm;

      final dailyTotalFormatted = di.getNutrientTotalAmountFormatted(nutrient);
      var tooltip = '$dateFormatted\n$dailyTotalFormatted';

      final normFormatted = di.getNutrientNormFormatted(nutrient);
      if (normFormatted != null) {
        final percent = (y / norm * 100).round().toString();
        tooltip = appLocalizations.consumptionTooltipWithNorm(
            dateFormatted, percent, dailyTotalFormatted, normFormatted);
      }

      final entry = AppBarChartRod(
        tooltip: tooltip,
        y: y != null ? y * scaleValue : null,
        barColor: (norm != null && y > norm) ? Colors.redAccent : Colors.teal,
      );

      return AppBarChartGroup(
        text: dayFormatted,
        x: i,
        isSelected: day.compareTo(today) == 0,
        rods: [entry],
      );
    }).toList();

    return AppBarChartData(
      groups: groups,
      showLeftTitles: true,
      fitInsideVertically: fitInsideVertically,
      dashedHorizontalLine: lastNorm != null ? lastNorm * scaleValue : null,
      interval: interval != null ? interval * scaleValue : null,
      maxY: (lastNorm != null && maximumAmount != null)
          ? max(lastNorm, maximumAmount) * scaleValue * 1.01
          : null,
    );
  }
}
