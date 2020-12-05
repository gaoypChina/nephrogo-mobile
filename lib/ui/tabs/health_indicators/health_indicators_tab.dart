import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/general/progress_indicator.dart';
import 'package:nephrolog/extensions/date_extensions.dart';

import 'health_indicators_section.dart';

class HealthIndicatorsTab extends StatelessWidget {
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
    final weekStartEnd = now.startAndEndOfWeek();

    final from = weekStartEnd.item1;
    final to = weekStartEnd.item2;

    return FutureBuilder<UserHealthStatusResponse>(
      future: apiService.getUserHealthStatus(from, to),
      builder: (BuildContext context,
          AsyncSnapshot<UserHealthStatusResponse> snapshot) {
        if (snapshot.hasData) {
          final dailyHealthStatuses = snapshot.data.dailyHealthStatuses;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: Column(
                children: [
                  HealthIndicatorsSection(
                    dailyHealthIndicators: dailyHealthStatuses.first,
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error));
        }

        return Center(child: AppProgressIndicator());
      },
    );
  }
}
