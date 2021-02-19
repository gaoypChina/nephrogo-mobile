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
        isMultiValuesPerDay: indicator.isMultiValuesPerDay,
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
        return _getDefaultColumnSeries(context);
    }
  }

  List<XyDataSeries> _getBloodPressureSeries(BuildContext context) {
    final sortedBloodPressures = dailyHealthStatuses
        .expand((e) => e.bloodPressures)
        .sortedBy((e) => e.measuredAt)
        .toList();

    return [
      RangeAreaSeries<BloodPressure, DateTime>(
        dataSource: sortedBloodPressures,
        xValueMapper: (c, _) => c.measuredAt.toLocal(),
        lowValueMapper: (c, _) => c.diastolicBloodPressure,
        highValueMapper: (c, _) => c.systolicBloodPressure,
        borderDrawMode: RangeAreaBorderMode.excludeSides,
        markerSettings: MarkerSettings(isVisible: true),
        borderWidth: 2,
        opacity: 0.5,
        borderColor: const Color.fromRGBO(75, 135, 185, 1),
        name: context.appLocalizations.healthStatusCreationBloodPressure,
      ),
    ];
  }

  List<XyDataSeries> _getPulseSeries(BuildContext context) {
    final sortedPulses = dailyHealthStatuses
        .expand((s) => s.pulses)
        .sortedBy((e) => e.measuredAt)
        .toList();

    return [
      AreaSeries<Pulse, DateTime>(
        dataSource: sortedPulses,
        xValueMapper: (c, _) => c.measuredAt.toLocal(),
        yValueMapper: (c, _) => c.pulse,
        name: context.appLocalizations.pulse,
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ];
  }

  List<XyDataSeries> _getDefaultColumnSeries(BuildContext context) {
    return [
      ColumnSeries<DailyHealthStatus, DateTime>(
        dataSource: dailyHealthStatuses.toList(),
        borderRadius: DateTimeNumericChart.rodTopRadius,
        xValueMapper: (s, _) => s.date.toDate(),
        yValueMapper: (s, _) => s.getHealthIndicatorValue(indicator),
        name: indicator.name(appLocalizations),
      ),
    ];
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
