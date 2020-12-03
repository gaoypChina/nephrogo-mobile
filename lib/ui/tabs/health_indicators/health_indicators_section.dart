import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/ui/components.dart';

class HealthIndicatorsSection extends StatelessWidget {
  final DailyHealthIndicators dailyHealthIndicators;

  const HealthIndicatorsSection({Key key, this.dailyHealthIndicators})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: "Mano šiandienos rodikliai",
      children: [
        _DailyHealthIndicatorsColumn(
          dailyHealthIndicators: dailyHealthIndicators,
        ),
      ],
      leading: OutlineButton(
        child: Text("REDAGUOTI"),
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.ROUTE_HEALTH_INDICATORS_CREATION,
        ),
      ),
    );
  }
}

class _HealthIndicatorColumnData {
  final String title;
  final String text;

  _HealthIndicatorColumnData(this.title, this.text);
}

class _DailyHealthIndicatorsColumn extends StatelessWidget {
  final DailyHealthIndicators dailyHealthIndicators;

  const _DailyHealthIndicatorsColumn({Key key, this.dailyHealthIndicators})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: generateIndicatorsDataArray()
          .map(
            (e) => ListTile(
              title: Text(e.title),
              trailing: Text(e.text),
            ),
          )
          .toList(),
    );
  }

  List<_HealthIndicatorColumnData> generateIndicatorsDataArray() {
    List<_HealthIndicatorColumnData> data = [];

    var bloodPressureText = "-";

    if (dailyHealthIndicators.systolicBloodPressure != null &&
        dailyHealthIndicators.diastolicBloodPressure != null) {
      bloodPressureText = "${dailyHealthIndicators.diastolicBloodPressure} / "
          "${dailyHealthIndicators.systolicBloodPressure} mmHG";
    }

    data.add(_HealthIndicatorColumnData("Kraujo spaudimas", bloodPressureText));

    return data;
  }
}
