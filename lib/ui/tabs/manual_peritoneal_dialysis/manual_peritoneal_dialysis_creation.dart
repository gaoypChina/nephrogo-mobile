import 'package:flutter/material.dart';
import 'package:nephrogo/ui/general/components.dart';

class ManualPeritonealDialysisCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDialFloatingActionButton(
        label: "PRADĖTI DIALIZĘ",
        onPress: () => _openDialysisCreation(context),
      ),
    );
  }

  Future<void> _openDialysisCreation(BuildContext context) {}
}
