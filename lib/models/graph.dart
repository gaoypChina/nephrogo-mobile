import 'dart:ui';

import 'package:flutter/cupertino.dart';

class BarChartEntry {
  final String title;
  final double y;
  final String tooltip;
  final Color barColor;

  const BarChartEntry({
    @required this.title,
    @required this.y,
    this.barColor,
    this.tooltip,
  });
}
