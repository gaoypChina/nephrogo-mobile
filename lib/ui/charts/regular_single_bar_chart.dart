import 'package:flutter/material.dart';
import 'package:nephrogo/models/date.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'date_time_numeric_chart.dart';

class RegularSingleColumnChart<T> extends StatelessWidget {
  static const rodRadius = BorderRadius.vertical(top: Radius.circular(6));

  final List<T> chartData;
  final Date Function(T v) xValueMapper;
  final num Function(T v) yValueMapper;
  final String seriesName;
  final DateTime from;
  final DateTime to;
  final String yAxisTitle;
  final int decimalPlaces;
  final double interval;
  final double maximumY;

  const RegularSingleColumnChart({
    Key key,
    @required this.chartData,
    @required this.yAxisTitle,
    @required this.xValueMapper,
    @required this.yValueMapper,
    @required this.seriesName,
    @required this.from,
    @required this.to,
    this.decimalPlaces,
    this.interval,
    this.maximumY,
  })  : assert(chartData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimeNumericChart(
      series: _getStackedColumnSeries(context),
      showLegend: false,
      yAxisText: yAxisTitle,
      from: from,
      to: to,
      interval: interval,
      decimalPlaces: decimalPlaces,
      maximumY: maximumY,
    );
  }

  List<XyDataSeries> _getStackedColumnSeries(BuildContext context) {
    return [
      ColumnSeries<T, DateTime>(
        dataSource: chartData,
        borderRadius: rodRadius,
        xValueMapper: (T c, _) => xValueMapper(c),
        yValueMapper: (T c, _) => yValueMapper(c),
        name: seriesName,
      ),
    ];
  }
}
