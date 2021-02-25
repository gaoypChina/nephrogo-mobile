import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'date_time_numeric_chart.dart';

class ManualPeritonealDialysisDayBalanceChart extends StatelessWidget {
  final Date date;
  final Iterable<ManualPeritonealDialysis> manualPeritonealDialysis;

  const ManualPeritonealDialysisDayBalanceChart({
    Key key,
    @required this.manualPeritonealDialysis,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1.5, child: _getChart(context));
  }

  Widget _getChart(BuildContext context) {
    return DateTimeNumericChart(
      series: _getColumnSeries(context).toList(),
      yAxisText: "${context.appLocalizations.cumulativeDailyBalance}, ml",
      from: date,
      to: date.endOfDay(),
      decimalPlaces: 0,
    );
  }

  Iterable<int> _cumSum(Iterable<ManualPeritonealDialysis> dialysis) sync* {
    int sum = 0;

    for (final d in dialysis) {
      sum += d.balance;

      yield sum;
    }
  }

  Iterable<XyDataSeries> _getColumnSeries(BuildContext context) sync* {
    final dialysis =
        manualPeritonealDialysis.sortedBy((e) => e.startedAt).toList();

    final cumSums = _cumSum(dialysis).toList();

    yield LineSeries<ManualPeritonealDialysis, DateTime>(
      dataSource: dialysis,
      xValueMapper: (d, _) => d.startedAt,
      markerSettings: MarkerSettings(isVisible: true),
      yValueMapper: (d, i) => cumSums[i],
      dataLabelMapper: (d, _) => d.balance.toString(),
      dataLabelSettings: DataLabelSettings(isVisible: true),
      pointColorMapper: (d, _) => d.dialysisSolution.color,
      name: context.appLocalizations.cumulativeDailyBalance,
      width: 4,
    );
  }
}
