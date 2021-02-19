import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/charts/health_indicator_bar_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_components.dart';
import 'package:nephrogo_api_client/model/daily_health_status.dart';
import 'package:nephrogo_api_client/model/health_status_weekly_screen_response.dart';

class WeeklyHealthStatusScreenArguments {
  final HealthIndicator healthIndicator;

  const WeeklyHealthStatusScreenArguments(this.healthIndicator);
}

class WeeklyHealthStatusScreen extends StatelessWidget {
  final HealthIndicator healthIndicator;

  final ApiService _apiService = ApiService();

  WeeklyHealthStatusScreen({Key key, @required this.healthIndicator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(healthIndicator.name(appLocalizations)),
      ),
      body: WeeklyPager(
        initialDate: Date.today(),
        earliestDate: Constants.earliestDate,
        bodyBuilder: (context, header, from, to) {
          return AppStreamBuilder<HealthStatusWeeklyScreenResponse>(
            stream: _apiService.getWeeklyHealthStatusReportsStream(from, to),
            builder: (context, data) {
              final showChart = data.dailyHealthStatuses
                  .any((s) => s.isIndicatorExists(healthIndicator));
              if (!showChart) {
                return DateSwitcherHeaderSection(
                  header: header,
                  children: [
                    EmptyStateContainer(
                      text: appLocalizations.weeklyHealthStatusEmpty,
                    )
                  ],
                );
              }

              return HealthIndicatorsListWithChart(
                dailyHealthStatuses: data.dailyHealthStatuses.toList(),
                header: header,
                healthIndicator: healthIndicator,
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
}

class HealthIndicatorsListWithChart extends StatelessWidget {
  final HealthIndicator healthIndicator;
  final List<DailyHealthStatus> dailyHealthStatuses;
  final AppLocalizations appLocalizations;
  final DateTime from;
  final DateTime to;
  final Widget header;

  const HealthIndicatorsListWithChart({
    Key key,
    @required this.dailyHealthStatuses,
    @required this.healthIndicator,
    @required this.appLocalizations,
    @required this.from,
    @required this.to,
    @required this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedHealthStatusesWithIndicators = dailyHealthStatuses
        .where((dhs) => dhs.isIndicatorExists(healthIndicator))
        .sortedBy((e) => e.date, reverse: true)
        .toList();

    return Scrollbar(
      child: ListView.builder(
        itemCount: sortedHealthStatusesWithIndicators.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DateSwitcherHeaderSection(
              header: header,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: HealthIndicatorBarChart(
                    dailyHealthStatuses: dailyHealthStatuses,
                    indicator: healthIndicator,
                    appLocalizations: appLocalizations,
                    from: from,
                    to: to,
                  ),
                ),
              ],
            );
          }

          final dailyHealthStatus =
              sortedHealthStatusesWithIndicators[index - 1];

          return _buildSection(dailyHealthStatus);
        },
      ),
    );
  }

  Widget _buildSection(DailyHealthStatus dailyHealthStatus) {
    if (healthIndicator.isMultiValuesPerDay) {
      return DailyHealthStatusIndicatorMultiValueSection(
        dailyHealthStatus: dailyHealthStatus,
        indicator: healthIndicator,
      );
    }

    return BasicSection(
      showDividers: true,
      children: [
        DailyHealthStatusIndicatorTile(
          dailyHealthStatus: dailyHealthStatus,
          indicator: healthIndicator,
        )
      ],
    );
  }
}

class DailyHealthStatusIndicatorMultiValueSection extends StatelessWidget {
  final dateFormat = DateFormat('EEEE, MMMM d');
  final fullDateFormat = DateFormat.yMd().add_jm();

  final DailyHealthStatus dailyHealthStatus;
  final HealthIndicator indicator;

  DailyHealthStatusIndicatorMultiValueSection({
    Key key,
    @required this.dailyHealthStatus,
    @required this.indicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = dailyHealthStatus.date.toLocal();
    final values = dailyHealthStatus.getHealthIndicatorValuesFormatted(
      indicator,
      context.appLocalizations,
    );

    return BasicSection(
      header: AppListTile(
        title: Text(dateFormat.format(date).capitalizeFirst()),
        subtitle: Text(indicator.name(context.appLocalizations)),
        leading: CircleAvatar(child: Text(date.day.toString())),
      ),
      showDividers: true,
      showHeaderDivider: true,
      children: [
        for (final value in values)
          AppListTile(
            title: Text(fullDateFormat.format(value.item1)),
            trailing: Text(value.item2),
            dense: true,
          )
      ],
    );
  }
}

class DailyHealthStatusIndicatorTile extends StatelessWidget {
  static final _dateFormat = DateFormat('EEEE, MMMM d');

  final DailyHealthStatus dailyHealthStatus;
  final HealthIndicator indicator;

  const DailyHealthStatusIndicatorTile({
    Key key,
    @required this.dailyHealthStatus,
    @required this.indicator,
  }) : super(key: key);

  String getSubtitle(AppLocalizations appLocalizations) {
    if (indicator == HealthIndicator.swellings) {
      return dailyHealthStatus.swellings
          .map((s) => s.getLocalizedName(appLocalizations))
          .where((s) => s != null)
          .join(', ')
          .toLowerCase()
          .capitalizeFirst();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    final dateTitle =
        _dateFormat.format(dailyHealthStatus.date).capitalizeFirst();
    final subtitle = getSubtitle(appLocalizations);

    return AppListTile(
      title: Text(dateTitle),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Text(dailyHealthStatus.getHealthIndicatorFormatted(
          indicator, appLocalizations)),
    );
  }
}
