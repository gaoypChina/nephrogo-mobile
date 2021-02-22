import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/health_status/blood_pressure_and_pulse_creation_screen.dart';

import 'health_status_creation_screen.dart';

class HealthStatusCreationFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDialFloatingActionButton(
      label: context.appLocalizations.createHealthStatus,
      children: [
        _createDialButton(
          icon: Icons.timeline,
          onTap: () => _createBloodPressureOrPulse(context),
          backgroundColor: Colors.blue,
          label: context.appLocalizations.pulse,
        ),
        _createDialButton(
          icon: Icons.favorite,
          onTap: () => _createBloodPressureOrPulse(context),
          backgroundColor: Colors.deepPurple,
          label: context.appLocalizations.healthStatusCreationBloodPressure,
        ),
        _createDialButton(
          icon: Icons.analytics,
          onTap: () => _createHealthStatus(context),
          backgroundColor: Colors.teal,
          label: context.appLocalizations.otherHealthStatusIndicators,
        ),
      ],
    );
  }

  SpeedDialChild _createDialButton({
    @required IconData icon,
    @required Color backgroundColor,
    @required String label,
    @required VoidCallback onTap,
  }) {
    return SpeedDialChild(
      child: Icon(icon),
      backgroundColor: backgroundColor,
      labelStyle: const TextStyle(fontSize: 16),
      foregroundColor: Colors.white,
      label: label,
      onTap: onTap,
    );
  }

  Future _createHealthStatus(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.routeHealthStatusCreation,
      arguments: HealthStatusCreationScreenArguments(),
    );
  }

  Future _createBloodPressureOrPulse(BuildContext context) {
    return Navigator.pushNamed(
      context,
      Routes.routeBloodPressureAndPulseCreation,
      arguments: BloodPressureAndPulseCreationScreenArguments(),
    );
  }
}
