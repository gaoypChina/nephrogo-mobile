import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'numeric_chart.dart';

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
    this.showLegend,
    this.decimalPlaces,
    this.interval,
    this.maximumY,
    this.legendPosition,
    this.legendToggleSeriesVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumericChart(
      primaryXAxis: _getDateTimeAxis(),
      series: _getSeries(),
      chartTitleText: chartTitleText,
      yAxisText: yAxisText,
      decimalPlaces: decimalPlaces,
      interval: interval,
      maximumY: maximumY,
      showLegend: showLegend,
      legendPosition: legendPosition,
      legendToggleSeriesVisibility: legendToggleSeriesVisibility,
    );
  }

  List<XyDataSeries> _getSeries() {
    return [
      ...series,
      LineSeries<Date, DateTime>(
        dataSource: DateUtils.generateDates(
          from.toDate(),
          to.toDate(),
        ).toList(),
        xValueMapper: (d, _) => d,
        yValueMapper: (d, _) => 0,
        isVisibleInLegend: false,
        enableTooltip: false,
        color: Colors.transparent,
      ),
    ];
  }

  DateTimeAxis _getDateTimeAxis() {
    var minimum = from?.startOfDay();
    var maximum = to?.endOfDay();

    double interval;
    var intervalType = DateTimeIntervalType.auto;

    final daysDifference = maximum.difference(minimum).inDays;
    if (daysDifference <= 1) {
      maximum = from.add(const Duration(days: 1));
      intervalType = DateTimeIntervalType.hours;
      interval = 1;
    } else if (daysDifference <= 7) {
      intervalType = DateTimeIntervalType.days;
      interval = 1;
      minimum = minimum.subtract(const Duration(hours: 12));
    }

    return DateTimeAxis(
      interval: interval,
      intervalType: intervalType,
      minimum: minimum,
      maximum: maximum,
    );
  }
}
