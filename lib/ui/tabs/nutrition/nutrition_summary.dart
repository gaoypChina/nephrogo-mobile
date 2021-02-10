import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/app_future_builder.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/general/monthly_pager.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';
import 'package:nephrogo_api_client/model/user.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'nutrition_calendar.dart';
import 'nutrition_components.dart';

class NutritionSummaryScreen extends StatefulWidget {
  @override
  _NutritionSummaryScreenState createState() => _NutritionSummaryScreenState();
}

class _NutritionSummaryScreenState extends State<NutritionSummaryScreen> {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.nutritionSummary)),
      body: AppStreamBuilder<User>(
        stream: _apiService.getUserStream(),
        builder: (context, userData) {
          final nutritionSummary = userData.nutritionSummary;
          return Visibility(
            visible: nutritionSummary.minReportDate != null,
            replacement: EmptyStateContainer(
              text: AppLocalizations.of(context).nutritionEmpty,
            ),
            child: MonthlyPager(
              earliestDate: nutritionSummary.minReportDate.toDate(),
              initialDate: nutritionSummary.maxReportDate.toDate(),
              bodyBuilder: (context, from, to) {
                return AppFutureBuilder<DailyIntakesReportsResponse>(
                  future: _apiService.getLightDailyIntakeReports(from, to),
                  builder: (context, data) {
                    return Visibility(
                      visible: data.dailyIntakesLightReports.isNotEmpty,
                      replacement: EmptyStateContainer(
                        text: AppLocalizations.of(context).weeklyNutrientsEmpty,
                      ),
                      child: _NutritionMonthlyReportsList(
                        reports: data.dailyIntakesLightReports.toList(),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _NutritionMonthlyReportsList extends StatefulWidget {
  final List<DailyIntakesLightReport> reports;

  const _NutritionMonthlyReportsList({Key key, @required this.reports})
      : super(key: key);

  @override
  _NutritionMonthlyReportsListState createState() =>
      _NutritionMonthlyReportsListState();
}

class _NutritionMonthlyReportsListState
    extends State<_NutritionMonthlyReportsList> {
  ItemScrollController _itemScrollController;

  @override
  void initState() {
    super.initState();

    _itemScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final reportsReverseSorted =
        widget.reports.sortedBy((e) => e.date, reverse: true).toList();

    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: reportsReverseSorted.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return BasicSection.single(
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NutritionCalendar(
                  reportsReverseSorted,
                  onDaySelected: (dt) =>
                      _onSelectionChanged(dt, reportsReverseSorted),
                ),
              ),
            ),
          );
        }
        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return DailyIntakesReportTile(dailyIntakesReport);
      },
    );
  }

  void _onSelectionChanged(
    DateTime dateTime,
    List<DailyIntakesLightReport> reports,
  ) {
    final position = getReportPosition(dateTime, reports);

    _itemScrollController.jumpTo(index: position);
  }

  int getReportPosition(
    DateTime dateTime,
    List<DailyIntakesLightReport> reports,
  ) {
    return reports
            .mapIndexed((i, r) => r.date == Date.from(dateTime) ? i : null)
            .firstWhere((i) => i != null) +
        1;
  }
}
