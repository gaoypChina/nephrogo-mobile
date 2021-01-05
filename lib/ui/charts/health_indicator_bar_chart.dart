import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog_api_client/model/user_health_status_report.dart';

import 'bar_chart.dart';

class HealthIndicatorBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

  final HealthIndicator indicator;
  final UserHealthStatusReport userHealthStatusReport;

  HealthIndicatorBarChart({
    Key key,
    @required this.userHealthStatusReport,
    @required this.indicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: AspectRatio(
        aspectRatio: 2,
        child: AppBarChart(
          data: _getChartData(),
        ),
      ),
    );
  }

  AppBarChartData _getChartData() {
    final startOfToday = DateTime.now().startOfDay();

    final dailyHealthStatusesSorted = userHealthStatusReport.dailyHealthStatuses
        .toList()
        .sortedBy((e) => e.date);

    final groups = dailyHealthStatusesSorted.mapIndexed((i, report) {
      final dhs = report.status;
      final dateFormatted = _dateFormatter.format(report.date);

      final y = dhs?.getHealthIndicatorValue(indicator);
      final dailyTotalFormatted = dhs?.getHealthIndicatorFormatted(indicator);

      List<AppBarChartRodStackItem> rodStackItems;
      if (y != null && indicator == HealthIndicator.bloodPressure) {
        rodStackItems = [
          AppBarChartRodStackItem(
              0, dhs.diastolicBloodPressure.toDouble(), Colors.orange),
          AppBarChartRodStackItem(dhs.diastolicBloodPressure.toDouble(),
              dhs.systolicBloodPressure.toDouble() - 1, Colors.teal),
        ];
      }

      final rod = AppBarChartRod(
        tooltip: "$dateFormatted\n$dailyTotalFormatted",
        y: y ?? 0,
        barColor: Colors.teal,
        rodStackItems: rodStackItems,
      );

      return AppBarChartGroup(
        text: _dayFormatter.format(report.date).capitalizeFirst(),
        x: i,
        isSelected: report.date.startOfDay().compareTo(startOfToday) == 0,
        rods: [rod],
      );
    }).toList();

    return AppBarChartData(
      groups: groups,
      interval: _getInterval(),
      maxY: _getMaxY(),
      minY: _getMinY(),
    );
  }

  double _getMinY() {
    if (indicator == HealthIndicator.bloodPressure) {
      return 40;
    }

    return null;
  }

  double _getMaxY() {
    // TODO remove return after API is fixed
    return null;
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
      case HealthIndicator.bloodPressure:
        return 30;
      case HealthIndicator.weight:
        return 25;
      case HealthIndicator.urine:
        return 200;
      case HealthIndicator.numberOfSwellings:
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        // TODO Change to 1 after API is fixed
        return 50;
      default:
        throw ArgumentError.value(
          this,
          "healthIndicator",
          "Unable to map indicator to interval",
        );
    }
  }
}
