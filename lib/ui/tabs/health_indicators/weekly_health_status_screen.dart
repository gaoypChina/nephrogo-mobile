import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrolog/extensions/collection_extensions.dart';
import 'package:nephrolog/extensions/contract_extensions.dart';
import 'package:nephrolog/extensions/string_extensions.dart';
import 'package:nephrolog/l10n/localizations.dart';
import 'package:nephrolog/models/contract.dart';
import 'package:nephrolog/services/api_service.dart';
import 'package:nephrolog/ui/charts/weekly_health_indicator_bar_chart.dart';
import 'package:nephrolog/ui/general/app_future_builder.dart';
import 'package:nephrolog/ui/general/components.dart';
import 'package:nephrolog/ui/general/weekly_pager.dart';
import 'package:nephrolog_api_client/model/daily_health_status.dart';
import 'package:nephrolog_api_client/model/health_status_weekly_screen_response.dart';

class WeeklyHealthStatusScreenArguments {
  final HealthIndicator initialHealthIndicator;

  const WeeklyHealthStatusScreenArguments(this.initialHealthIndicator);
}

class WeeklyHealthStatusScreen extends StatefulWidget {
  final HealthIndicator initialHealthIndicator;

  const WeeklyHealthStatusScreen({Key key, this.initialHealthIndicator})
      : super(key: key);

  @override
  _WeeklyHealthStatusScreenState createState() =>
      _WeeklyHealthStatusScreenState();
}

class _WeeklyHealthStatusScreenState extends State<WeeklyHealthStatusScreen> {
  ValueNotifier<HealthIndicator> healthIndicatorChangeNotifier;
  HealthIndicator selectedHealthIndicator;

  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();

    healthIndicatorChangeNotifier =
        ValueNotifier(widget.initialHealthIndicator);
    selectedHealthIndicator = widget.initialHealthIndicator;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedHealthIndicator.name(appLocalizations)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showIndicatorSelectionPopupMenu(appLocalizations),
        label: Text(appLocalizations.healthIndicator),
        icon: Icon(Icons.swap_horizontal_circle),
      ),
      body: WeeklyPager<HealthIndicator>(
        valueChangeNotifier: healthIndicatorChangeNotifier,
        bodyBuilder: (from, to, indicator) {
          return AppFutureBuilder<HealthStatusWeeklyScreenResponse>(
            future: _apiService.getWeeklyHealthStatusReport(from, to),
            builder: (context, data) {
              return HealthIndicatorsListWithChart(
                dailyHealthStatuses: data.dailyHealthStatuses.toList(),
                healthIndicator: selectedHealthIndicator,
                from: from,
                to: to,
                appLocalizations: appLocalizations,
              );
            },
          );
        },
      ),
    );
  }

  _changeHealthIndicator(HealthIndicator healthIndicator) {
    setState(() {
      selectedHealthIndicator = healthIndicator;
      healthIndicatorChangeNotifier.value = healthIndicator;
    });
  }

  Future _showIndicatorSelectionPopupMenu(
      AppLocalizations appLocalizations) async {
    final options = HealthIndicator.values.map((hi) {
      return SimpleDialogOption(
        child: Text(hi.name(appLocalizations)),
        onPressed: () => Navigator.pop(context, hi),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      );
    }).toList();

    final selectedHealthIndicator = await showDialog<HealthIndicator>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(appLocalizations.chooseHealthIndicator),
          children: options,
        );
      },
    );

    if (selectedHealthIndicator != null) {
      _changeHealthIndicator(selectedHealthIndicator);
    }
  }
}

class HealthIndicatorsListWithChart extends StatelessWidget {
  final HealthIndicator healthIndicator;
  final List<DailyHealthStatus> dailyHealthStatuses;
  final AppLocalizations appLocalizations;
  final DateTime from;
  final DateTime to;

  const HealthIndicatorsListWithChart({
    Key key,
    @required this.dailyHealthStatuses,
    @required this.healthIndicator,
    @required this.appLocalizations,
    @required this.from,
    @required this.to,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 64),
      children: [
        BasicSection(
          children: [
            HealthIndicatorWeeklyBarChart(
              dailyHealthStatuses: dailyHealthStatuses,
              indicator: healthIndicator,
              appLocalizations: appLocalizations,
              maximumDate: to,
            ),
          ],
        ),
        BasicSection(children: _buildIndicatorTiles()),
      ],
    );
  }

  List<Widget> _buildIndicatorTiles() {
    return dailyHealthStatuses
        .where((dhs) => dhs.isIndicatorExists(healthIndicator))
        .sortedBy((e) => e.date, reverse: true)
        .map((dhs) => DailyHealthStatusIndicatorTile(
              dailyHealthStatus: dhs,
              indicator: healthIndicator,
            ))
        .toList();
  }
}

class DailyHealthStatusIndicatorTile extends StatelessWidget {
  static final _dateFormat = DateFormat("EEEE, MMMM d");

  final DailyHealthStatus dailyHealthStatus;
  final HealthIndicator indicator;

  const DailyHealthStatusIndicatorTile({
    Key key,
    @required this.dailyHealthStatus,
    @required this.indicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final dateTitle =
        _dateFormat.format(dailyHealthStatus.date).capitalizeFirst();

    return AppListTile(
      title: Text(dateTitle),
      trailing: Text(dailyHealthStatus.getHealthIndicatorFormatted(
          indicator, appLocalizations)),
    );
  }
}
