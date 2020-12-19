import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/charts/health_indicator_bar_chart.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/tabs/health_indicators/weekly_health_indicators_screen.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog_api_client/model/user_health_status_report.dart';

class HealthIndicatorsTab extends StatelessWidget {
  final ValueNotifier<int> valueNotifier = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.ROUTE_HEALTH_INDICATORS_CREATION,
        ),
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
    final from = now.startOfDay().subtract(Duration(days: 6));
    final to = now.endOfDay();

    return AppFutureBuilder<UserHealthStatusReport>(
      future: apiService.getUserHealthStatusReport(from, to),
      builder: (BuildContext context, UserHealthStatusReport response) {
        final sections = HealthIndicator.values
            .map((i) => buildIndicatorChartSection(context, response, i))
            .toList();

        return ListView(
          padding: EdgeInsets.only(bottom: 64),
          children: sections,
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

  LargeSection buildIndicatorChartSection(
    BuildContext context,
    UserHealthStatusReport userHealthStatusReport,
    HealthIndicator indicator,
  ) {
    final todayDailyHealthStatus =
        userHealthStatusReport.dailyHealthStatuses.last.status;
    final todayConsumption =
        todayDailyHealthStatus.getHealthIndicatorFormatted(indicator) ??
            "nėra informacijos";

    return LargeSection(
      title: indicator.name,
      subTitle: "Šiandien: $todayConsumption",
      children: [
        HealthIndicatorBarChart(
          userHealthStatusReport: userHealthStatusReport,
          indicator: indicator,
        ),
      ],
      leading: OutlineButton(
        child: Text("DAUGIAU"),
        onPressed: () => openWeeklyHealthIndicatorScreen(context, indicator),
      ),
    );
  }
}
