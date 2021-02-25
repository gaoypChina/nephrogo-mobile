import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_components.dart';
import 'package:nephrogo_api_client/model/daily_health_status.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppElevatedButton(
              text: "Visi",
              onPressed: () => Navigator.of(context)
                  .pushNamed(Routes.routeManualPeritonealDialysisAllScreen),
            ),
          ),
          _buildHealthIndicatorCharts(
            context,
            response.lastWeekHealthStatuses.toList(),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 64)),
        ],
      ),
    );
  }

  Future<void> _openDialysisCreation(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(Routes.routeManualPeritonealDialysisCreation);
  }

  SliverList _buildHealthIndicatorCharts(
      BuildContext context, List<DailyHealthStatus> dailyHealthStatuses) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return IndicatorChartSection(
            indicator: indicators[index],
            dailyHealthStatuses: dailyHealthStatuses,
          );
        },
        childCount: indicators.length,
      ),
    );
  }
}
