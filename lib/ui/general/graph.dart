import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/constants.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/models/graph.dart';
import 'package:nephrolog/extensions/CollectionExtensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';

class IndicatorBarChart extends StatelessWidget {
  final List<DailyIntakes> dailyIntakes;
  final double dailyNorm;
  final IndicatorType type;

  const IndicatorBarChart({
    Key key,
    @required this.dailyIntakes,
    @required this.type,
    @required this.dailyNorm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: AspectRatio(
        aspectRatio: 2,
        child: BarChartGraph(
          data: AppBarChartData(
            groups: _getChartGroups(dailyNorm),
            horizontalLinesInterval: dailyNorm,
          ),
        ),
      ),
    );
  }

  List<AppBarChartGroup> _getChartGroups(double dailyNorm) {
    final dailyIntakesByWeekDay =
        dailyIntakes.groupBy((e) => e.date.weekday).map(
              (key, value) => MapEntry(key, value.firstOrNull()),
            );

    return Constants.weekDays.mapIndexed((i, dayText) {
      final di = dailyIntakesByWeekDay[i + 1];
      final y = di?.getTotalIndicatorAmountByType(type) ?? 0;

      print("$type: y = $y, dailyNorm = $dailyNorm");

      AppBarChartRod entry = AppBarChartRod(
        tooltip: di?.getFormattedDailyNorm(type) ?? "",
        y: y.toDouble(),
        barColor: y > dailyNorm ? Colors.redAccent : Colors.teal,
      );

      return AppBarChartGroup(
        text: dayText[0],
        x: i,
        rods: entry != null ? [entry] : [],
      );
    }).toList();
  }
}

class BarChartGraph extends StatefulWidget {
  final AppBarChartData data;

  const BarChartGraph({Key key, @required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BarChartGraph();
}

class _BarChartGraph extends State<BarChartGraph> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    final maxY = widget.data.groups
        .map((e) => e.rods.map((e) => e.y))
        .expand((e) => e)
        .max;

    return BarChart(
      BarChartData(
        maxY: max(maxY * 1.1, widget.data.horizontalLinesInterval ?? 0),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  this.widget.data.groups[groupIndex].rods[rodIndex].tooltip,
                  TextStyle(color: Colors.yellow),
                );
              }),
          touchCallback: (barTouchResponse) {
            setState(() {
              if (barTouchResponse.spot != null &&
                  barTouchResponse.touchInput is! FlPanEnd &&
                  barTouchResponse.touchInput is! FlLongPressEnd) {
                touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
              } else {
                touchedIndex = -1;
              }
            });
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              return this.widget.data.groups[value.toInt()].text;
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
        ),
        gridData: FlGridData(
          show: widget.data.horizontalLinesInterval != null,
          horizontalInterval: widget.data.horizontalLinesInterval,
          checkToShowHorizontalLine: (value) {
            return (value - widget.data.horizontalLinesInterval).abs() < 1e-6;
          },
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.teal,
              dashArray: [5, 5],
              strokeWidth: 2,
            );
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: showingGroups(),
      ),
      swapAnimationDuration: animDuration,
    );
  }

  List<BarChartGroupData> showingGroups() {
    return widget.data.groups.map(
      (group) {
        final x = group.x;
        final isTouched = x == touchedIndex;

        return BarChartGroupData(
          x: x,
          barRods: group.rods.map(
            (rod) {
              final y = rod.y.toDouble();

              return BarChartRodData(
                y: y,
                colors: isTouched ? [Colors.orange] : [rod.barColor],
                width: widget.data.barWidth,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.data.rodRadius),
                  topRight: Radius.circular(widget.data.rodRadius),
                ),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  y: y,
                  colors: [Colors.grey],
                ),
              );
            },
          ).toList(),
        );
      },
    ).toList();
  }
}
