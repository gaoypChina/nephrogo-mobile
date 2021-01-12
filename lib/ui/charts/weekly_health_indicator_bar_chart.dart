import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/extensions/string_extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/models/graph.dart';
import 'package:nephrolog_api_client/model/daily_health_status.dart';

import 'bar_chart.dart';

class HealthIndicatorWeeklyBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

  final Date today = Date(DateTime.now());
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
    final days =
        List.generate(7, (d) => Date(maximumDate.add(Duration(days: -d))))
            .reversed;

    final dailyHealthStatusesGrouped =
        dailyHealthStatuses.groupBy((v) => Date(v.date)).map((key, values) {
      if (values.length > 1) {
        throw ArgumentError.value(values, "values",
            "Multiple daily health statuses with same formatted date");
      }
      return MapEntry(key, values.firstOrNull());
    });

    final groups = days.mapIndexed((i, day) {
      final dhs = dailyHealthStatusesGrouped[Date(day)];

      final dayFormatted = _dayFormatter.format(day).capitalizeFirst();
      final dateFormatted = _dateFormatter.format(day);

      if (dhs == null || !dhs.isIndicatorExists(indicator)) {
        return AppBarChartGroup(
          text: dayFormatted,
          isSelected: day.compareTo(today) == 0,
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
        isSelected: day.compareTo(today) == 0,
        rods: [rod],
      );
    }).toList();

    return AppBarChartData(
      groups: groups,
      showLeftTitles: _showLeftTitles(),
      interval: _getInterval(),
      maxY: _getMaxY(),
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
      case HealthIndicator.numberOfSwellings:
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
