import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/routes.dart';
import 'package:nephrogo/ui/charts/manual_peritoneal_dialysis_day_balance_chart.dart';
import 'package:nephrogo/ui/charts/manual_peritoneal_dialysis_total_balance_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/dialogs.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo/ui/general/progress_dialog.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/manual/manual_peritoneal_dialysis_creation_screen.dart';
import 'package:nephrogo_api_client/model/daily_health_status.dart';
import 'package:nephrogo_api_client/model/dialysate_color_enum.dart';
import 'package:nephrogo_api_client/model/health_status_weekly_screen_response.dart';
import 'package:nephrogo_api_client/model/manual_peritoneal_dialysis.dart';
import 'package:open_file/open_file.dart';
import 'package:share/share.dart';

import 'excel/manual_peritoneal_dialysis_excel_generator.dart';

class ManualPeritonealDialysisScreenArguments {
  final Date initialDate;

  ManualPeritonealDialysisScreenArguments({@required this.initialDate});
}

class ManualPeritonealDialysisScreen extends StatelessWidget {
  final _apiService = ApiService();
  final Date initialDate;

  ManualPeritonealDialysisScreen({Key key, @required this.initialDate})
      : assert(initialDate != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.appLocalizations.peritonealDialysisPlural),
          bottom: TabBar(
            tabs: [
              Tab(text: context.appLocalizations.daily.toUpperCase()),
              Tab(text: context.appLocalizations.weekly.toUpperCase()),
              Tab(text: context.appLocalizations.monthly.toUpperCase()),
            ],
          ),
        ),
        floatingActionButton: SpeedDialFloatingActionButton(
          label: context.appLocalizations.summary.toUpperCase(),
          icon: Icons.download_rounded,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.open_in_new),
              backgroundColor: Colors.indigo,
              labelStyle: const TextStyle(fontSize: 16),
              foregroundColor: Colors.white,
              label: context.appLocalizations.open,
              onTap: () => _downloadAndExportDialysis(context, false),
            ),
            SpeedDialChild(
              child: const Icon(Icons.share),
              backgroundColor: Colors.teal,
              labelStyle: const TextStyle(fontSize: 16),
              foregroundColor: Colors.white,
              label: context.appLocalizations.send,
              onTap: () => _downloadAndExportDialysis(context, true),
            ),
          ],
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

  Future<void> _downloadAndExportDialysisInternal(
      BuildContext context, bool share) async {
    final today = Date.today();
    final dailyHealthStatusesResponse = await _apiService.getHealthStatuses(
      Constants.earliestDate,
      today,
    );

    final dailyHealthStatuses = dailyHealthStatusesResponse.dailyHealthStatuses
        .where((s) => s.manualPeritonealDialysis.isNotEmpty);

    final lightDailyIntakeReportsResponse = await _apiService
        .getLightDailyIntakeReports(Constants.earliestDate, today);

    final lightDailyIntakeReports =
        lightDailyIntakeReportsResponse.dailyIntakesLightReports;

    final fullPath =
        await ManualPeritonealDialysisExcelGenerator.generateAndSaveExcel(
      context: context,
      dailyHealthStatuses: dailyHealthStatuses,
      lightDailyIntakeReports: lightDailyIntakeReports,
    );

    if (share) {
      return Share.shareFiles(
        [fullPath],
        subject: context.appLocalizations.sendManualPeritonealDialysisSubject,
      );
    } else {
      await OpenFile.open(fullPath);
    }
  }

  Future<void> _downloadAndExportDialysis(BuildContext context, bool share) {
    final future =
        _downloadAndExportDialysisInternal(context, share).catchError(
      (e, stackTrace) async {
        FirebaseCrashlytics.instance.recordError(e, stackTrace as StackTrace);

        await showAppDialog(
          context: context,
          title: context.appLocalizations.error,
          message: context.appLocalizations.serverErrorDescription,
        );
      },
    );

    return ProgressDialog(context).showForFuture(future);
  }
}

class _ManualPeritonealDialysisDialysisList extends StatelessWidget {
  final ApiService _apiService = ApiService();
  final PeriodPagerType pagerType;
  final Date initialDate;

  _ManualPeritonealDialysisDialysisList({
    Key key,
    @required this.pagerType,
    @required this.initialDate,
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
      stream: _apiService.getHealthStatusesStream(from, to),
      builder: (context, data) {
        final sortedReports = data.dailyHealthStatuses
            .where((s) => s.manualPeritonealDialysis.isNotEmpty)
            .sortedBy((e) => e.date, reverse: true)
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
          .sortedBy((e) => e.startedAt, reverse: true)
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
    Key key,
    @required this.dailyHealthStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedDialysis = dailyHealthStatus.manualPeritonealDialysis
        .sortedBy((d) => d.startedAt, reverse: true);

    return LargeSection(
      title: Text(_dateFormat.format(dailyHealthStatus.date).capitalizeFirst()),
      subtitle: Text(
        '${context.appLocalizations.dailyBalance}: '
        '${dailyHealthStatus.totalManualPeritonealDialysisBalanceFormatted}',
      ),
      showDividers: true,
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

  ManualPeritonealDialysisTile(this.dialysis)
      : assert(dialysis != null),
        super(key: ObjectKey(dialysis));

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: CircleAvatar(
        backgroundColor: dialysis.dialysisSolution.color,
        foregroundColor: dialysis.dialysisSolution.textColor,
        child: _getIcon(),
      ),
      title: Text(_dateTimeFormat
          .format(dialysis.startedAt.toLocal())
          .capitalizeFirst()),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(Icons.next_plan_outlined, size: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(dialysis.formattedSolutionIn),
              ),
              if (dialysis.solutionOutMl != null)
                const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.outbond_outlined, size: 14),
                ),
              if (dialysis.solutionOutMl != null)
                Text(dialysis.formattedSolutionOut),
            ],
          ),
          if (isDialysateColorWarning)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.error_outline, size: 14),
                  ),
                  Text(dialysis.dialysateColor
                      .localizedName(context.appLocalizations)),
                ],
              ),
            ),
          if (dialysis.notes != null && dialysis.notes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(dialysis.notes),
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dialysis.isCompleted)
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

  Widget _getIcon() {
    if (!dialysis.isCompleted) {
      return const Icon(Icons.sync_outlined);
    } else if (isDialysateColorWarning) {
      return const Icon(Icons.error_outline);
    } else {
      return null;
    }
  }
}
