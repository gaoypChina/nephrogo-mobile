import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_components.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/automatic/automatic_peritoneal_dialysis_periods.dart';
import 'package:nephrogo_api_client/model/automatic_peritoneal_dialysis_screen_response.dart';

import 'automatic_peritoneal_dialysis_components.dart';
import 'automatic_peritoneal_dialysis_creation_screen.dart';

class AutomaticPeritonealDialysisTab extends StatelessWidget {
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<AutomaticPeritonealDialysisScreenResponse>(
      stream: apiService.getAutomaticPeritonealDialysisScreenStream(),
      builder: (context, response) {
        return _AutomaticPeritonealDialysisTabBody(response: response);
      },
    );
  }
}

class _AutomaticPeritonealDialysisTabBody extends StatelessWidget {
  static final indicators = [
    HealthIndicator.bloodPressure,
    HealthIndicator.pulse,
    HealthIndicator.weight,
    HealthIndicator.urine,
  ];

  final AutomaticPeritonealDialysisScreenResponse response;

  const _AutomaticPeritonealDialysisTabBody({Key key, @required this.response})
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
    if (response.lastPeritonealDialysis == null) {
      return EmptyStateContainer(
        text: context.appLocalizations.manualPeritonealDialysisEmpty,
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 64),
      children: [
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

  Widget _buildTotalBalanceSection(BuildContext context) {
    final today = Date.today();

    final initialDate =
        response.lastPeritonealDialysis?.startedAt?.toDate() ?? today;

    return LargeSection(
      title: Text(context.appLocalizations.peritonealDialysisPlural),
      showDividers: true,
      trailing: OutlinedButton(
        onPressed: () => Navigator.of(context).pushNamed(
          Routes.routeAutomaticPeritonealDialysisPeriod,
          arguments: AutomaticPeritonealDialysisPeriodsScreenArguments(
            initialDate: initialDate,
          ),
        ),
        child: Text(context.appLocalizations.more.toUpperCase()),
      ),
      children: [
        if (response.lastPeritonealDialysis != null)
          AutomaticPeritonealDialysisTile(response.lastPeritonealDialysis)
      ],
    );
  }

  Future<void> _openDialysisCreation(BuildContext context) {
    return Navigator.of(context).pushNamed(
      Routes.routeAutomaticPeritonealDialysisCreation,
      arguments: AutomaticPeritonealDialysisCreationScreenArguments(
        response.peritonealDialysisInProgress,
      ),
    );
  }
}
