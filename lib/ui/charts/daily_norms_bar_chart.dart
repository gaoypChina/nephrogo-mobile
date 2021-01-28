import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/graph.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report.dart';

import 'bar_chart.dart';

class DailyNormsBarChart extends StatelessWidget {
  final DailyIntakesReport dailyIntakeReport;

  const DailyNormsBarChart({
    Key key,
    this.dailyIntakeReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appLocalizations = AppLocalizations.of(context);

    final nutrientsWithNorms = Nutrient.values
        .where((n) =>
            dailyIntakeReport.getDailyNutrientConsumption(n).norm != null)
        .toList();

    final firstNutrientGroup = nutrientsWithNorms.take(3).toList();
    final secondNutrientGroup = nutrientsWithNorms.skip(3).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (final group in [firstNutrientGroup, secondNutrientGroup])
            if (group.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  constraints: BoxConstraints(maxWidth: 250),
                  child: _buildGraph(_appLocalizations, group),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildGraph(AppLocalizations appLocalizations, List<Nutrient> types) {
    return AppBarChart(
      data: AppBarChartData(
        fitInsideHorizontally: false,
        fitInsideVertically: false,
        groups: _buildChartGroups(appLocalizations, types),
      ),
    );
  }

  List<AppBarChartGroup> _buildChartGroups(
    AppLocalizations appLocalizations,
    List<Nutrient> nutrients,
  ) {
    return nutrients.mapIndexed((i, nutrient) {
      final dailyNutrientConsumption =
          dailyIntakeReport.getDailyNutrientConsumption(nutrient);

      final rawYPercent = dailyNutrientConsumption.total.toDouble() /
          dailyNutrientConsumption.norm;

      var yPercent = rawYPercent;
      Color barColor = yPercent > 1.0 ? Colors.redAccent : Colors.teal;
      if (dailyNutrientConsumption.total == 0) {
        barColor = Colors.transparent;
        yPercent = 1;
      }

      final formattedTotal =
          dailyIntakeReport.getNutrientTotalAmountFormatted(nutrient);
      final formattedNorm =
          dailyIntakeReport.getNutrientNormFormatted(nutrient);

      final entry = AppBarChartRod(
        tooltip: appLocalizations.todayConsumptionWithNormTooltip(
          (rawYPercent * 100).round().toString(),
          formattedTotal,
          formattedNorm,
        ),
        y: min(yPercent, 1.0),
        barColor: barColor,
        backDrawRodY: 1.0,
      );

      return AppBarChartGroup(
        text: nutrient.name(appLocalizations),
        x: i,
        rods: [entry],
      );
    }).toList();
  }
}
