import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';

import 'chart.dart';

class DailyTotalIndicatorBarChart extends StatelessWidget {
  final DailyIntake dailyIntake;

  const DailyTotalIndicatorBarChart({
    Key key,
    this.dailyIntake,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              constraints: BoxConstraints(maxWidth: 250),
              child: _buildGraph(
                [
                  IndicatorType.potassium,
                  IndicatorType.proteins,
                  IndicatorType.sodium,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              constraints: BoxConstraints(maxWidth: 250),
              child: _buildGraph(
                [
                  IndicatorType.phosphorus,
                  IndicatorType.energy,
                  IndicatorType.liquids,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraph(List<IndicatorType> types) {
    return AppBarChart(
      data: AppBarChartData(
        fitInsideHorizontally: false,
        groups: _buildChartGroups(types),
      ),
    );
  }

  List<AppBarChartGroup> _buildChartGroups(List<IndicatorType> types) {
    return types.mapIndexed((i, type) {
      final dailyNorm =
          dailyIntake.userIntakeNorms.getIndicatorAmountByType(type);

      final y = dailyIntake.getDailyTotalByType(type) ?? 0;
      final yPercent = min(y.toDouble() / dailyNorm, 1.0);
      final barColor = y > dailyNorm ? Colors.redAccent : Colors.teal;

      final formattedTotal = dailyIntake.getFormattedDailyTotal(type);
      final formattedDailyNorm =
          dailyIntake.userIntakeNorms.getFormattedIndicator(type);

      final entry = AppBarChartRod(
        tooltip: "$formattedTotal iš $formattedDailyNorm",
        y: yPercent,
        barColor: barColor,
        backDrawRodY: 1.0,
      );

      return AppBarChartGroup(
        text: type.name,
        x: i,
        rods: [entry],
      );
    }).toList();
  }
}
