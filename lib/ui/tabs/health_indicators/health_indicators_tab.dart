import 'package:flutter/material.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/charts/health_indicator_bar_chart.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/tabs/health_indicators/weekly_health_indicators_screen.dart';
import 'package:nephrolog_api_client/model/health_status_screen_response.dart';

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
        label: Text(
          AppLocalizations.of(context)
              .weeklyNutrientsCreateHealthIndicators
              .toUpperCase(),
        ),
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
    return AppFutureBuilder<HealthStatusScreenResponse>(
      future: apiService.getHealthStatusScreen(),
      builder: (BuildContext context, HealthStatusScreenResponse response) {
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
    HealthStatusScreenResponse healthStatusScreenResponse,
    HealthIndicator indicator,
  ) {
    final appLocalizations = AppLocalizations.of(context);
    final latestHealthStatus =
        healthStatusScreenResponse.dailyHealthStatuses.maxBy((e) => e.date);
    final todayConsumption =
        latestHealthStatus?.getHealthIndicatorFormatted(indicator) ??
            appLocalizations.noInfo.toLowerCase();

    final hasReports = healthStatusScreenResponse.dailyHealthStatuses
        .where((s) => s.isIndicatorExists(indicator))
        .isNotEmpty;

    return LargeSection(
      title: indicator.name,
      subTitle: appLocalizations.healthIndicatorSubtitle(todayConsumption),
      children: [
        if (hasReports)
          HealthIndicatorBarChart(
            dailyHealthStatuses:
                healthStatusScreenResponse.dailyHealthStatuses.toList(),
            indicator: indicator,
          ),
      ],
      leading: OutlineButton(
        child: Text(appLocalizations.more.toUpperCase()),
        onPressed: () => openWeeklyHealthIndicatorScreen(context, indicator),
      ),
    );
  }
}
