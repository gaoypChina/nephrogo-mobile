import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_calendar.dart';
import 'package:nephrogo/ui/tabs/nutrition/nutrition_components.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
    return ScrollablePositionedList.separated(
      itemScrollController: _itemScrollController,
      itemCount: reportsReverseSorted.length + 1,
      separatorBuilder: (context, i) => const Divider(height: 1),
      itemBuilder: (context, index) {
        if (index == 0) {
          return BasicSection(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: widget.header,
              ),
              NutritionCalendar(
                reportsReverseSorted,
                onDaySelected: (dt) =>
                    _onSelectionChanged(dt, reportsReverseSorted),
                nutrient: widget.nutrient,
              ),
            ],
          );
        }
        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return NutrientDailyNutritionTile.fromLightReport(
          widget.nutrient,
          dailyIntakesReport,
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
  final Widget header;
  final Nutrient nutrient;

  NutritionNutrientWeeklyReportsList({
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
  Widget build(BuildContext context) {
    final reportsReverseSorted =
        reports.sortedBy((e) => e.date, reverse: true).toList();

    return ListView.separated(
      itemCount: reportsReverseSorted.length + 1,
      separatorBuilder: (context, i) => const Divider(height: 1),
      itemBuilder: (context, index) {
        if (index == 0) {
          return BasicSection.single(
            header,
            innerPadding: const EdgeInsets.symmetric(vertical: 8),
          );
        }
        final dailyIntakesReport = reportsReverseSorted[index - 1];

        return NutrientDailyNutritionTile.fromLightReport(
          nutrient,
          dailyIntakesReport,
        );
      },
    );
  }
}
