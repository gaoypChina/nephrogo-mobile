import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/charts/nutrient_weekly_bar_chart.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_calendar.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'nutrition_summary_components.dart';

class NutritionNutrientMonthlyReportsList extends StatefulWidget {
  final List<DailyIntakesLightReport> reports;
  final Widget header;
  final Nutrient nutrient;

  NutritionNutrientMonthlyReportsList({
    Key key,
    @required this.reports,
    @required this.header,
    @required this.nutrient,
  })  : assert(reports != null),
        assert(reports.isNotEmpty),
        assert(header != null),
        assert(nutrient != null),
        super(key: key);

  @override
  NutritionNutrientMonthlyReportsListState createState() =>
      NutritionNutrientMonthlyReportsListState();
}

class NutritionNutrientMonthlyReportsListState
    extends State<NutritionNutrientMonthlyReportsList> {
  ItemScrollController _itemScrollController;

  List<DailyIntakesLightReport> reportsReverseSorted;

  @override
  void initState() {
    super.initState();

    _itemScrollController = ItemScrollController();
    reportsReverseSorted = widget.reports
        .sortedBy(
          (e) => e.date,
          reverse: true,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: reportsReverseSorted.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DateSwitcherHeaderSection(
            header: widget.header,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: NutritionCalendar(
                  reportsReverseSorted,
                  onDaySelected: (dt) =>
                      _onSelectionChanged(dt, reportsReverseSorted),
                  nutrient: widget.nutrient,
                ),
              ),
            ],
          );
        }

        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return BasicSection.single(
          NutrientDailyNutritionTile.fromLightReport(
            widget.nutrient,
            dailyIntakesReport,
          ),
        );
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

class NutritionNutrientWeeklyReportsList extends StatelessWidget {
  final List<DailyIntakesLightReport> reports;
  final Date dateFrom;
  final Date dateTo;
  final Widget header;
  final Nutrient nutrient;

  NutritionNutrientWeeklyReportsList({
    Key key,
    @required this.reports,
    @required this.header,
    @required this.nutrient,
    @required this.dateFrom,
    @required this.dateTo,
  })  : assert(reports != null),
        assert(reports.isNotEmpty),
        assert(header != null),
        assert(nutrient != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportsReverseSorted =
        reports.sortedBy((e) => e.date, reverse: true).toList();

    return ListView.builder(
      itemCount: reportsReverseSorted.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DateSwitcherHeaderSection(
            header: header,
            children: [
              NutrientWeeklyBarChart(
                dailyIntakeLightReports: reportsReverseSorted,
                nutrient: nutrient,
                minimumDate: dateFrom,
                maximumDate: dateTo,
              ),
            ],
          );
        }
        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return BasicSection.single(
          NutrientDailyNutritionTile.fromLightReport(
            nutrient,
            dailyIntakesReport,
          ),
        );
      },
    );
  }
}
