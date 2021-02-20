import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DateTimeNumericChart extends StatelessWidget {
  static const rodTopRadius = BorderRadius.vertical(top: Radius.circular(6));

  final List<XyDataSeries> series;
  final String chartTitleText;
  final String yAxisText;
  final DateTime from;
  final DateTime to;
  final bool singlePointPerDay;
  final bool showLegend;
  final int decimalPlaces;
  final double interval;
  final double maximumY;
  final bool isMultiValuesPerDay;
  final bool legendToggleSeriesVisibility;
  final LegendPosition legendPosition;

  const DateTimeNumericChart({
    Key key,
    @required this.series,
    @required this.from,
    @required this.to,
    this.chartTitleText,
    this.yAxisText,
    this.singlePointPerDay = true,
    this.showLegend = true,
    this.decimalPlaces,
    this.interval,
    this.maximumY,
    this.legendPosition = LegendPosition.top,
    this.legendToggleSeriesVisibility = true,
    this.isMultiValuesPerDay = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: _getChartTitle(),
      plotAreaBorderWidth: 0,
      zoomPanBehavior: ZoomPanBehavior(
        enablePinching: true,
        zoomMode: ZoomMode.x,
      ),
      legend: Legend(
        isVisible: showLegend,
        position: legendPosition,
        overflowMode: LegendItemOverflowMode.wrap,
        toggleSeriesVisibility: legendToggleSeriesVisibility,
      ),
      primaryXAxis: _getDateTimeAxis(),
      primaryYAxis: NumericAxis(
        title: _getYAxisTitle(),
        decimalPlaces: decimalPlaces,
        interval: interval,
        maximum: maximumY,
      ),
      series: series,
      tooltipBehavior: TooltipBehavior(
        decimalPlaces: decimalPlaces,
        enable: true,
        canShowMarker: true,
        shared: true,
      ),
    );
  }

  ChartTitle _getChartTitle() {
    if (chartTitleText != null) {
      return ChartTitle(text: chartTitleText);
    }
    return null;
  }

  AxisTitle _getYAxisTitle() {
    if (yAxisText != null) {
      return AxisTitle(
        text: yAxisText,
        textStyle: const TextStyle(fontSize: 12),
      );
    }

    return null;
  }

  DateTimeAxis _getDateTimeAxis() {
    var minimum = from?.startOfDay();
    final maximum = to?.endOfDay();

    double interval;
    var intervalType = DateTimeIntervalType.auto;

    if (minimum != null && maximum != null) {
      final daysDifference = maximum.difference(minimum).inDays;

      if (daysDifference <= 7) {
        intervalType = DateTimeIntervalType.days;
        interval = 1;
        minimum = minimum.subtract(const Duration(hours: 12));
      }
    }

    return DateTimeAxis(
      interval: interval,
      intervalType: intervalType,
      // dateFormat: DateFormat.Md().add_Hm(),
      majorGridLines: MajorGridLines(width: 0),
      minimum: minimum,
      maximum: maximum,
    );
  }
}
