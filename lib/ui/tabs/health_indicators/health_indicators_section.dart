import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';

class HealthIndicatorsList extends StatelessWidget {
  final HealthIndicator healthIndicator;
  final List<DailyHealthStatus> dailyHealthStatuses;

  const HealthIndicatorsList({
    Key key,
    this.dailyHealthStatuses,
    this.healthIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dailyHealthStatuses.length,
      itemBuilder: (context, index) {
        return DailyHealthStatusSection(
          dailyHealthStatus: dailyHealthStatuses[index],
        );
      },
    );
  }
}

class DailyHealthStatusSection extends StatelessWidget {
  static final _dateFormat = DateFormat("EEEE, d");

  final DailyHealthStatus dailyHealthStatus;

  const DailyHealthStatusSection({Key key, this.dailyHealthStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LargeSection(
      title: _dateFormat.format(dailyHealthStatus.date).capitalizeFirst() + " d.",
      children: _buildHealthIndicatorsTiles(),
    );
  }

  List<Widget> _buildHealthIndicatorsTiles() {
    return HealthIndicator.values.map((h) {
      return AppListTile(
        title: Text(h.name),
        trailing: Text(dailyHealthStatus.getHealthIndicatorFormatted(h) ?? "-"),
      );
    }).toList();
  }
}
