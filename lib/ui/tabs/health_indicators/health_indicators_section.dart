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
    @required this.dailyHealthStatuses,
    @required this.healthIndicator,
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

  final String title;
  final DailyHealthStatus dailyHealthStatus;
  final Widget leading;

  const DailyHealthStatusSection({
    Key key,
    @required this.dailyHealthStatus,
    this.title,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormatted = _dateFormat.format(dailyHealthStatus.date);
    final dateTitle = "$dateFormatted d.".capitalizeFirst();

    return LargeSection(
      title: title ?? dateTitle,
      leading: leading,
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
