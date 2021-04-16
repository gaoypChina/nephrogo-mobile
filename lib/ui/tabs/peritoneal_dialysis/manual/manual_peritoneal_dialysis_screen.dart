import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/manual_peritoneal_dialysis_day_balance_chart.dart';
import 'package:nephrogo/ui/charts/manual_peritoneal_dialysis_total_balance_chart.dart';
import 'package:nephrogo/ui/general/app_stream_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/manual/manual_peritoneal_dialysis_creation_screen.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/peritoneal_dialysis_components.dart';
import 'package:nephrogo/utils/excel_generator.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class ManualPeritonealDialysisScreenArguments {
  final Date initialDate;

  ManualPeritonealDialysisScreenArguments({required this.initialDate});
}

class ManualPeritonealDialysisScreen extends StatelessWidget {
  final _apiService = ApiService();
  final Date initialDate;

  ManualPeritonealDialysisScreen({Key? key, required this.initialDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.appLocalizations.peritonealDialysisTypeManualPlural,
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: context.appLocalizations.daily.toUpperCase()),
              Tab(text: context.appLocalizations.weekly.toUpperCase()),
              Tab(text: context.appLocalizations.monthly.toUpperCase()),
            ],
          ),
        ),
        floatingActionButton: PeritonealDialysisSummaryFloatingActionButton(
          reportBuilder: _buildExcelReport,
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _ManualPeritonealDialysisDialysisList(
              pagerType: PeriodPagerType.daily,
              initialDate: initialDate,
            ),
            _ManualPeritonealDialysisDialysisList(
              pagerType: PeriodPagerType.weekly,
              initialDate: initialDate,
            ),
            _ManualPeritonealDialysisDialysisList(
              pagerType: PeriodPagerType.monthly,
              initialDate: initialDate,
            ),
          ],
        ),
      ),
    );
  }

  Future<ExcelReportBuilder> _buildExcelReport(
    ExcelReportBuilder builder,
  ) async {
    final today = Date.today();

    final dailyHealthStatusesResponse = await _apiService.getHealthStatuses(
      Constants.earliestDate,
      today,
    );

    final lightDailyIntakesResponse = await _apiService
        .getLightDailyIntakeReports(Constants.earliestDate, today);

    builder.appendManualDialysisSheet(
      dailyHealthStatuses: dailyHealthStatusesResponse.dailyHealthStatuses,
      lightDailyIntakeReports:
          lightDailyIntakesResponse.dailyIntakesLightReports,
    );

    return builder;
  }
}

class _ManualPeritonealDialysisDialysisList extends StatelessWidget {
  final ApiService _apiService = ApiService();
  final PeriodPagerType pagerType;
  final Date initialDate;

  _ManualPeritonealDialysisDialysisList({
    Key? key,
    required this.pagerType,
    required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PeriodPager(
      pagerType: pagerType,
      initialDate: initialDate,
      earliestDate: Constants.earliestDate,
      bodyBuilder: _bodyBuilder,
    );
  }

  Widget _bodyBuilder(BuildContext context, Widget header, Date from, Date to) {
    return AppStreamBuilder<HealthStatusWeeklyScreenResponse>(
      stream: () => _apiService.getHealthStatusesStream(from, to),
      builder: (context, data) {
        final sortedReports = data.dailyHealthStatuses
            .where((s) => s.manualPeritonealDialysis.isNotEmpty)
            .orderBy((e) => e.date, reverse: true)
            .toList();

        if (sortedReports.isEmpty) {
          return DateSwitcherHeaderSection(
            header: header,
            children: [
              EmptyStateContainer(
                text: context
                    .appLocalizations.manualPeritonealDialysisPeriodEmpty,
              )
            ],
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 64),
          itemBuilder: (context, index) {
            if (index == 0) {
              return DateSwitcherHeaderSection(
                header: header,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getGraph(sortedReports, from, to),
                  ),
                ],
              );
            } else {
              return ManualPeritonealDialysisReportSection(
                dailyHealthStatus: sortedReports[index - 1],
              );
            }
          },
          itemCount: sortedReports.length + 1,
        );
      },
    );
  }

  Widget _getGraph(
    Iterable<DailyHealthStatus> dailyHealthStatus,
    Date from,
    Date to,
  ) {
    if (pagerType == PeriodPagerType.daily) {
      final dialysis = dailyHealthStatus
          .expand((e) => e.manualPeritonealDialysis)
          .orderBy((e) => e.startedAt, reverse: true)
          .toList();

      return ManualPeritonealDialysisDayBalanceChart(
        manualPeritonealDialysis: dialysis,
        date: from,
      );
    }

    return ManualPeritonealDialysisTotalBalanceChart(
      dailyHealthStatuses: dailyHealthStatus.toList(),
      minimumDate: from,
      maximumDate: to,
    );
  }
}

