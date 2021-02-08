import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'nutrition_calendar.dart';
import 'nutrition_components.dart';

class MyDailyIntakesReportsScreen extends StatelessWidget {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.nutritionSummary)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AppStreamBuilder<DailyIntakesReportsResponse>(
          stream: _apiService.getLightDailyIntakeReportsStream(),
          builder: (context, data) {
            return Visibility(
              visible: data.dailyIntakesLightReports.isNotEmpty,
              replacement: EmptyStateContainer(
                text: AppLocalizations.of(context).weeklyNutrientsEmpty,
              ),
              child: _MyDailyIntakesReportsNonEmptyListBody(data),
            );
          }),
    );
  }
}

class _MyDailyIntakesReportsNonEmptyListBody extends StatefulWidget {
  final DailyIntakesReportsResponse response;

  const _MyDailyIntakesReportsNonEmptyListBody(
    this.response, {
    Key key,
  }) : super(key: key);

  @override
  _MyDailyIntakesReportsNonEmptyListBodyState createState() =>
      _MyDailyIntakesReportsNonEmptyListBodyState();
}

class _MyDailyIntakesReportsNonEmptyListBodyState
    extends State<_MyDailyIntakesReportsNonEmptyListBody> {
  ItemScrollController _itemScrollController;

  DateTime minDate;
  DateTime maxDate;
  DateRangePickerController _datePickerController;

  List<DailyIntakesLightReport> _reportsSortedByDateReverse;

  @override
  void initState() {
    _reportsSortedByDateReverse = widget.response.dailyIntakesLightReports
        .sortedBy((e) => e.date, reverse: true)
        .toList();

    minDate = _reportsSortedByDateReverse.last.date;
    maxDate = _reportsSortedByDateReverse.first.date;

    _itemScrollController = ItemScrollController();

    _datePickerController = DateRangePickerController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: _reportsSortedByDateReverse.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return BasicSection.single(
            Container(
              key: const Key("daily-intakes-calendar"),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NutritionCalendar(
                  _reportsSortedByDateReverse,
                  datePickerController: _datePickerController,
                  onSelectionChanged: _onSelectionChanged,
                ),
              ),
            ),
          );
        }
        final dailyIntakesReport = _reportsSortedByDateReverse[index - 1];

        return DailyIntakesReportTile(dailyIntakesReport);
      },
    );
  }

  void _onSelectionChanged(DateTime dateTime) {
    final position = getReportPosition(dateTime);

    _itemScrollController.jumpTo(index: position);
  }

  int getReportPosition(DateTime dateTime) {
    return _reportsSortedByDateReverse
            .mapIndexed((i, r) => r.date == Date(dateTime) ? i : null)
            .firstWhere((i) => i != null) +
        1;
  }

  @override
  void dispose() {
    _datePickerController.dispose();

    super.dispose();
  }
}
