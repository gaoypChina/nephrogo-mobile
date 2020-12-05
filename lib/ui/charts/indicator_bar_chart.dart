import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'chart.dart';

class IndicatorBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();

  final List<DailyIntake> dailyIntakes;
  final IndicatorType type;

  const IndicatorBarChart({
    Key key,
    @required this.dailyIntakes,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maximumRatio =
        dailyIntakes.map((e) => e.getIndicatorConsumptionRatio(type)).max;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: AspectRatio(
        aspectRatio: 2,
        child: AppBarChart(
          data: AppBarChartData(
            groups: _getChartGroups(),
            horizontalLinesInterval: 1,
            maxY: max(maximumRatio, 1.01),
          ),
        ),
      ),
    );
  }

  List<AppBarChartGroup> _getChartGroups() {
    return dailyIntakes.mapIndexed((i, di) {
      final ratio = di.getIndicatorConsumptionRatio(type);

      AppBarChartRod entry = AppBarChartRod(
        tooltip: di.getFormattedDailyTotal(type),
        y: ratio,
        barColor: ratio > 1.0 ? Colors.redAccent : Colors.teal,
      );

      return AppBarChartGroup(
        text: _dayFormatter.format(di.date).capitalizeFirst(),
        x: i,
        rods: entry != null ? [entry] : [],
      );
    }).toList();
  }
}
