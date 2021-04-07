import 'package:flutter/material.dart';
import 'package:nephrogo/preferences/app_preferences.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

import 'automatic/automatic_peritoneal_dialysis_tab.dart';
import 'manual/manual_peritoneal_dialysis_tab.dart';

class PeritonealDialysisTab extends StatelessWidget {
  final _appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder<DialysisEnum>(
      future: _appPreferences.getDialysisType(),
      builder: (context, peritonealDialysisType) {
        if (peritonealDialysisType == DialysisEnum.manualPeritonealDialysis) {
          return ManualPeritonealDialysisTab();
        } else {
          return AutomaticPeritonealDialysisTab();
        }
      },
    );
  }
}
