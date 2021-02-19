import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'regular_single_bar_chart.dart';

class DailyMealTypeConsumptionColumnSeries extends StatelessWidget {
  final DailyIntakesReport report;
  final Nutrient nutrient;

  const DailyMealTypeConsumptionColumnSeries({
    Key key,
    @required this.report,
    @required this.nutrient,
  })  : assert(report != null),
        assert(nutrient != null),
        super(key: key);

  String _getTitleText(AppLocalizations appLocalizations) {
    final nutrientNorms = report.dailyNutrientNormsAndTotals;
    final nutrientConsumption = report.dailyNutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient);

    final totalFormatted =
        nutrientNorms.getNutrientTotalAmountFormatted(nutrient);

    if (nutrientConsumption.isNormExists) {
      final normFormatted = nutrientNorms.getNutrientNormFormatted(nutrient);

      return appLocalizations.consumptionWithNorm(
        totalFormatted,
        normFormatted,
      );
    }

    return appLocalizations.consumptionWithoutNorm(totalFormatted);
  }

  @override
  Widget build(BuildContext context) {
    final consumptionName = nutrient.consumptionName(context.appLocalizations);
    final scaledDimension = nutrient.scaledDimension;

    return SfCartesianChart(
      title: ChartTitle(text: _getTitleText(context.appLocalizations)),
      plotAreaBorderWidth: 0,
      palette: [
        Colors.orange,
        Colors.teal,
      ],
      legend: Legend(
        isVisible: true,
        position: LegendPosition.top,
      ),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: "$consumptionName, $scaledDimension",
          textStyle: const TextStyle(fontSize: 12),
        ),
        decimalPlaces: nutrient.decimalPlaces,
      ),
      series: _getStackedColumnSeries(context).toList(),
      tooltipBehavior: TooltipBehavior(
        decimalPlaces: nutrient.decimalPlaces,
        enable: true,
        canShowMarker: true,
        shared: true,
      ),
    );
  }

  List<XyDataSeries<DailyMealTypeNutrientConsumption, String>>
      _getStackedColumnSeries(BuildContext context) {
    final dailyMealTypeNutrientConsumptions = report
        .dailyMealTypeNutrientConsumptions(
          nutrient: nutrient,
          includeEmpty: true,
        )
        .toList();

    return [
      StackedColumnSeries<DailyMealTypeNutrientConsumption, String>(
        dataSource: dailyMealTypeNutrientConsumptions,
        xValueMapper: (c, _) =>
            c.mealType.localizedName(context.appLocalizations),
        yValueMapper: (c, _) => c.drinksTotal * nutrient.scale,
        name: context.appLocalizations.drinks,
        borderRadius: RegularSingleColumnChart.rodRadius,
      ),
      StackedColumnSeries<DailyMealTypeNutrientConsumption, String>(
        dataSource: dailyMealTypeNutrientConsumptions,
        xValueMapper: (c, _) =>
            c.mealType.localizedName(context.appLocalizations),
        yValueMapper: (c, _) => c.foodTotal * nutrient.scale,
        name: context.appLocalizations.meals,
        borderRadius: RegularSingleColumnChart.rodRadius,
      ),
    ];
  }
}
