import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog_api_client/model/daily_health_status.dart';

import 'bar_chart.dart';

class HealthIndicatorWeeklyBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

  final DateTime maximumDate;
  final HealthIndicator indicator;
  final List<DailyHealthStatus> dailyHealthStatuses;
  final AppLocalizations appLocalizations;

  HealthIndicatorWeeklyBarChart({
    Key key,
    @required this.dailyHealthStatuses,
    @required this.indicator,
    @required this.maximumDate,
    @required this.appLocalizations,
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

    final days =
        List.generate(7, (d) => maximumDate.add(Duration(days: -d))).reversed;

    final dailyHealthStatusesGrouped = dailyHealthStatuses
        .groupBy((v) => _dateFormatter.format(v.date))
        .map((key, values) {
      if (values.length > 1) {
        throw ArgumentError.value(values, "values",
            "Multiple daily health statuses with same formatted date");
      }
      return MapEntry(key, values.firstOrNull());
    });

    final groups = days.mapIndexed((i, day) {
      final dhs = dailyHealthStatusesGrouped[_dateFormatter.format(day)];

      final dateFormatted = _dateFormatter.format(day);
      final dayFormatted = _dayFormatter.format(day).capitalizeFirst();

      if (dhs == null) {
        return AppBarChartGroup(
          text: dayFormatted,
          x: i,
          rods: [
            AppBarChartRod(
              tooltip: dateFormatted,
              y: 0,
              barColor: _getColor(0),
            )
          ],
        );
      }

      final y = dhs.getHealthIndicatorValue(indicator);
      final dailyTotalFormatted =
          dhs.getHealthIndicatorFormatted(indicator, appLocalizations);

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
        y: y,
        barColor: _getColor(y),
        rodStackItems: rodStackItems,
      );

      return AppBarChartGroup(
        text: dayFormatted,
        x: i,
        isSelected: dhs.date.startOfDay().compareTo(startOfToday) == 0,
        rods: [rod],
      );
    }).toList();

    return AppBarChartData(
      groups: groups,
      showLeftTitles: _showLeftTitles(),
      interval: _getInterval(),
      maxY: _getMaxY(),
      minY: _getMinY(),
    );
  }

  bool _showLeftTitles() {
    switch (indicator) {
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        return false;
      default:
        return true;
    }
  }

  double _getMinY() {
    if (indicator == HealthIndicator.bloodPressure) {
      return 40;
    }

    return null;
  }

  _getColor(double y) {
    switch (indicator) {
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        if (y > 3) {
          return Colors.deepOrange;
        }
        return Colors.teal;
      default:
        return Colors.teal;
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
      case HealthIndicator.bloodPressure:
        return 30;
      case HealthIndicator.weight:
        return 25;
      case HealthIndicator.urine:
        return 50;
      case HealthIndicator.numberOfSwellings:
      case HealthIndicator.severityOfSwelling:
      case HealthIndicator.wellBeing:
      case HealthIndicator.appetite:
      case HealthIndicator.shortnessOfBreath:
        return 1;
      default:
        throw ArgumentError.value(
          this,
          "healthIndicator",
          "Unable to map indicator to interval",
        );
    }
  }
}
