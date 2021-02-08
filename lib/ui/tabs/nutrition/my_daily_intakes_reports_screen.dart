import 'package:flutter/material.dart';
import 'package:nephrogo/api/api_service.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/ui/general/app_steam_builder.dart';
import 'package:nephrogo/ui/general/components.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:nephrogo_api_client/model/daily_intakes_reports_response.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'nutrition_components.dart';

class MyDailyIntakesReportsScreen extends StatelessWidget {
  final _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(appLocalizations.nutritionSummary)),
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
    extends State<_MyDailyIntakesReportsNonEmptyListBody>
    with SingleTickerProviderStateMixin {
  bool _isCalendarVisible;

  ItemScrollController _itemScrollController;

  DateTime minDate;
  DateTime maxDate;
  DateRangePickerController _datePickerController;

  List<DailyIntakesLightReport> _reportsSortedByDateReverse;

  @override
  void initState() {
    _isCalendarVisible = false;

    _reportsSortedByDateReverse = widget.response.dailyIntakesLightReports
        .sortedBy((e) => e.date, reverse: true)
        .toList();

    minDate = _reportsSortedByDateReverse.last.date;
    maxDate = _reportsSortedByDateReverse.first.date;

    _itemScrollController = ItemScrollController();

    _datePickerController = DateRangePickerController();

    super.initState();
  }

  void _closeCalendar() {
    setState(() => _isCalendarVisible = false);
  }

  Widget _buildCalendar() {
    final allDates = _reportsSortedByDateReverse.map((r) => Date(r.date));

    final availableDates = allDates.toSet();
    final blackoutDates = DateUtils.generateDates(minDate, maxDate)
        .where((d) => !availableDates.contains(d))
        .toList();

    final dailyNormExceededDatesSet = _reportsSortedByDateReverse
        .where((r) => r.nutrientNormsAndTotals.isAtLeastOneNormExceeded())
        .map((r) => r.date)
        .toSet();

    return Container(
      key: const Key("daily-intakes-calendar"),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfDateRangePicker(
          view: DateRangePickerView.month,
          showNavigationArrow: true,
          minDate: minDate,
          maxDate: maxDate,
          controller: _datePickerController,
          selectionColor: Colors.transparent,
          headerStyle:
              const DateRangePickerHeaderStyle(textAlign: TextAlign.center),
          cellBuilder: (context, cellDetails) {
            final date = Date(cellDetails.date);

            Color fontColor = Colors.white;
            BoxDecoration boxDecoration;

            if (!availableDates.contains(date)) {
              fontColor = Colors.grey;
            } else if (dailyNormExceededDatesSet.contains(date)) {
              boxDecoration = const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              );
            } else {
              boxDecoration = const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              );
            }

            return Container(
              width: cellDetails.bounds.width,
              height: cellDetails.bounds.height,
              alignment: Alignment.center,
              decoration: boxDecoration,
              child: Text(
                date.day.toString(),
                style: TextStyle(color: fontColor),
              ),
            );
          },
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 1,
            showTrailingAndLeadingDates: true,
            blackoutDates: blackoutDates,
            weekendDays: const [],
          ),
          onSelectionChanged: (arg) {
            if (arg.value is DateTime) {
              final position = getReportPosition(arg.value as DateTime);

              _closeCalendar();
              _itemScrollController.jumpTo(index: position);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => setState(() => _isCalendarVisible ^= true),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  appLocalizations.myMeals,
                  style: const TextStyle(color: Colors.white),
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  firstChild: const Icon(Icons.arrow_drop_up),
                  secondChild: const Icon(Icons.arrow_drop_down),
                  crossFadeState: _isCalendarVisible
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ScrollablePositionedList.builder(
            itemScrollController: _itemScrollController,
            itemCount: _reportsSortedByDateReverse.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return BasicSection.single(_buildCalendar());
              }
              final dailyIntakesReport = _reportsSortedByDateReverse[index - 1];

              return DailyIntakesReportTile(dailyIntakesReport);
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: _isCalendarVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Material(elevation: 1, child: _buildCalendar()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
