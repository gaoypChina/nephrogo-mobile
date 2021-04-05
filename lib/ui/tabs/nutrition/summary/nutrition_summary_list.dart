import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_calendar.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'nutrition_summary_components.dart';

class NutritionMonthlyReportsList extends StatefulWidget {
  final List<DailyIntakesLightReport> reports;
  final Widget header;

  NutritionMonthlyReportsList({
    Key? key,
    required this.reports,
    required this.header,
  })   : assert(reports.isNotEmpty),
        super(key: key);

  @override
  NutritionMonthlyReportsListState createState() =>
      NutritionMonthlyReportsListState();
}

class NutritionMonthlyReportsListState
    extends State<NutritionMonthlyReportsList> {
  late ItemScrollController _itemScrollController;

  late List<DailyIntakesLightReport> reportsReverseSorted;

  @override
  void initState() {
    super.initState();

    _itemScrollController = ItemScrollController();
    reportsReverseSorted = widget.reports
        .orderBy(
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
                padding: const EdgeInsets.only(top: 16.0, right: 8, left: 8),
                child: NutritionCalendar(
                  reportsReverseSorted,
                  onDaySelected: (dt) =>
                      _onSelectionChanged(dt, reportsReverseSorted),
                ),
              ),
            ],
          );
        }
        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return DailyIntakesReportSection(dailyIntakesReport);
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
    final index = reports.indexWhere((r) => r.date == Date.from(dateTime));

    if (index == -1) {
      return 1;
    }
    return index;
  }
}

class NutritionWeeklyReportsList extends StatelessWidget {
  final List<DailyIntakesLightReport> reports;
  final Widget header;

  NutritionWeeklyReportsList({
    Key? key,
    required this.reports,
    required this.header,
  })   : assert(reports.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportsReverseSorted =
        reports.orderBy((e) => e.date, reverse: true).toList();

    return ListView.builder(
      itemCount: reportsReverseSorted.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DateSwitcherHeaderSection(header: header);
        }
        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return DailyIntakesReportSection(dailyIntakesReport);
      },
    );
  }
}
