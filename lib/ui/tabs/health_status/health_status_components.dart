import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/components.dart';

class HealthStatusCreationFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showMealTypeSelection(context),
      label: Text(context.appLocalizations.weeklyNutrientsCreateHealthIndicators
          .toUpperCase()),
      icon: const Icon(Icons.add),
    );
  }

  Future<void> _showMealTypeSelection(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            AppListTile(
              leading: const Icon(Icons.favorite),
              onTap: () => _createBloodPressureOrPulse(context),
              title: Text(context.appLocalizations.bloodPressureAndPulse),
            ),
            AppListTile(
              leading: const Icon(Icons.analytics),
              onTap: () => _createHealthStatus(context),
              title: Text(context.appLocalizations.otherHealthStatusIndicators),
            ),
          ],
        );
      },
    );
  }

  Future _createHealthStatus(BuildContext context) {
    return Navigator.pushReplacementNamed(
      context,
      Routes.routeHealthStatusCreation,
    );
  }

  Future _createBloodPressureOrPulse(BuildContext context) {
    return Navigator.pushReplacementNamed(
      context,
      Routes.routeBloodPressureAndPulseCreation,
    );
  }
}
