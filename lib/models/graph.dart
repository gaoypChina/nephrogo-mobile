import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class AppBarChartData extends Equatable {
  final List<AppBarChartGroup> groups;
  final double dashedHorizontalLine;
  final double barWidth;
  final double rodRadius;
  final double interval;
  final double maxY;
  final fitInsideHorizontally;
  final fitInsideVertically;

  const AppBarChartData({
    @required this.groups,
    this.dashedHorizontalLine,
    this.barWidth: 22,
    this.rodRadius: 6,
    this.maxY,
    this.interval,
    this.fitInsideHorizontally: true,
    this.fitInsideVertically: true,
  });

  @override
  List<Object> get props => [
        groups,
        dashedHorizontalLine,
        barWidth,
        rodRadius,
        interval,
        maxY,
        fitInsideHorizontally,
        fitInsideVertically
      ];
}

class AppBarChartGroup extends Equatable {
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

  @override
  List<Object> get props => [text, x, isSelected, rods];
}

class AppBarChartRod extends Equatable {
  final double y;
  final String tooltip;
  final Color barColor;
  final double backDrawRodY;
  final List<AppBarChartRodStackItem> rodStackItems;

  const AppBarChartRod({
    @required this.y,
    @required this.tooltip,
    @required this.barColor,
    this.backDrawRodY,
    this.rodStackItems,
  });

  @override
  List<Object> get props => [y, tooltip, barColor, backDrawRodY, rodStackItems];
}

class AppBarChartRodStackItem extends Equatable {
  final double fromY;

  final double toY;

  final Color color;

  const AppBarChartRodStackItem(this.fromY, this.toY, this.color);

  @override
  List<Object> get props => [fromY, toY, color];
}
