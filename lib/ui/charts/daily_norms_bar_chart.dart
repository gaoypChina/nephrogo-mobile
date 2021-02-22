import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyNormsBarChart extends StatelessWidget {
  final DailyIntakesLightReport dailyIntakeReport;

  const DailyNormsBarChart({
    Key key,
    this.dailyIntakeReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          // majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(
            text: context.appLocalizations.dailyNormsConsumedExplanation,
            textStyle: const TextStyle(fontSize: 12),
          ),
          minimum: 0,
          maximum: _getGraphMax(),
          majorTickLines: MajorTickLines(size: 0),
          numberFormat: NumberFormat.percentPattern(),
        ),
        series: _getTrackerBarSeries(context),
      ),
    );
  }

  double _getGraphMax() {
    final maximumConsumption = Nutrient.values
            .map((n) => dailyIntakeReport.nutrientNormsAndTotals
                .getDailyNutrientConsumption(n)
                .normPercentage)
            .where((n) => n != null)
            .max() ??
        0;

    return max(maximumConsumption, 1.0);
  }

  List<XyDataSeries> _getTrackerBarSeries(BuildContext context) {
    final norms = dailyIntakeReport.nutrientNormsAndTotals;

    final nutrientsWithNorms = Nutrient.values
        .where((n) => norms.getDailyNutrientConsumption(n).isNormExists)
        .toList();

    return [
      BarSeries<Nutrient, String>(
        dataSource: nutrientsWithNorms,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(6)),
        isTrackVisible: true,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: const TextStyle(color: Colors.white),
        ),
        sortFieldValueMapper: (_, i) => i,
        sortingOrder: SortingOrder.descending,
        pointColorMapper: (n, _) {
          if (norms.getDailyNutrientConsumption(n).normPercentage > 1) {
            return Colors.redAccent;
          }
          return Colors.teal;
        },
        enableTooltip: false,
        xValueMapper: (n, _) => n.name(context.appLocalizations),
        yValueMapper: (n, _) {
          return norms.getDailyNutrientConsumption(n).normPercentage;
        },
      ),
    ];
  }
}
