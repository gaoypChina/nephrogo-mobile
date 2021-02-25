import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/manual_peritoneal_dialysis_total_balance_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_components.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis_screen_response.dart';

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
        label: "PRADĖTI DIALIZĘ",
        onPress: () => _openDialysisCreation(context),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 64),
        children: [
          AppElevatedButton(
            text: "Visi",
            onPressed: () => Navigator.of(context)
                .pushNamed(Routes.routeManualPeritonealDialysisAllScreen),
          ),
          _buildTotalBalanceChart(context),
          for (final indicator in indicators)
            IndicatorChartSection(
              indicator: indicator,
              dailyHealthStatuses: response.lastWeekHealthStatuses.toList(),
            )
        ],
      ),
    );
  }

  Widget _buildTotalBalanceChart(BuildContext context) {
    final today = Date.today();

    final todayDialysis = response.lastWeekManualDialysisReports
        .where((r) => r.date == Date.today())
        .firstOrNull();

    final todayFormatted = todayDialysis?.formattedTotalBalance ??
        context.appLocalizations.noInfo.toLowerCase();

    final subtitle =
        context.appLocalizations.healthIndicatorSubtitle(todayFormatted);

    return LargeSection(
      title: Text(context.appLocalizations.dailyBalance),
      subtitle: Text(subtitle),
      trailing: OutlinedButton(
        onPressed: null,
        child: Text(context.appLocalizations.more.toUpperCase()),
      ),
      children: [
        ManualPeritonealDialysisTotalBalanceChart(
          reports: response.lastWeekManualDialysisReports.toList(),
          maximumDate: today,
          minimumDate: today.subtract(const Duration(days: 6)),
        ),
      ],
    );
  }

  Future<void> _openDialysisCreation(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(Routes.routeManualPeritonealDialysisCreation);
  }
}
