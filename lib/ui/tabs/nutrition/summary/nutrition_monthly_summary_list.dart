import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_calendar.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NutritionMonthlyReportsList extends StatefulWidget {
  final List<DailyIntakesLightReport> reports;
  final Widget header;

  NutritionMonthlyReportsList({
    Key key,
    @required this.reports,
    @required this.header,
  })  : assert(reports != null),
        assert(reports.isNotEmpty),
        assert(header != null),
        super(key: key);

  @override
  NutritionMonthlyReportsListState createState() =>
      NutritionMonthlyReportsListState();
}

class NutritionMonthlyReportsListState
    extends State<NutritionMonthlyReportsList> {
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
          return BasicSection(
            innerPadding: const EdgeInsets.all(8.0),
            children: [
              widget.header,
              NutritionCalendar(
                reportsReverseSorted,
                onDaySelected: (dt) =>
                    _onSelectionChanged(dt, reportsReverseSorted),
              ),
            ],
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
