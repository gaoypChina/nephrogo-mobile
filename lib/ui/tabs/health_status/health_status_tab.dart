import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/collection_extensions.dart';
import 'package:nephrogo/extensions/contract_extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/weekly_health_indicator_bar_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrolog_api_client/model/health_status_screen_response.dart';

import 'weekly_health_status_screen.dart';

class HealthStatusTab extends StatefulWidget {
  @override
  _HealthStatusTabState createState() => _HealthStatusTabState();
}

class _HealthStatusTabState extends State<HealthStatusTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createHealthStatus,
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

  Future _createHealthStatus() {
    return Navigator.pushNamed(
      context,
      Routes.ROUTE_HEALTH_STATUS_CREATION,
    );
  }
}

class HealthIndicatorsTabBody extends StatelessWidget {
  final apiService = ApiService();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return AppStreamBuilder<HealthStatusScreenResponse>(
      stream: apiService.getHealthStatusScreenStream(),
      builder: (context, response) {
        return Visibility(
          visible: response.hasAnyStatuses,
          child: ListView(
            padding: EdgeInsets.only(bottom: 64),
            children: [
              for (final indicator in HealthIndicator.values)
                buildIndicatorChartSection(context, response, indicator)
            ],
          ),
          replacement: EmptyStateContainer(
            text: appLocalizations.weeklyHealthStatusEmpty,
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
      Routes.ROUTE_WEEKLY_HEALTH_STATUS_SCREEN,
      arguments: WeeklyHealthStatusScreenArguments(indicator),
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
    final todayConsumption = latestHealthStatus?.getHealthIndicatorFormatted(
            indicator, appLocalizations) ??
        appLocalizations.noInfo.toLowerCase();

    final hasReports =
        latestHealthStatus?.isIndicatorExists(indicator) ?? false;

    return LargeSection(
      title: indicator.name(appLocalizations),
      subTitle: appLocalizations.healthIndicatorSubtitle(todayConsumption),
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
      leading: OutlineButton(
        child: Text(appLocalizations.more.toUpperCase()),
        onPressed: () => openWeeklyHealthIndicatorScreen(context, indicator),
      ),
    );
  }
}
