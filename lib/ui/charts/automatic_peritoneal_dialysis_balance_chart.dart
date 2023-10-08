import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/charts/date_time_numeric_chart.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AutomaticPeritonealDialysisBalanceChart extends StatelessWidget {
  final DateTime minimumDate;
  final DateTime maximumDate;
  final List<AutomaticPeritonealDialysis> dialysis;

  const AutomaticPeritonealDialysisBalanceChart({
    super.key,
    required this.dialysis,
    required this.minimumDate,
    required this.maximumDate,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1.5, child: _getChart(context));
  }

  Widget _getChart(BuildContext context) {
    return DateTimeNumericChart(
      yAxisText: '${context.appLocalizations.dailyBalance}, ml',
      from: minimumDate,
      to: maximumDate,
      decimalPlaces: 0,
      series: [
        ColumnSeries<AutomaticPeritonealDialysis, DateTime>(
          dataSource: dialysis.orderBy((e) => e.date).toList(),
          xValueMapper: (s, _) => s.date.toDateTime(),
          yValueMapper: (s, _) => s.balance,
          pointColorMapper: (s, _) =>
              s.balance < 0 ? Colors.teal : Colors.redAccent,
          name: context.appLocalizations.dailyBalance,
          color: Colors.teal,
        ),
      ],
    );
  }
}
