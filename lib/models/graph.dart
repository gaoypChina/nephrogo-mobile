import 'dart:ui';

import 'package:flutter/foundation.dart';

class AppBarChartData {
  final List<AppBarChartGroup> groups;
  final double dashedHorizontalLine;
  final double barWidth;
  final double rodRadius;
  final double interval;
  final double maxY;

  AppBarChartData({
    @required this.groups,
    this.dashedHorizontalLine,
    this.barWidth: 22,
    this.rodRadius: 6,
    this.maxY,
    this.interval,
  });
}

class AppBarChartGroup {
  final String text;
  final int x;
  final bool isSelected;
  final List<AppBarChartRod> rods;

  const AppBarChartGroup({
    @required this.text,
    @required this.x,
    @required this.rods,
    this.isSelected: false,
  });
}

class AppBarChartRod {
  final double y;
  final String tooltip;
  final Color barColor;
  final double backDrawRodY;

  const AppBarChartRod({
    @required this.y,
    @required this.tooltip,
    @required this.barColor,
    this.backDrawRodY,
  });
}
