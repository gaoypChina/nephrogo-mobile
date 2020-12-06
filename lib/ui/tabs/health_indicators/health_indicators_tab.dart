import 'package:flutter/material.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/general/progress_indicator.dart';
import 'package:nephrolog/extensions/date_extensions.dart';
import 'package:nephrolog/ui/general/weekly_pager.dart';

import 'health_indicators_section.dart';
import 'weekly_health_indicators_screen.dart';

class HealthIndicatorsTab extends StatelessWidget {
  final ValueNotifier<int> valueNotifier = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return WeeklyHealthIndicatorsScreen(
      initialHealthIndicator: HealthIndicator.bloodPressure,
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => valueNotifier.value = valueNotifier.value + 1,
        label: Text("PRIDĖTI RODIKLIUS"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return WeeklyPager<int>(
      valueChangeNotifier: valueNotifier,
      bodyBuilder: (from, to, value) {
        return Text(
            "Hello ${from.toIso8601String()} \n${to.toIso8601String()}\n"
            " and $value");
      },
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

          return HealthIndicatorsList(dailyHealthStatuses: dailyHealthStatuses);
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error));
        }

        return Center(child: AppProgressIndicator());
      },
    );
  }
}
