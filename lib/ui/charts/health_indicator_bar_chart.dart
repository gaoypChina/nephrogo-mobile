import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo_api_client/model/daily_health_status.dart';

import 'blood_pressure_chart.dart';
import 'regular_single_bar_chart.dart';

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
      child: _getChart(),
    );
  }

  Widget _getChart() {
    if (indicator == HealthIndicator.bloodPressure) {
      final bloodPressures =
          dailyHealthStatuses.expand((s) => s.bloodPressures).toList();

      return BloodPressureChart(bloodPressures: bloodPressures);
    }

    return RegularSingleColumnChart<DailyHealthStatus>(
      chartData: dailyHealthStatuses.toList(),
      yAxisTitle: _getIndicatorNameAndDimensionParts().join(", "),
      xValueMapper: (s) => s.date.toDate(),
      yValueMapper: (s) => s.getHealthIndicatorValue(indicator),
      seriesName: indicator.name(appLocalizations),
      from: from,
      to: to,
      decimalPlaces: indicator.decimalPlaces,
      interval: _getInterval(),
      maximumY: _getMaxY(),
    );
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
