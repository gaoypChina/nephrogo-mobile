import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:table_calendar/table_calendar.dart';

class NutritionCalendar extends StatefulWidget {
  final List<DailyIntakesLightReport> dailyIntakesLightReports;
  final void Function(Date date) onDaySelected;

  NutritionCalendar(
    this.dailyIntakesLightReports, {
    this.onDaySelected,
  }) : super(key: UniqueKey());

  @override
  _NutritionCalendarState createState() => _NutritionCalendarState();
}

class _NutritionCalendarState extends State<NutritionCalendar> {
  Date _today;
  DateTime _minDate;
  DateTime _maxDate;

  CalendarController _calendarController;

  List<DailyIntakesLightReport> _reportsSortedByDateReverse;

  Set<DateTime> _dailyNormExceededDatesSet;
  Set<DateTime> _availableDatesSet;

  @override
  void initState() {
    _today = Date.today();

    _calendarController = CalendarController();

    _reportsSortedByDateReverse = widget.dailyIntakesLightReports
        .sortedBy((e) => e.date, reverse: true)
        .toList();

    _minDate = _reportsSortedByDateReverse.lastOrNull()?.date;
    _maxDate = _reportsSortedByDateReverse.firstOrNull()?.date;

    _availableDatesSet =
        _reportsSortedByDateReverse.map((r) => Date.from(r.date)).toSet();

    _dailyNormExceededDatesSet = _reportsSortedByDateReverse
        .where((r) => r.nutrientNormsAndTotals.isAtLeastOneNormExceeded())
        .map((r) => r.date)
        .toSet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      startDay: _minDate,
      endDay: _maxDate,
      initialSelectedDay: _minDate,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.none,
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
      ),
      onDaySelected: (widget.onDaySelected != null) ? _onDaySelected : null,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.blue),
      ),
      headerVisible: false,
      builders: CalendarBuilders(
        dayBuilder: (context, dateTime, _) {
          final date = Date.from(dateTime);
          return _buildCalendarCell(date);
        },
      ),
    );
  }

  Widget _buildCalendarCell(Date date) {
    Color fontColor = Colors.white;
    FontWeight fontWeight = FontWeight.normal;
    BoxDecoration boxDecoration;

    if (!_availableDatesSet.contains(date)) {
      if (_today.isBefore(date)) {
        fontColor = Colors.grey;
      } else {
        fontColor = Colors.black;
      }
    } else if (_dailyNormExceededDatesSet.contains(date)) {
      fontWeight = FontWeight.bold;
      boxDecoration = const BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.circle,
      );
    } else {
      fontWeight = FontWeight.bold;
      boxDecoration = const BoxDecoration(
        color: Colors.teal,
        shape: BoxShape.circle,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        alignment: Alignment.center,
        decoration: boxDecoration,
        child: Text(
          date.day.toString(),
          style: TextStyle(color: fontColor, fontWeight: fontWeight),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    widget.onDaySelected(Date.from(day));
  }

  int getReportPosition(DateTime dateTime) {
    return _reportsSortedByDateReverse
            .mapIndexed((i, r) => r.date == Date.from(dateTime) ? i : null)
            .firstWhere((i) => i != null) +
        1;
  }

  @override
  void dispose() {
    _calendarController.dispose();

    super.dispose();
  }
}
