import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NumericChart extends StatelessWidget {
  final ChartAxis primaryXAxis;
  final List<XyDataSeries> series;
  final String chartTitleText;
  final String yAxisText;
  final bool showLegend;
  final int decimalPlaces;
  final double interval;
  final double maximumY;
  final bool legendToggleSeriesVisibility;
  final LegendPosition legendPosition;

  const NumericChart({
    Key key,
    required this.primaryXAxis,
    required this.series,
    this.chartTitleText,
    this.yAxisText,
    this.decimalPlaces,
    this.interval,
    this.maximumY,
    bool showLegend,
    LegendPosition legendPosition,
    bool legendToggleSeriesVisibility,
  })  : showLegend = showLegend ?? true,
        legendPosition = legendPosition ?? LegendPosition.top,
        legendToggleSeriesVisibility = legendToggleSeriesVisibility ?? true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: _getChartTitle(),
      plotAreaBorderWidth: 0,
      legend: Legend(
        isVisible: showLegend,
        position: legendPosition,
        overflowMode: LegendItemOverflowMode.wrap,
        toggleSeriesVisibility: legendToggleSeriesVisibility,
      ),
      primaryXAxis: primaryXAxis,
      primaryYAxis: NumericAxis(
        title: _getYAxisTitle(),
        decimalPlaces: decimalPlaces,
        interval: interval,
        maximum: maximumY,
        numberFormat: NumberFormat.decimalPattern(),
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
}
