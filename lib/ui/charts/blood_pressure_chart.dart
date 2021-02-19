import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo_api_client/model/blood_pressure.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'date_time_numeric_chart.dart';

class BloodPressureChart extends StatelessWidget {
  final List<BloodPressure> bloodPressures;

  const BloodPressureChart({
    Key key,
    @required this.bloodPressures,
  })  : assert(bloodPressures != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final yAxisTitle =
        '${context.appLocalizations.healthStatusCreationBloodPressure}, mmHg';

    return DateTimeNumericChart(
      series: _getStackedColumnSeries(context),
      yAxisText: yAxisTitle,
      from: bloodPressures.minBy((i, e) => e.measuredAt)?.measuredAt,
      to: bloodPressures.maxBy((i, e) => e.measuredAt)?.measuredAt,
      singlePointPerDay: false,
    );
  }

  List<XyDataSeries> _getStackedColumnSeries(BuildContext context) {
    final sortedBloodPressures =
        bloodPressures.sortedBy((e) => e.measuredAt).toList();

    return [
      LineSeries<BloodPressure, DateTime>(
        dataSource: sortedBloodPressures,
        xValueMapper: (c, _) => c.measuredAt,
        yValueMapper: (c, _) => c.systolicBloodPressure,
        dataLabelMapper: (c, _) => '${c.systolicBloodPressure} mmHg',
        name: context.appLocalizations.healthStatusCreationSystolic,
        markerSettings: MarkerSettings(isVisible: true),
      ),
      LineSeries<BloodPressure, DateTime>(
        dataSource: sortedBloodPressures,
        xValueMapper: (c, _) => c.measuredAt,
        yValueMapper: (c, _) => c.diastolicBloodPressure,
        dataLabelMapper: (c, _) => '${c.diastolicBloodPressure} mmHg',
        name: context.appLocalizations.healthStatusCreationDiastolic,
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ];
  }
}
