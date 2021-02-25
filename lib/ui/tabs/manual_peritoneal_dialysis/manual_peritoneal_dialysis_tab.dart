import 'package:flutter/material.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/general/buttons.dart';
import 'package:nephrogo/ui/general/components.dart';

class ManualPeritonealDialysisTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDialFloatingActionButton(
        label: "PRADĖTI DIALIZĘ",
        onPress: () => _openDialysisCreation(context),
      ),
      body: ListView(
        children: [
          AppElevatedButton(
            text: "Visi",
            onPressed: () => Navigator.of(context)
                .pushNamed(Routes.routeManualPeritonealDialysisAllScreen),
          )
        ],
      ),
    );
  }

  Future<void> _openDialysisCreation(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(Routes.routeManualPeritonealDialysisCreation);
  }
}
