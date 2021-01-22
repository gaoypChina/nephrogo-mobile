import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/models/graph.dart';
import 'package:nephrogo_api_client/model/daily_intakes_report.dart';

import 'bar_chart.dart';

class IntakesNumberWeeklyBarChart extends StatelessWidget {
  static final _dayFormatter = DateFormat.E();
  static final _dateFormatter = DateFormat.MMMd();

  final Date today = Date(DateTime.now());

  final DateTime maximumDate;
  final List<DailyIntakesReport> dailyIntakeReports;

  IntakesNumberWeeklyBarChart({
    Key key,
    @required this.dailyIntakeReports,
    @required this.maximumDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: AspectRatio(
        aspectRatio: 2,
        child: AppBarChart(
          data: _getChartData(AppLocalizations.of(context)),
        ),
      ),
    );
  }

  AppBarChartData _getChartData(AppLocalizations appLocalizations) {
    final days =
        List.generate(7, (d) => Date(maximumDate.add(Duration(days: -d))))
            .reversed;

    final dailyIntakeReportsGrouped =
        dailyIntakeReports.groupBy((v) => Date(v.date)).map((key, values) {
      if (values.length > 1) {
        throw ArgumentError.value(values, "values",
            "Multiple daily intakes with same formatted date");
      }
      return MapEntry(key, values.firstOrNull());
    });

    final groups = days.mapIndexed((i, day) {
      final di = dailyIntakeReportsGrouped[day];

      final dateFormatted = _dateFormatter.format(day);
      final dayFormatted = _dayFormatter.format(day).capitalizeFirst();

      final y = di?.intakes?.length ?? 0;

      return AppBarChartGroup(
        text: dayFormatted,
        isSelected: day.compareTo(today) == 0,
        x: i,
        rods: [
          AppBarChartRod(
            tooltip: "$dateFormatted\n$y",
            y: y.toDouble(),
            barColor: Colors.teal,
          )
        ],
      );
    }).toList();

    return AppBarChartData(
      groups: groups,
      showLeftTitles: true,
      fitInsideVertically: true,
    );
  }
}
