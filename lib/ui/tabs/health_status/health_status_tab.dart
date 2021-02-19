import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/collection_extensions.dart';
import 'package:nephrogo/extensions/contract_extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/weekly_health_indicator_bar_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/model/health_status_screen_response.dart';

import 'health_status_components.dart';
import 'weekly_health_status_screen.dart';

class HealthStatusTab extends StatefulWidget {
  @override
  _HealthStatusTabState createState() => _HealthStatusTabState();
}

class _HealthStatusTabState extends State<HealthStatusTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HealthStatusCreationFloatingActionButton(),
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
    final appLocalizations = AppLocalizations.of(context);

    final healthIndicators = HealthIndicator.values
        .where((e) => e != HealthIndicator.bloodPressure)
        .toList();

    return AppStreamBuilder<HealthStatusScreenResponse>(
      stream: apiService.getHealthStatusScreenStream(),
      builder: (context, response) {
        return Visibility(
          visible: response.hasAnyStatuses,
          replacement: EmptyStateContainer(
            text: appLocalizations.weeklyHealthStatusEmpty,
          ),
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 64),
              itemCount: healthIndicators.length,
              itemBuilder: (context, i) => buildIndicatorChartSection(
                context,
                response,
                healthIndicators[i],
              ),
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
      Routes.routeWeeklyHealthStatusScreen,
      arguments: WeeklyHealthStatusScreenArguments(indicator),
    );
  }

  LargeSection buildIndicatorChartSection(
    BuildContext context,
    HealthStatusScreenResponse healthStatusScreenResponse,
    HealthIndicator indicator,
  ) {
    final appLocalizations = AppLocalizations.of(context);
    final todayHealthStatus = healthStatusScreenResponse.dailyHealthStatuses
        .where((e) => Date.from(e.date) == Date.from(now))
        .firstOrNull();

    final todayConsumption = todayHealthStatus?.getHealthIndicatorFormatted(
            indicator, appLocalizations) ??
        appLocalizations.noInfo.toLowerCase();

    final hasReports = healthStatusScreenResponse.dailyHealthStatuses
        .any((s) => s.isIndicatorExists(indicator));

    return LargeSection(
      title: indicator.name(appLocalizations),
      showDividers: true,
      subtitle:
          Text(appLocalizations.healthIndicatorSubtitle(todayConsumption)),
      trailing: OutlinedButton(
        onPressed: () => openWeeklyHealthIndicatorScreen(context, indicator),
        child: Text(appLocalizations.more.toUpperCase()),
      ),
      children: [
        if (hasReports)
          HealthIndicatorWeeklyBarChart(
            dailyHealthStatuses:
                healthStatusScreenResponse.dailyHealthStatuses.toList(),
            indicator: indicator,
            maximumDate: now,
            appLocalizations: appLocalizations,
          ),
      ],
    );
  }
}
