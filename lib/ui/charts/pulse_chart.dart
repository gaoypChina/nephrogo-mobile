import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo_api_client/model/pulse.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'date_time_numeric_chart.dart';

class PulseChart extends StatelessWidget {
  final List<Pulse> pulses;

  const PulseChart({
    Key key,
    @required this.pulses,
  })  : assert(pulses != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;
    final yAxisTitle =
        '${appLocalizations.pulse}, ${appLocalizations.pulseDimension}';

    return DateTimeNumericChart(
      series: _getStackedColumnSeries(context),
      yAxisText: yAxisTitle,
      from: pulses.minBy((i, e) => e.measuredAt)?.measuredAt,
      to: pulses.maxBy((i, e) => e.measuredAt)?.measuredAt,
      singlePointPerDay: false,
      showLegend: false,
    );
  }

  List<XyDataSeries> _getStackedColumnSeries(BuildContext context) {
    final sortedPulses = pulses.sortedBy((e) => e.measuredAt).toList();

    return [
      LineSeries<Pulse, DateTime>(
        dataSource: sortedPulses,
        xValueMapper: (c, _) => c.measuredAt,
        yValueMapper: (c, _) => c.pulse,
        name: context.appLocalizations.pulse,
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ];
  }
}
