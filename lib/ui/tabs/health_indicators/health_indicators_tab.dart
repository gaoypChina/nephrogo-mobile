import 'package:flutter/material.dart';
import 'package:nephrolog/routes.dart';

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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [Text("TODO")],
      ),
    );
  }
}
