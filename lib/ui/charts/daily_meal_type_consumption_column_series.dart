import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/ui/charts/date_time_numeric_chart.dart';
import 'package:nephrogo/ui/charts/numeric_chart.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyMealTypeConsumptionColumnSeries extends StatelessWidget {
  final DailyIntakesReport report;
  final Nutrient nutrient;

  const DailyMealTypeConsumptionColumnSeries({
    super.key,
    required this.report,
    required this.nutrient,
  });

  String _getTitleText(AppLocalizations appLocalizations) {
    final consumptionFormatted = report.dailyNutrientNormsAndTotals
        .getNutrientConsumptionFormatted(nutrient, appLocalizations);

    return appLocalizations.consumed(consumptionFormatted);
  }

  @override
  Widget build(BuildContext context) {
    final consumptionName = nutrient.consumptionName(context.appLocalizations);
    final scaledDimension = nutrient.scaledDimension;

    return NumericChart(
      chartTitleText: _getTitleText(context.appLocalizations),
      primaryXAxis: CategoryAxis(),
      series: _getStackedColumnSeries(context).toList(),
      yAxisText: '$consumptionName, $scaledDimension',
      decimalPlaces: nutrient.decimalPlaces,
      showLegend: true,
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
        color: Colors.orange,
      ),
      StackedColumnSeries<DailyMealTypeNutrientConsumption, String>(
        dataSource: dailyMealTypeNutrientConsumptions,
        xValueMapper: (c, _) =>
            c.mealType.localizedName(context.appLocalizations),
        yValueMapper: (c, _) => c.foodTotal * nutrient.scale,
        name: context.appLocalizations.meals,
        borderRadius: DateTimeNumericChart.rodTopRadius,
        color: Colors.teal,
      ),
    ];
  }
}
