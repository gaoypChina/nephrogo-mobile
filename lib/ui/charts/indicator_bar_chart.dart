import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'chart.dart';

class IndicatorBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

  final IndicatorType type;
  final List<DailyIntake> dailyIntakes;

  IndicatorBarChart({
    Key key,
    @required this.dailyIntakes,
    @required this.type,
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
        .map((e) => e.userIntakeNorms.getIndicatorAmountByType(type))
        .max
        .toDouble();

    final maximumAmount =
        dailyIntakes.map((e) => e.getDailyTotalByType(type)).max.toDouble();

    var interval = maximumNorm / 2;
    if (maximumAmount ~/ maximumNorm > 3) {
      interval = maximumNorm;
    }

    final scaleValue = (type != IndicatorType.energy) ? 1e-3 : 1.0;

    final groups = dailyIntakesSorted.mapIndexed((i, di) {
      final y = di.getDailyTotalByType(type).toDouble();
      final norm = di.userIntakeNorms.getIndicatorAmountByType(type);

      final dateFormatted = _dateFormatter.format(di.date);
      final dailyTotalFormatted = di.getFormattedDailyTotal(type);

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
