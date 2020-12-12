import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'bar_chart.dart';

class HealthIndicatorBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

  final HealthIndicator indicator;
  final List<DailyHealthStatus> dailyHealthStatuses;

  HealthIndicatorBarChart({
    Key key,
    @required this.dailyHealthStatuses,
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

    final dailyHealthStatusesSorted =
        dailyHealthStatuses.sortedBy((e) => e.date);

    final groups = dailyHealthStatusesSorted.mapIndexed((i, dhs) {
      final y = dhs.getHealthIndicatorValue(indicator);

      final dateFormatted = _dateFormatter.format(dhs.date);
      final dailyTotalFormatted = dhs.getHealthIndicatorFormatted(indicator);

      List<AppBarChartRod> entries = [];

      if (y != null) {
        List<AppBarChartRodStackItem> rodStackItems;

        if (indicator == HealthIndicator.bloodPressure) {
          rodStackItems = [
            AppBarChartRodStackItem(
                0, dhs.diastolicBloodPressure.toDouble(), Colors.orange),
            AppBarChartRodStackItem(dhs.diastolicBloodPressure.toDouble(),
                dhs.systolicBloodPressure.toDouble() - 1, Colors.teal),
          ];
        }

        entries.add(
          AppBarChartRod(
            tooltip: "$dateFormatted\n$dailyTotalFormatted",
            y: y,
            barColor: Colors.teal,
            rodStackItems: rodStackItems,
          ),
        );
      }

      return AppBarChartGroup(
        text: _dayFormatter.format(dhs.date).capitalizeFirst(),
        x: i,
        isSelected: dhs.date.startOfDay().compareTo(startOfToday) == 0,
        rods: entries,
      );
    }).toList();

    return AppBarChartData(
      groups: groups,
    );
  }
}
