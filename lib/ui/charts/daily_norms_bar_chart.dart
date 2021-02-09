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
            dailyIntakeReport.dailyNutrientNormsAndTotals
                .getDailyNutrientConsumption(n)
                .norm !=
            null)
        .toList();

    final firstNutrientGroup = nutrientsWithNorms.take(3).toList();
    final secondNutrientGroup = nutrientsWithNorms.skip(3).take(3).toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildGroup(_appLocalizations, firstNutrientGroup),
          ),
          if (secondNutrientGroup.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: _buildGroup(_appLocalizations, firstNutrientGroup),
            )
        ],
      ),
    );
  }

  Widget _buildGroup(AppLocalizations appLocalizations, List<Nutrient> types) {
    return Container(
      height: 100,
      constraints: const BoxConstraints(maxWidth: 280),
      child: _buildGraph(appLocalizations, types),
    );
  }

  Widget _buildGraph(AppLocalizations appLocalizations, List<Nutrient> types) {
    return AppBarChart(
      data: AppBarChartData(
        barWidth: 28,
        groups: _buildChartGroups(appLocalizations, types),
      ),
    );
  }

  List<AppBarChartGroup> _buildChartGroups(
    AppLocalizations appLocalizations,
    List<Nutrient> nutrients,
  ) {
    return nutrients.mapIndexed((i, nutrient) {
      final dailyNutrientConsumption = dailyIntakeReport
          .dailyNutrientNormsAndTotals
          .getDailyNutrientConsumption(nutrient);

      final rawYPercent = dailyNutrientConsumption.total.toDouble() /
          dailyNutrientConsumption.norm;

      var yPercent = rawYPercent;
      Color barColor = yPercent > 1.0 ? Colors.redAccent : Colors.teal;
      if (dailyNutrientConsumption.total == 0) {
        barColor = Colors.transparent;
        yPercent = 1;
      }

      final formattedTotal = dailyIntakeReport.dailyNutrientNormsAndTotals
          .getNutrientTotalAmountFormatted(nutrient);
      final formattedNorm = dailyIntakeReport.dailyNutrientNormsAndTotals
          .getNutrientNormFormatted(nutrient);

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

      final nutrientName = nutrient.name(appLocalizations);

      return AppBarChartGroup(
        text: '$nutrientName\n${(rawYPercent * 100).round()}%',
        x: i,
        rods: [entry],
      );
    }).toList();
  }
}
