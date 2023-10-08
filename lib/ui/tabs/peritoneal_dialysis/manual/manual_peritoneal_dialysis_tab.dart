import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_stream_builder.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_components.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/manual/manual_peritoneal_dialysis_creation_screen.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/manual/manual_peritoneal_dialysis_screen.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/peritoneal_dialysis_components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class ManualPeritonealDialysisTab extends StatelessWidget {
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<ManualPeritonealDialysisScreenResponse>(
      stream: () => apiService.getManualPeritonealDialysisScreenStream(),
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

  const _ManualPeritonealDialysisTabBody({required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PeritonealDialysisCreationFloatingActionButton(
        dialysisInProgress: response.peritonealDialysisInProgress != null,
        dialysisOnTap: _openDialysisCreation,
      ),
      body: ListView(
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
            ),
        ],
      ),
    );
  }

  Widget _buildTotalBalanceSection(BuildContext context) {
    final today = DateTime.now().toDate();

    final healthStatusesWithDialysis = response.lastWeekHealthStatuses
        .where((s) => s.manualPeritonealDialysis.isNotEmpty)
        .toList();

    final todayDialysis =
        healthStatusesWithDialysis.where((r) => r.date == today).firstOrNull();

    final todayFormatted =
        todayDialysis?.totalManualPeritonealDialysisBalanceFormatted ?? '—';

    final subtitle =
        '${context.appLocalizations.todayBalance}: $todayFormatted';

    final initialDate = response.lastPeritonealDialysis
            .map((d) => d.startedAt.toDate())
            .maxBy((d) => d) ??
        today;

    return LargeSection(
      title: Text(context.appLocalizations.peritonealDialysisPlural),
      subtitle: Text(subtitle),
      trailing: OutlinedButton(
        onPressed: () => Navigator.of(context).pushNamed(
          Routes.routeManualPeritonealDialysisScreen,
          arguments: ManualPeritonealDialysisScreenArguments(
            initialDate: initialDate,
          ),
        ),
        child: Text(context.appLocalizations.more.toUpperCase()),
      ),
      footer: SectionFooterButton(
        onPressed: () => _openDialysisCreation(context),
        child: response.peritonealDialysisInProgress != null
            ? Text(context.appLocalizations.continueDialysis.toUpperCase())
            : Text(context.appLocalizations.startDialysis.toUpperCase()),
      ),
      children: [
        for (final dialysis in response.lastPeritonealDialysis)
          ManualPeritonealDialysisTile(dialysis),
      ],
    );
  }

  Future<void> _openDialysisCreation(BuildContext context) {
    return Navigator.of(context).pushNamed(
      Routes.routeManualPeritonealDialysisCreation,
      arguments: ManualPeritonealDialysisCreationScreenArguments(
        response.peritonealDialysisInProgress,
      ),
    );
  }
}
