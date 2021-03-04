import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/charts/automatic_peritoneal_dialysis_balance_chart.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/automatic/automatic_peritoneal_dialysis_components.dart';
import 'package:nephrogo_api_client/model/automatic_peritoneal_dialysis_period_response.dart';

class AutomaticPeritonealDialysisPeriodsScreenArguments {
  final Date initialDate;

  AutomaticPeritonealDialysisPeriodsScreenArguments(
      {@required this.initialDate});
}

class AutomaticPeritonealDialysisPeriodsScreen extends StatelessWidget {
  final _apiService = ApiService();
  final Date initialDate;

  AutomaticPeritonealDialysisPeriodsScreen(
      {Key key, @required this.initialDate})
      : assert(initialDate != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.appLocalizations.peritonealDialysisPlural),
          bottom: TabBar(
            tabs: [
              Tab(text: context.appLocalizations.weekly.toUpperCase()),
              Tab(text: context.appLocalizations.monthly.toUpperCase()),
            ],
          ),
        ),
        floatingActionButton: SpeedDialFloatingActionButton(
          label: context.appLocalizations.summary.toUpperCase(),
          icon: Icons.download_rounded,
          children: [
            // SpeedDialChild(
            //   child: const Icon(Icons.open_in_new),
            //   backgroundColor: Colors.indigo,
            //   labelStyle: const TextStyle(fontSize: 16),
            //   foregroundColor: Colors.white,
            //   label: context.appLocalizations.open,
            //   onTap: () => _downloadAndExportDialysis(context, false),
            // ),
            // SpeedDialChild(
            //   child: const Icon(Icons.share),
            //   backgroundColor: Colors.teal,
            //   labelStyle: const TextStyle(fontSize: 16),
            //   foregroundColor: Colors.white,
            //   label: context.appLocalizations.send,
            //   onTap: () => _downloadAndExportDialysis(context, true),
            // ),
          ],
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _AutomaticPeritonealDialysisPeriodsScreenBody(
              pagerType: PeriodPagerType.weekly,
              initialDate: initialDate,
            ),
            _AutomaticPeritonealDialysisPeriodsScreenBody(
              pagerType: PeriodPagerType.monthly,
              initialDate: initialDate,
            ),
          ],
        ),
      ),
    );
  }

// Future<void> _downloadAndExportDialysisInternal(
//     BuildContext context, bool share) async {
//   final today = Date.today();
//   final dailyHealthStatusesResponse = await _apiService.getHealthStatuses(
//     Constants.earliestDate,
//     today,
//   );
//
//   final dailyHealthStatuses = dailyHealthStatusesResponse.dailyHealthStatuses
//       .where((s) => s.manualPeritonealDialysis.isNotEmpty);
//
//   final lightDailyIntakeReportsResponse = await _apiService
//       .getLightDailyIntakeReports(Constants.earliestDate, today);
//
//   final lightDailyIntakeReports =
//       lightDailyIntakeReportsResponse.dailyIntakesLightReports;
//
//   final fullPath =
//       await ManualPeritonealDialysisExcelGenerator.generateAndSaveExcel(
//     context: context,
//     dailyHealthStatuses: dailyHealthStatuses,
//     lightDailyIntakeReports: lightDailyIntakeReports,
//   );
//
//   if (share) {
//     return Share.shareFiles(
//       [fullPath],
//       subject: context.appLocalizations.sendManualPeritonealDialysisSubject,
//     );
//   } else {
//     await OpenFile.open(fullPath);
//   }
// }
//
// Future<void> _downloadAndExportDialysis(BuildContext context, bool share) {
//   final future =
//       _downloadAndExportDialysisInternal(context, share).catchError(
//     (e, stackTrace) async {
//       FirebaseCrashlytics.instance.recordError(e, stackTrace as StackTrace);
//
//       await showAppDialog(
//         context: context,
//         title: context.appLocalizations.error,
//         message: context.appLocalizations.serverErrorDescription,
//       );
//     },
//   );
//
//   return ProgressDialog(context).showForFuture(future);
// }
}

class _AutomaticPeritonealDialysisPeriodsScreenBody extends StatelessWidget {
  final ApiService _apiService = ApiService();
  final PeriodPagerType pagerType;
  final Date initialDate;

  _AutomaticPeritonealDialysisPeriodsScreenBody({
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
    return AppStreamBuilder<AutomaticPeritonealDialysisPeriodResponse>(
      stream: _apiService.getAutomaticPeritonealDialysisPeriodStream(from, to),
      builder: (context, data) {
        final sortedDialysis = data.peritonealDialysis
            .sortedBy((e) => e.date, reverse: true)
            .toList();

        if (sortedDialysis.isEmpty) {
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
                    child: AutomaticPeritonealDialysisBalanceChart(
                      minimumDate: from,
                      maximumDate: to,
                      dialysis: sortedDialysis,
                    ),
                  ),
                ],
              );
            } else {
              return BasicSection.single(
                child: AutomaticPeritonealDialysisTile(
                  sortedDialysis[index - 1],
                ),
              );
            }
          },
          itemCount: sortedDialysis.length + 1,
        );
      },
    );
  }
}
