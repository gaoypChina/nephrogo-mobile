import 'dart:ui';

import 'package:flutter/foundation.dart';

class AppBarChartData {
  final List<AppBarChartGroup> groups;
  final double horizontalLinesInterval;
  final double barWidth;
  final double rodRadius;

  AppBarChartData({
    @required this.groups,
    this.horizontalLinesInterval,
    this.barWidth: 22,
    this.rodRadius: 6,
  });
}

class AppBarChartGroup {
  final String text;
  final int x;
  final List<AppBarChartRod> rods;

  const AppBarChartGroup({
    @required this.text,
    @required this.x,
    @required this.rods,
  });
}

class AppBarChartRod {
  final double y;
  final String tooltip;
  final Color barColor;

  const AppBarChartRod({
    @required this.y,
    @required this.tooltip,
    @required this.barColor,
  });
}
