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
    @required this.primaryXAxis,
    @required this.series,
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
      legend: Legend(
        isVisible: false,
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
