import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'bar_chart.dart';

class NutrientBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

  final Nutrient nutrient;
  final List<DailyIntake> dailyIntakes;

  NutrientBarChart({
    Key key,
    @required this.dailyIntakes,
    @required this.nutrient,
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

    final dailyIntakesSorted = dailyIntakes.sortedBy((e) => e.date);

    final maximumNorm = dailyIntakes
        .map((e) => e.userIntakeNorms.getNutrientAmount(nutrient))
        .max
        .toDouble();

    final maximumAmount =
        dailyIntakes.map((e) => e.getNutrientTotalAmount(nutrient)).max.toDouble();

    var interval = maximumNorm / 2;
    if (maximumAmount ~/ maximumNorm > 3) {
      interval = maximumNorm;
    }

    final scaleValue = (nutrient != Nutrient.energy) ? 1e-3 : 1.0;

    final groups = dailyIntakesSorted.mapIndexed((i, di) {
      final y = di.getNutrientTotalAmount(nutrient).toDouble();
      final norm = di.userIntakeNorms.getNutrientAmount(nutrient);

      final dateFormatted = _dateFormatter.format(di.date);
      final dailyTotalFormatted = di.getNutrientTotalAmountFormatted(nutrient);

      AppBarChartRod entry = AppBarChartRod(
        tooltip: "$dateFormatted\n$dailyTotalFormatted",
        y: y * scaleValue,
        barColor: y > norm ? Colors.redAccent : Colors.teal,
      );

      return AppBarChartGroup(
        text: _dayFormatter.format(di.date).capitalizeFirst(),
        x: i,
        isSelected: di.date.startOfDay().compareTo(startOfToday) == 0,
        rods: [entry],
      );
    }).toList();

    return AppBarChartData(
      groups: groups,
      dashedHorizontalLine: maximumNorm * scaleValue,
      interval: interval * scaleValue,
      maxY: max(maximumNorm, maximumAmount) * scaleValue * 1.01,
    );
  }
}