class ManualPeritonealDialysisReportSection extends StatelessWidget {
  final _dateFormat = DateFormat.MMMMd();

  final DailyHealthStatus dailyHealthStatus;

  ManualPeritonealDialysisReportSection({
    Key? key,
    required this.dailyHealthStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedDialysis = dailyHealthStatus.manualPeritonealDialysis
        .orderBy((d) => d.startedAt, reverse: true);

    return LargeSection(
      title: Text(_dateFormat.format(dailyHealthStatus.date).capitalizeFirst()),
      subtitle: Text(
        '${context.appLocalizations.dailyBalance}: '
        '${dailyHealthStatus.totalManualPeritonealDialysisBalanceFormatted}',
      ),
      children: [
        for (final dialysis in sortedDialysis)
          ManualPeritonealDialysisTile(dialysis)
      ],
    );
  }
}

class ManualPeritonealDialysisTile extends StatelessWidget {
  final ManualPeritonealDialysis dialysis;
  final _dateTimeFormat = DateFormat.MMMMd().add_Hm();

  ManualPeritonealDialysisTile(this.dialysis) : super(key: ObjectKey(dialysis));

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: CircleAvatar(
        backgroundColor: dialysis.dialysisSolution?.color,
        foregroundColor: dialysis.dialysisSolution?.textColor,
        child: _getIcon(),
      ),
      title: Text(_dateTimeFormat
          .format(dialysis.startedAt.toLocal())
          .capitalizeFirst()),
      // isThreeLine: true,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 4,
            runSpacing: 2,
            children: [
              TextWithLeadingIcon(
                icon: Icons.next_plan_outlined,
                text: Text(dialysis.formattedSolutionIn),
                semanticLabel: context.appLocalizations.dialysisSolutionIn,
              ),
              if (dialysis.solutionOutMl != null)
                TextWithLeadingIcon(
                  icon: Icons.outbond_outlined,
                  text: Text(dialysis.formattedSolutionOut),
                  semanticLabel: context.appLocalizations.dialysisSolutionOut,
                ),
              if (dialysis.hasValidDuration)
                TextWithLeadingIcon(
                  icon: Icons.timer,
                  text: Text(
                    dialysis.duration.formatHoursAndMinutes(
                      context.appLocalizations,
                    ),
                  ),
                  semanticLabel: context.appLocalizations.duration,
                ),
              if (isDialysateColorWarning)
                TextWithLeadingIcon(
                  text: Text(
                    dialysis.dialysateColor!
                        .localizedName(context.appLocalizations),
                  ),
                  icon: Icons.error_outline,
                ),
            ],
          ),
          if (dialysis.notes != null && dialysis.notes!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(dialysis.notes!),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dialysis.isCompleted!)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(dialysis.formattedBalance),
            ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => Navigator.of(context).pushNamed(
        Routes.routeManualPeritonealDialysisCreation,
        arguments: ManualPeritonealDialysisCreationScreenArguments(dialysis),
      ),
    );
  }

  bool get isDialysateColorWarning {
    return dialysis.dialysateColor != DialysateColorEnum.transparent &&
        dialysis.dialysateColor != DialysateColorEnum.unknown;
  }

  Widget? _getIcon() {
    if (!dialysis.isCompleted!) {
      return const Icon(Icons.sync_outlined);
    } else if (isDialysateColorWarning) {
      return const Icon(Icons.error_outline);
    } else {
      return null;
    }
  }
}
