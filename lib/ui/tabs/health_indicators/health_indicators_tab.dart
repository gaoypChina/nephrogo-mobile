import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/routes.dart';

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
  final dailyHealthIndicators = DailyHealthIndicators.generateDummies();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dailyHealthIndicators.length,
      itemBuilder: (context, index) {
        final dailyHealthIndicator = dailyHealthIndicators[index];

        return HealthIndicatorsSection(
          dailyHealthIndicators: dailyHealthIndicator,
        );
      },
    );
  }
}
