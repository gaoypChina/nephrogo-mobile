import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/ui/charts/automatic_peritoneal_dialysis_balance_chart.dart';
import 'package:nephrogo/ui/general/app_stream_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/period_pager.dart';
import 'package:nephrogo/ui/tabs/nutrition/summary/nutrition_summary_components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/automatic/automatic_peritoneal_dialysis_components.dart';
import 'package:nephrogo/ui/tabs/peritoneal_dialysis/peritoneal_dialysis_components.dart';
import 'package:nephrogo/utils/excel_generator.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class AutomaticPeritonealDialysisPeriodsScreenArguments {
  final Date initialDate;

  AutomaticPeritonealDialysisPeriodsScreenArguments({
    required this.initialDate,
  });
}

class AutomaticPeritonealDialysisPeriodsScreen extends StatelessWidget {
  final _apiService = ApiService();
  final Date initialDate;

  AutomaticPeritonealDialysisPeriodsScreen({
    super.key,
    required this.initialDate,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.appLocalizations.peritonealDialysisTypeAutomaticPlural,
          ),
          bottom: TabBar(
            tabs: [
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

  Future<ExcelReportBuilder> _buildExcelReport(
    ExcelReportBuilder builder,
  ) async {
    final dialysisResponse =
        await _apiService.getAutomaticPeritonealDialysisPeriod(
      Constants.earliestDate,
      DateTime.now().toDate(),
    );

    builder.appendAutomaticDialysisSheet(
      peritonealDialysis: dialysisResponse.peritonealDialysis,
    );

    return builder;
  }
}

class _AutomaticPeritonealDialysisPeriodsScreenBody extends StatelessWidget {
  final ApiService _apiService = ApiService();
  final PeriodPagerType pagerType;
  final Date initialDate;

  _AutomaticPeritonealDialysisPeriodsScreenBody({
    required this.pagerType,
    required this.initialDate,
  });

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
      stream: () =>
          _apiService.getAutomaticPeritonealDialysisPeriodStream(from, to),
      builder: (context, data) {
        final sortedDialysis = data.peritonealDialysis
            .orderBy((e) => e.date, reverse: true)
            .toList();

        if (sortedDialysis.isEmpty) {
          return DateSwitcherHeaderSection(
            header: header,
            children: [
              EmptyStateContainer(
                text: context
                    .appLocalizations.manualPeritonealDialysisPeriodEmpty,
              ),
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
                      minimumDate: from.toDateTime(),
                      maximumDate: to.toDateTime(),
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
