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

  // Disable legend temporary due to bug after getting back from route
  // I/flutter ( 1493): ════════════════════════════════════════════════════════════════════════════════════════════════════
  // I/flutter ( 1493): ══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
  // I/flutter ( 1493): The following RangeError was thrown building SfCartesianChart(dirty, dependencies: [_InheritedTheme,
  // I/flutter ( 1493): _EffectiveTickerMode, MediaQuery, _LocalizationsScope-[GlobalKey#edd4d]], state:
  // I/flutter ( 1493): SfCartesianChartState#3f8ba(tickers: tracking 2 tickers)):
  // I/flutter ( 1493): RangeError (index): Invalid value: Only valid value is 0: 1
  // I/flutter ( 1493):
  // I/flutter ( 1493): The relevant error-causing widget was:
  // I/flutter ( 1493):   SfCartesianChart
  // I/flutter ( 1493):   file:///Users/karolis/AndroidStudioProjects/nephrogo/lib/ui/charts/date_time_numeric_chart.dart:41:12
  // I/flutter ( 1493):
  // I/flutter ( 1493): When the exception was thrown, this was the stack:
  // I/flutter ( 1493): #0      List.[] (dart:core-patch/growable_array.dart:177:60)
  // I/flutter ( 1493): #1      SfCartesianChartState._findVisibleSeries (package:syncfusion_flutter_charts/src/chart/base/chart_base.dart:1748:67)
  // I/flutter ( 1493): #2      SfCartesianChartState.build (package:syncfusion_flutter_charts/src/chart/base/chart_base.dart:1224:5)
  // I/flutter ( 1493): #3      StatefulElement.build (package:flutter/src/widgets/framework.dart:4744:28)
  // I/flutter ( 1493): #4      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4627:15)
  // I/flutter ( 1493): #5      StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:4800:11)
  // I/flutter ( 1493): #6      Element.rebuild (package:flutter/src/widgets/framework.dart:4343:5)
  // I/flutter ( 1493): #7      BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:2730:33)
  // I/flutter ( 1493): #8      WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:913:20)
  // I/flutter ( 1493): #9      RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:302:5)
  // I/flutter ( 1493): #10     SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1117:15)
  // I/flutter ( 1493): #11     SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1055:9)
  // I/flutter ( 1493): #12     SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:971:5)
  // I/flutter ( 1493): #16     _invoke (dart:ui/hooks.dart:251:10)
  // I/flutter ( 1493): #17     _drawFrame (dart:ui/hooks.dart:209:3)
  // I/flutter ( 1493): (elided 3 frames from dart:async)
  // I/flutter ( 1493):
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
        isVisible: false,
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
    var maximum = to?.endOfDay();

    double interval;
    var intervalType = DateTimeIntervalType.auto;

    if (minimum != null && maximum != null) {
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
    }

    return DateTimeAxis(
      interval: interval,
      intervalType: intervalType,
      majorGridLines: MajorGridLines(width: 0),
      minimum: minimum,
      maximum: maximum,
    );
  }
}
