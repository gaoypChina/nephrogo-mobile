import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/ui/charts/date_time_numeric_chart.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NutrientBarChart extends StatelessWidget {
  final _percentFormat = NumberFormat.percentPattern();

  final Nutrient nutrient;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final List<DailyIntakesLightReport> dailyIntakeLightReports;
  final bool showDataLabels;

  NutrientBarChart({
    super.key,
    required this.dailyIntakeLightReports,
    required this.nutrient,
    required this.minimumDate,
    required this.maximumDate,
    required this.showDataLabels,
  });

  double? get _dailyNorm {
    return dailyIntakeLightReports
        .maxBy((e) => e.date)
        ?.nutrientNormsAndTotals
        .getDailyNutrientConsumption(nutrient)
        .norm
        ?.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1.5, child: _cherChart(context));
  }

  Widget _cherChart(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    final nutrientConsumptionName = nutrient.consumptionName(appLocalizations);

    return DateTimeNumericChart(
      series: _getColumnSeries(context).toList(),
      yAxisText: '$nutrientConsumptionName, ${nutrient.scaledDimension}',
      legendToggleSeriesVisibility: false,
      from: minimumDate,
      to: maximumDate,
      decimalPlaces: nutrient.decimalPlaces,
      legendPosition: LegendPosition.bottom,
      showLegend: _dailyNorm != null,
    );
  }

  Iterable<XyDataSeries> _getColumnSeries(BuildContext context) sync* {
    final lastReport = dailyIntakeLightReports.maxBy((r) => r.date);

    yield ColumnSeries<DailyIntakesLightReport, DateTime>(
      dataSource: dailyIntakeLightReports.orderBy((e) => e.date).toList(),
      borderRadius: DateTimeNumericChart.rodTopRadius,
      xValueMapper: (report, _) => report.date.toDateTime(),
      yValueMapper: (report, _) {
        final total = report.nutrientNormsAndTotals
            .getDailyNutrientConsumption(nutrient)
            .total;

        return total * nutrient.scale;
      },
      dataLabelMapper: (report, _) {
        final percent = report.nutrientNormsAndTotals
            .getDailyNutrientConsumption(nutrient)
            .normPercentage;
        if (percent != null) {
          return _percentFormat.format(percent);
        } else {
          return report.nutrientNormsAndTotals
              .getNutrientTotalAmountFormattedNoDim(nutrient);
        }
      },
      pointColorMapper: (report, _) => _barColor(report),
      dataLabelSettings: DataLabelSettings(
        isVisible: showDataLabels,
        labelAlignment: ChartDataLabelAlignment.outer,
        showZeroValue: false,
        textStyle: const TextStyle(fontSize: 10),
      ),
      name: nutrient.name(context.appLocalizations),
      color: lastReport != null ? _barColor(lastReport) : Colors.teal,
      isVisibleInLegend: false,
    );

    final dailyNormSeries = _getDailyNormLineSeries(context);
    if (dailyNormSeries != null) {
      yield dailyNormSeries;
    }
  }

  XyDataSeries? _getDailyNormLineSeries(BuildContext context) {
    if (_dailyNorm == null) {
      return null;
    }

    final scaledDailyNorm = _dailyNorm! * nutrient.scale;
    final dates = DateHelper.generateDates(
      minimumDate.subtract(const Duration(days: 1)).toDate(),
      maximumDate.add(const Duration(days: 1)).toDate(),
    ).toList();

    return LineSeries<Date, DateTime>(
      dataSource: dates,
      xValueMapper: (date, _) => date.toDateTime(),
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
      return Colors.brown;
    } else if (normExceeded) {
      return Colors.redAccent;
    } else {
      return Colors.teal;
    }
  }
}
