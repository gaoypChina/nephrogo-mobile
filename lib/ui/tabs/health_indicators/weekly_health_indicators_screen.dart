import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/ui/general/weekly_pager.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';

import 'health_indicators_section.dart';

class WeeklyHealthIndicatorsScreenArguments {
  final HealthIndicator initialHealthIndicator;

  const WeeklyHealthIndicatorsScreenArguments(this.initialHealthIndicator);
}

class WeeklyHealthIndicatorsScreen extends StatefulWidget {
  final HealthIndicator initialHealthIndicator;

  const WeeklyHealthIndicatorsScreen({Key key, this.initialHealthIndicator})
      : super(key: key);

  @override
  _WeeklyHealthIndicatorsScreenState createState() =>
      _WeeklyHealthIndicatorsScreenState();
}

class _WeeklyHealthIndicatorsScreenState
    extends State<WeeklyHealthIndicatorsScreen> {
  ValueNotifier<HealthIndicator> valueNotifier;
  HealthIndicator selectedHealthIndicator;

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();

    valueNotifier = ValueNotifier(widget.initialHealthIndicator);
    selectedHealthIndicator = widget.initialHealthIndicator;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedHealthIndicator.name),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => valueNotifier.value = HealthIndicator.appetite,
        label: Text("RODIKLIS"),
        icon: Icon(Icons.swap_horizontal_circle),
      ),
      body: WeeklyPager<HealthIndicator>(
        valueChangeNotifier: valueNotifier,
        bodyBuilder: (from, to, indicator) {
          return AppFutureBuilder<UserHealthStatusResponse>(
            future: _apiService.getUserHealthStatus(from, to),
            builder: (context, data) {
              return HealthIndicatorsList(
                dailyHealthStatuses: data.dailyHealthStatuses,
                healthIndicator: selectedHealthIndicator,
              );
            },
          );
        },
      ),
    );
  }
}
