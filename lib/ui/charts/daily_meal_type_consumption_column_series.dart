import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(
        text: nutrient.consumptionName(context.appLocalizations),
      ),
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
        numberFormat: NumberFormat.percentPattern(),
      ),
      series: _getStackedColumnSeries(context).toList(),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        canShowMarker: true,
        shared: true,
      ),
    );
  }

  List<StackedColumnSeries<DailyMealTypeNutrientConsumption, String>>
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
        yValueMapper: (c, _) => c.drinksPercentage,
        name: context.appLocalizations.drinks,
      ),
      StackedColumnSeries<DailyMealTypeNutrientConsumption, String>(
        dataSource: dailyMealTypeNutrientConsumptions,
        xValueMapper: (c, _) =>
            c.mealType.localizedName(context.appLocalizations),
        yValueMapper: (c, _) => c.foodPercentage,
        name: context.appLocalizations.meals,
      ),
    ];
  }
}
