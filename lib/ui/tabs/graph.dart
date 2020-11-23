// https://github.com/imaNNeoFighT/fl_chart/issues/476
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/ui/models/graph.dart';

class BarChartGraph extends StatefulWidget {
  final List<BarChartEntry> entries;

  static final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const BarChartGraph({Key key, this.entries}) : super(key: key);

  static const weekDays = [
    'Pirmadienis',
    'Antradienis',
    'Trečiadienis',
    'Ketvirtadienis',
    'Penktadienis',
    'Šeštadienis',
    'Sekmadienis',
  ];

  static Widget exampleIndicatorGraph() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: AspectRatio(
        aspectRatio: 2,
        child: BarChartGraph.example(false, weekDays),
      ),
    );
  }

  static BarChartGraph example(bool today, List<String> data) {
    var exceededDay = Random().nextInt(data.length);
    List<BarChartEntry> entries = [];
    for (int i = 0; i < data.length; i++) {
      var r = (i == exceededDay) ? 1.0 : min(Random().nextDouble(), 0.9);

      var tooltip = "Suvartota: 3 g";
      if (today) {
        tooltip = "${data[i]}\nSuvartota 3 g.\nDar galima 1 g";
      }

      entries.add(BarChartEntry(
        title: today ? data[i] : data[i][0],
        y: r,
        tooltip: tooltip,
        barColor: i != exceededDay ? Colors.lightGreen : Colors.deepOrange,
      ));
    }
    return BarChartGraph(
      entries: entries,
    );
  }

  static Widget exampleDailyTotals() {
    final first = BarChartGraph.example(
      true,
      ["Kalis", "Baltymai", "Natris", "Fosforas"],
    );
    final second = BarChartGraph.example(
      true,
      ["Fosforas", "Energija", "Skysčiai"],
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 100,
            child: first,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              child: FractionallySizedBox(widthFactor: 0.6, child: second),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _BarChartGraph();
}

class _BarChartGraph extends State<BarChartGraph> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarData(),
      swapAnimationDuration: animDuration,
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.lightGreen,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 1,
            colors: [Colors.blueGrey],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    final entries = widget.entries;

    return List.generate(entries.length, (i) {
      if (i >= entries.length) {
        return null;
      }

      final entry = entries[i];
      return makeGroupData(
        i,
        entry.y,
        isTouched: i == touchedIndex,
        barColor: entry.barColor,
      );
    });
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(this.widget.entries[groupIndex].tooltip,
                  TextStyle(color: Colors.yellow));
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
            return this.widget.entries[value.toInt()].title;
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
