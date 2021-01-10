import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/extensions/extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog_api_client/model/daily_intakes_report.dart';

import 'bar_chart.dart';

class NutrientWeeklyBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: AspectRatio(
        aspectRatio: 2,
        child: AppBarChart(
          data: _getChartData(),
        ),
      ),
    );
  }

  AppBarChartData _getChartData() {
    final startOfToday = DateTime.now().startOfDay();

    final dailyNutrientConsumptions = dailyIntakeReports
        .map((e) => e.getDailyNutrientConsumption(nutrient))
        .toList();

    final maximumNorm = dailyNutrientConsumptions
        .map((c) => c.norm)
        .where((e) => e != null)
        .max
        ?.toDouble();

    final maximumAmount =
        dailyNutrientConsumptions.map((c) => c.total).max?.toDouble();

    assert(maximumAmount != null, "Maximum amount can not be null");

    double interval;
    if (maximumNorm != null) {
      interval = maximumNorm / 2;

      if (maximumAmount ~/ maximumNorm > 3) {
        interval = maximumNorm;
      }
    }

    final scaleValue = (nutrient != Nutrient.energy) ? 1e-3 : 1.0;

    final days =
        List.generate(7, (d) => maximumDate.add(Duration(days: -d))).reversed;

    final dailyIntakeReportsGrouped = dailyIntakeReports
        .groupBy((v) => _dateFormatter.format(v.date))
        .map((key, values) {
      if (values.length > 1) {
        throw ArgumentError.value(values, "values",
            "Multiple daily intakes with same formatted date");
      }
      return MapEntry(key, values.firstOrNull());
    });

    final groups = days.mapIndexed((i, day) {
      final dateFormatted = _dateFormatter.format(day);
      final dayFormatted = _dayFormatter.format(day).capitalizeFirst();

      final di = dailyIntakeReportsGrouped[dateFormatted];

      if (di == null) {
        return AppBarChartGroup(
          text: dayFormatted,
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

      AppBarChartRod entry = AppBarChartRod(
        tooltip: "$dateFormatted\n$dailyTotalFormatted",
        y: y != null ? y * scaleValue : null,
        barColor: (y != null || y > norm) ? Colors.redAccent : Colors.teal,
      );

      return AppBarChartGroup(
        text: dayFormatted,
        x: i,
        isSelected: di.date.startOfDay().compareTo(startOfToday) == 0,
        rods: [entry],
      );
    }).toList();

    return AppBarChartData(
      groups: groups,
      showLeftTitles: true,
      fitInsideVertically: fitInsideVertically,
      dashedHorizontalLine:
          maximumNorm != null ? maximumNorm * scaleValue : null,
      interval: interval != null ? interval * scaleValue : null,
      maxY: (maximumNorm != null && maximumAmount != null)
          ? max(maximumNorm, maximumAmount) * scaleValue * 1.01
          : null,
    );
  }
}
