import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo_api_client/model/blood_pressure.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BloodPressureChart extends StatelessWidget {
  final List<BloodPressure> bloodPressures;

  const BloodPressureChart({
    Key key,
    @required this.bloodPressures,
  })  : assert(bloodPressures != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // title: ChartTitle(text: _getTitleText(context.appLocalizations)),

      plotAreaBorderWidth: 0,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.top,
      ),
      enableSideBySideSeriesPlacement: false,
      primaryXAxis: DateTimeAxis(
        placeLabelsNearAxisLine: false,
        // intervalType: DateTimeIntervalType.days,
        majorGridLines: MajorGridLines(width: 0),
        // minimum: Date.today().subtract(const Duration(days: 6, hours: 12)),
        // maximum: Date.today()
        //     .add(const Duration(hours: 23, minutes: 59, seconds: 59)),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text:
              '${context.appLocalizations.healthStatusCreationBloodPressure}, mmHg',
          textStyle: const TextStyle(fontSize: 12),
        ),
        decimalPlaces: 0,
      ),
      series: _getStackedColumnSeries(context).toList(),
      tooltipBehavior: TooltipBehavior(
        decimalPlaces: 0,
        enable: true,
        canShowMarker: true,
        shared: true,
      ),
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
        name: context.appLocalizations.healthStatusCreationSystolic,
        markerSettings: MarkerSettings(isVisible: true),
      ),
      LineSeries<BloodPressure, DateTime>(
        dataSource: sortedBloodPressures,
        xValueMapper: (c, _) => c.measuredAt,
        yValueMapper: (c, _) => c.diastolicBloodPressure,
        name: context.appLocalizations.healthStatusCreationDiastolic,
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ];
  }
}
