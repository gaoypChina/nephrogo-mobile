import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog_api_client/model/daily_intake.dart';

import 'bar_chart.dart';

class TodayNutrientsConsumptionBarChart extends StatelessWidget {
  final DailyIntake dailyIntake;

  const TodayNutrientsConsumptionBarChart({
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
                  Nutrient.potassium,
                  Nutrient.proteins,
                  Nutrient.sodium,
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
                  Nutrient.phosphorus,
                  Nutrient.energy,
                  Nutrient.liquids,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraph(List<Nutrient> types) {
    return AppBarChart(
      data: AppBarChartData(
        fitInsideHorizontally: false,
        groups: _buildChartGroups(types),
      ),
    );
  }

  List<AppBarChartGroup> _buildChartGroups(List<Nutrient> types) {
    return types.mapIndexed((i, type) {
      final dailyNorm = dailyIntake.userIntakeNorms.getNutrientAmount(type);

      final y = dailyIntake.getNutrientTotalAmount(type) ?? 0;
      final yPercent = min(y.toDouble() / dailyNorm, 1.0);
      final barColor = y > dailyNorm ? Colors.redAccent : Colors.teal;

      final formattedTotal = dailyIntake.getNutrientTotalAmountFormatted(type);
      final formattedDailyNorm =
          dailyIntake.userIntakeNorms.getNutrientAmountFormatted(type);

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
