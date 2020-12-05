import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/models/graph.dart';

class AppBarChart extends StatefulWidget {
  final AppBarChartData data;

  const AppBarChart({Key key, @required this.data}) : super(key: key);

  @override
  State<AppBarChart> createState() => _AppBarChart();
}

class _AppBarChart extends State<AppBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: widget.data.maxY,
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
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.data.rodRadius)),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: rod.backDrawRodY != null,
                    y: rod.backDrawRodY,
                    colors: [Colors.grey],
                  ));
            },
          ).toList(),
        );
      },
    ).toList();
  }
}
