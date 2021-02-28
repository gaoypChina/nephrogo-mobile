import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/manual_peritoneal_dialysis_day_balance_chart.dart';
import 'package:nephrogo/ui/charts/manual_peritoneal_dialysis_total_balance_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_components.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis_screen_response.dart';

import 'beta_banner.dart';
import 'manual_peritoneal_dialysis_creation_screen.dart';

class ManualPeritonealDialysisTab extends StatelessWidget {
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<ManualPeritonealDialysisScreenResponse>(
      stream: apiService.getManualPeritonealDialysisScreenStream(),
      builder: (context, response) {
        return _ManualPeritonealDialysisTabBody(response: response);
      },
    );
  }
}

class _ManualPeritonealDialysisTabBody extends StatelessWidget {
  static final indicators = [
    HealthIndicator.bloodPressure,
    HealthIndicator.pulse,
    HealthIndicator.weight,
    HealthIndicator.urine,
  ];

  final ManualPeritonealDialysisScreenResponse response;

  const _ManualPeritonealDialysisTabBody({Key key, @required this.response})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDialFloatingActionButton(
        label: _getCreateButtonLabel(context),
        icon: response.peritonealDialysisInProgress == null
            ? Icons.add
            : Icons.play_arrow,
        onPress: () => _openDialysisCreation(context),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (!response.hasManualPeritonealDialysis) {
      return EmptyStateContainer(
          text: context.appLocalizations.weeklyHealthStatusEmpty);
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 64),
      children: [
        BetaBanner(),
        _buildMyDialysisSection(context),
        _buildTotalBalanceSection(context),
        NutrientChartSection(
          reports: response.lastWeekLightNutritionReports.toList(),
          nutrient: Nutrient.liquids,
        ),
        for (final indicator in indicators)
          IndicatorChartSection(
            indicator: indicator,
            dailyHealthStatuses: response.lastWeekHealthStatuses.toList(),
            showAddButton: true,
          )
      ],
    );
  }

  String _getCreateButtonLabel(BuildContext context) {
    if (response.peritonealDialysisInProgress == null) {
      return context.appLocalizations.startDialysis;
    }

    return context.appLocalizations.continueDialysis;
  }

  Widget _buildMyDialysisSection(BuildContext context) {
    final today = Date.today();
    final todayReport = response.lastWeekManualDialysisReports
        .where((r) => r.date == today)
        .firstOrNull();

    var subtitle = context.appLocalizations.todayDialysisNotPerformed;

    if (todayReport != null &&
        todayReport.manualPeritonealDialysis.isNotEmpty) {
      subtitle = "${context.appLocalizations.todayPerformedDialysis}: "
          "${todayReport.completedDialysisCount}";
    }

    return LargeSection(
      title: Text(context.appLocalizations.peritonealDialysisPlural),
      subtitle: Text(subtitle),
      trailing: OutlinedButton(
        onPressed: () => Navigator.of(context).pushNamed(
          Routes.routeManualPeritonealDialysisAllScreen,
        ),
        child: Text(context.appLocalizations.allFeminine.toUpperCase()),
      ),
      children: [
        if (todayReport != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ManualPeritonealDialysisDayBalanceChart(
              manualPeritonealDialysis:
                  todayReport?.manualPeritonealDialysis ?? [],
              date: today,
            ),
          ),
      ],
    );
  }

  Widget _buildTotalBalanceSection(BuildContext context) {
    final today = Date.today();

    final todayDialysis = response.lastWeekManualDialysisReports
        .where((r) => r.date == today)
        .firstOrNull();

    final todayFormatted = todayDialysis?.formattedTotalBalance ??
        context.appLocalizations.noInfo.toLowerCase();

    final subtitle =
        context.appLocalizations.healthIndicatorSubtitle(todayFormatted);

    return LargeSection(
      title: Text(context.appLocalizations.balance),
      subtitle: Text(subtitle),
      trailing: OutlinedButton(
        onPressed: () => Navigator.of(context).pushNamed(
          Routes.routeManualPeritonealDialysisBalanceScreen,
        ),
        child: Text(context.appLocalizations.more.toUpperCase()),
      ),
      children: [
        if (todayDialysis != null)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ManualPeritonealDialysisDayBalanceChart(
              manualPeritonealDialysis:
                  todayDialysis.manualPeritonealDialysis ?? [],
              date: today,
            ),
          )
        else if (response.lastWeekManualDialysisReports.isNotEmpty)
          ManualPeritonealDialysisTotalBalanceChart(
            reports: response.lastWeekManualDialysisReports.toList(),
            maximumDate: today,
            minimumDate: today.subtract(const Duration(days: 6)),
          ),
      ],
    );
  }

  Future<void> _openDialysisCreation(BuildContext context) {
    return Navigator.of(context).pushNamed(
      Routes.routeManualPeritonealDialysisCreation,
      arguments: ManualPeritonealDialysisCreationScreenArguments(
        response.peritonealDialysisInProgress,
        response.lastWeekHealthStatuses
            .where((s) => s.date == Date.today())
            .firstOrNull(),
      ),
    );
  }
}
