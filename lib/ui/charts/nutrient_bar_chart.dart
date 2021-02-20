import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'date_time_numeric_chart.dart';

class NutrientBarChart extends StatelessWidget {
  final Nutrient nutrient;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final List<DailyIntakesLightReport> dailyIntakeLightReports;

  const NutrientBarChart({
    Key key,
    @required this.dailyIntakeLightReports,
    @required this.nutrient,
    @required this.minimumDate,
    @required this.maximumDate,
  }) : super(key: key);

  double get _dailyNorm {
    return dailyIntakeLightReports
        .maxBy((index, e) => e.date)
        ?.nutrientNormsAndTotals
        ?.getDailyNutrientConsumption(nutrient)
        ?.norm
        ?.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1.5, child: _cherChart(context));
  }

  Widget _cherChart(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final nutrientConsumptionName = nutrient.consumptionName(appLocalizations);

    return DateTimeNumericChart(
      series: _getStackedColumnSeries(context).toList(),
      yAxisText: "$nutrientConsumptionName, ${nutrient.scaledDimension}",
      legendToggleSeriesVisibility: false,
      from: minimumDate,
      to: maximumDate,
      decimalPlaces: nutrient.decimalPlaces,
      legendPosition: LegendPosition.bottom,
      showLegend: _dailyNorm != null,
    );
  }

  Iterable<XyDataSeries> _getStackedColumnSeries(BuildContext context) sync* {
    yield ColumnSeries<DailyIntakesLightReport, DateTime>(
      dataSource: dailyIntakeLightReports,
      borderRadius: DateTimeNumericChart.rodTopRadius,
      xValueMapper: (report, _) => report.date.toDate(),
      yValueMapper: (report, _) {
        final total = report.nutrientNormsAndTotals
            .getDailyNutrientConsumption(nutrient)
            .total;

        return total * nutrient.scale;
      },
      pointColorMapper: (report, _) => _barColor(report),
      sortFieldValueMapper: (r, _) => r.date,
      name: nutrient.name(context.appLocalizations),
      color: Colors.teal,
      isVisibleInLegend: false,
    );

    final dailyNormSeries = _getDailyNormLineSeries(context);
    if (dailyNormSeries != null) {
      yield dailyNormSeries;
    }
  }

  XyDataSeries _getDailyNormLineSeries(BuildContext context) {
    if (_dailyNorm == null) {
      return null;
    }

    final scaledDailyNorm = _dailyNorm * nutrient.scale;
    final dates = DateUtils.generateDates(
      minimumDate.subtract(const Duration(days: 1)).toDate(),
      maximumDate.add(const Duration(days: 1)).toDate(),
    ).toList();

    return LineSeries<Date, DateTime>(
      dataSource: dates,
      xValueMapper: (date, _) => date,
      yValueMapper: (date, _) => scaledDailyNorm,
      dashArray: [10, 10],
      width: 3,
      opacity: 0.8,
      color: Colors.blue,
      name: context.appLocalizations.dailyNorm,
    );
  }

  Color _barColor(DailyIntakesLightReport report) {
    final normExceeded = report.nutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .normExceeded;

    if (normExceeded == null) {
      return Colors.grey;
    } else if (normExceeded) {
      return Colors.redAccent;
    } else {
      return Colors.teal;
    }
  }
}
