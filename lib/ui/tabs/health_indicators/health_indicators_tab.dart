import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/ui/tabs/health_indicators/weekly_health_indicators_screen.dart';

import 'health_indicators_section.dart';

class HealthIndicatorsTab extends StatelessWidget {
  final ValueNotifier<int> valueNotifier = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => valueNotifier.value = valueNotifier.value + 1,
        label: Text("PRIDĖTI RODIKLIUS"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: HealthIndicatorsTabBody(),
    );
  }
}

class HealthIndicatorsTabBody extends StatelessWidget {
  final apiService = ApiService();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final weekStartEnd = now.startAndEndOfWeek();

    final from = weekStartEnd.item1;
    final to = weekStartEnd.item2;

    return AppFutureBuilder<UserHealthStatusResponse>(
      future: apiService.getUserHealthStatus(from, to),
      builder: (BuildContext context, UserHealthStatusResponse response) {
        return DailyHealthStatusSection(
          title: "Šios dienos rodikliai",
          dailyHealthStatus: response.dailyHealthStatuses.first,
          leading: OutlineButton(
            child: Text("DAUGIAU"),
            onPressed: () => openWeeklyHealthIndicatorScreen(
              context,
              HealthIndicator.bloodPressure,
            ),
          ),
        );
      },
    );
  }

  void openWeeklyHealthIndicatorScreen(
    BuildContext context,
    HealthIndicator indicator,
  ) {
    Navigator.pushNamed(
      context,
      Routes.ROUTE_WEEKLY_HEALTH_INDICATORS_SCREEN,
      arguments: WeeklyHealthIndicatorsScreenArguments(indicator),
    );
  }
}
