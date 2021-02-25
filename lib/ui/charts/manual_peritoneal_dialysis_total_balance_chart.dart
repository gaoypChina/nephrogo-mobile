import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo_api_client/model/daily_manual_peritoneal_dialysis_report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'date_time_numeric_chart.dart';

class ManualPeritonealDialysisTotalBalanceChart extends StatelessWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final List<DailyManualPeritonealDialysisReport> reports;

  const ManualPeritonealDialysisTotalBalanceChart({
    Key key,
    @required this.reports,
    @required this.minimumDate,
    @required this.maximumDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1.5, child: _getChart(context));
  }

  Widget _getChart(BuildContext context) {
    return DateTimeNumericChart(
      series: _getColumnSeries(context).toList(),
      yAxisText: "${context.appLocalizations.dailyBalance}, ml",
      from: minimumDate,
      to: maximumDate,
      decimalPlaces: 0,
    );
  }

  Iterable<XyDataSeries> _getColumnSeries(BuildContext context) sync* {
    yield ColumnSeries<DailyManualPeritonealDialysisReport, DateTime>(
      dataSource: reports.sortedBy((e) => e.date).toList(),
      borderRadius: DateTimeNumericChart.rodTopRadius,
      xValueMapper: (report, _) => report.date.toDate(),
      yValueMapper: (report, _) => report.totalBalance,
      name: context.appLocalizations.dailyBalance,
    );
  }
}
