import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'date_time_numeric_chart.dart';

class HealthIndicatorBarChart extends StatelessWidget {
  final Date from;
  final Date to;
  final HealthIndicator indicator;
  final List<DailyHealthStatus> dailyHealthStatuses;
  final bool smallMarkers;

  const HealthIndicatorBarChart({
    Key? key,
    required this.dailyHealthStatuses,
    required this.indicator,
    required this.from,
    required this.to,
    this.smallMarkers = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: DateTimeNumericChart(
        series: _getGraphSeries(context),
        yAxisText: _getIndicatorNameAndDimensionParts(context).join(', '),
        from: from.toDateTime(),
        to: to.toDateTime(),
        decimalPlaces: indicator.decimalPlaces,
        interval: _getInterval(),
        maximumY: _getMaxY(),
      ),
    );
  }

  List<XyDataSeries> _getGraphSeries(BuildContext context) {
    switch (indicator) {
      case HealthIndicator.bloodPressure:
        return _getBloodPressureSeries(context);
      case HealthIndicator.pulse:
        return _getPulseSeries(context);
      default:
        return _getDefaultLineSeries(context);
    }
  }

  List<XyDataSeries> _getBloodPressureSeries(BuildContext context) {
    final sortedBloodPressures = dailyHealthStatuses
        .expand((e) => e.bloodPressures)
        .orderBy((e) => e.measuredAt)
        .toList();

    return [
      LineSeries<BloodPressure, DateTime>(
        dataSource: sortedBloodPressures,
        xValueMapper: (c, _) => c.measuredAt.toLocal(),
        yValueMapper: (c, _) => c.systolicBloodPressure,
        markerSettings: _getMarkerSettings(),
        name: context.appLocalizations.healthStatusCreationSystolic,
      ),
      LineSeries<BloodPressure, DateTime>(
        dataSource: sortedBloodPressures,
        xValueMapper: (c, _) => c.measuredAt.toLocal(),
        yValueMapper: (c, _) => c.diastolicBloodPressure,
        markerSettings: _getMarkerSettings(),
        name: context.appLocalizations.healthStatusCreationDiastolic,
      ),
    ];
  }

  List<XyDataSeries> _getPulseSeries(BuildContext context) {
    final sortedPulses = dailyHealthStatuses
        .expand((s) => s.pulses)
        .orderBy((e) => e.measuredAt)
        .toList();

    return [
      LineSeries<Pulse, DateTime>(
        dataSource: sortedPulses,
        xValueMapper: (c, _) => c.measuredAt.toLocal(),
        yValueMapper: (c, _) => c.pulse,
        name: context.appLocalizations.pulse,
        markerSettings: _getMarkerSettings(),
      ),
    ];
  }

  List<XyDataSeries> _getDefaultLineSeries(BuildContext context) {
    return [
      LineSeries<DailyHealthStatus, DateTime>(
        dataSource: dailyHealthStatuses.orderBy((e) => e.date).toList(),
        xValueMapper: (s, _) => s.date.toDateTime(),
        yValueMapper: (s, _) => s.getHealthIndicatorValue(indicator),
        dataLabelMapper: (s, _) =>
            s.getHealthIndicatorFormatted(indicator, context.appLocalizations),
        dataLabelSettings: DataLabelSettings(isVisible: _isShowingDataLabels()),
        name: indicator.name(context.appLocalizations),
        markerSettings: _getMarkerSettings(),
      ),
    ];
  }

  MarkerSettings _getMarkerSettings() {
    final markerSize = smallMarkers ? 4.0 : 8.0;

    return MarkerSettings(
      isVisible: true,
      width: markerSize,
      height: markerSize,
    );
  }

  bool _isShowingDataLabels() {
    switch (indicator) {
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
      case HealthIndicator.swellings:
        return true;
      default:
        return false;
    }
  }

  Iterable<String> _getIndicatorNameAndDimensionParts(
      BuildContext context) sync* {
    yield indicator.name(context.appLocalizations);

    final dimension = indicator.dimension(context.appLocalizations);
    if (dimension != null) {
      yield dimension;
    }
  }

  double? _getMaxY() {
    switch (indicator) {
      case HealthIndicator.bloodPressure:
        return 200;
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        return 5;
      default:
        return null;
    }
  }

  double? _getInterval() {
    switch (indicator) {
      case HealthIndicator.swellings:
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        return 1;
      default:
        return null;
    }
  }
}
