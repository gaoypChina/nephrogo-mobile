import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/ui/general/app_stream_builder.dart';
import 'package:nephrogo/ui/tabs/health_status/health_status_components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class HealthStatusTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HealthStatusCreationFloatingActionButton(),
      body: _HealthStatusTabBody(),
    );
  }
}

class _HealthStatusTabBody extends StatelessWidget {
  final apiService = ApiService();
  final healthIndicators = HealthIndicator.values.toList();

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<HealthStatusScreenResponse>(
      stream: () => apiService.getHealthStatusScreenStream(),
      builder: (context, response) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 64),
          itemCount: healthIndicators.length,
          itemBuilder: (context, i) => IndicatorChartSection(
            dailyHealthStatuses: response.dailyHealthStatuses.toList(),
            indicator: healthIndicators[i],
          ),
        );
      },
    );
  }
}
