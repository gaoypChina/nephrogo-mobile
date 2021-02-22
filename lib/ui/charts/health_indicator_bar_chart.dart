import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo_api_client/model/blood_pressure.dart';
import 'package:nephrogo_api_client/model/daily_health_status.dart';
import 'package:nephrogo_api_client/model/pulse.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'date_time_numeric_chart.dart';

class HealthIndicatorBarChart extends StatelessWidget {
  final DateTime from;
  final DateTime to;
  final HealthIndicator indicator;
  final List<DailyHealthStatus> dailyHealthStatuses;
  final AppLocalizations appLocalizations;

  const HealthIndicatorBarChart({
    Key key,
    @required this.dailyHealthStatuses,
    @required this.indicator,
    @required this.from,
    @required this.to,
    @required this.appLocalizations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: DateTimeNumericChart(
        series: _getGraphSeries(context),
        showLegend: false,
        yAxisText: _getIndicatorNameAndDimensionParts().join(", "),
        from: from,
        to: to,
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
        .sortedBy((e) => e.measuredAt)
        .toList();

    return [
      LineSeries<BloodPressure, DateTime>(
        dataSource: sortedBloodPressures,
        xValueMapper: (c, _) => c.measuredAt.toLocal(),
        yValueMapper: (c, _) => c.systolicBloodPressure,
        markerSettings: MarkerSettings(isVisible: true),
        name: context.appLocalizations.healthStatusCreationSystolic,
      ),
      LineSeries<BloodPressure, DateTime>(
        dataSource: sortedBloodPressures,
        xValueMapper: (c, _) => c.measuredAt.toLocal(),
        yValueMapper: (c, _) => c.diastolicBloodPressure,
        markerSettings: MarkerSettings(isVisible: true),
        name: context.appLocalizations.healthStatusCreationDiastolic,
      ),
    ];
  }

  List<XyDataSeries> _getPulseSeries(BuildContext context) {
    final sortedPulses = dailyHealthStatuses
        .expand((s) => s.pulses)
        .sortedBy((e) => e.measuredAt)
        .toList();

    return [
      LineSeries<Pulse, DateTime>(
        dataSource: sortedPulses,
        xValueMapper: (c, _) => c.measuredAt.toLocal(),
        yValueMapper: (c, _) => c.pulse,
        name: context.appLocalizations.pulse,
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ];
  }

  List<XyDataSeries> _getDefaultLineSeries(BuildContext context) {
    return [
      LineSeries<DailyHealthStatus, DateTime>(
        dataSource: dailyHealthStatuses.sortedBy((e) => e.date).toList(),
        xValueMapper: (s, _) => s.date.toDate(),
        yValueMapper: (s, _) => s.getHealthIndicatorValue(indicator),
        dataLabelMapper: (s, _) =>
            s.getHealthIndicatorFormatted(indicator, appLocalizations),
        dataLabelSettings: DataLabelSettings(isVisible: _isShowingDataLabels()),
        name: indicator.name(appLocalizations),
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ];
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

  Iterable<String> _getIndicatorNameAndDimensionParts() sync* {
    yield indicator.name(appLocalizations);

    final dimension = indicator.dimension(appLocalizations);
    if (dimension != null) {
      yield dimension;
    }
  }

  double _getMaxY() {
    switch (indicator) {
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        return 5;
      default:
        return null;
    }
  }

  double _getInterval() {
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
