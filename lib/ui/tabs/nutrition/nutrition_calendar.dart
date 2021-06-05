import 'package:flutter/material.dart';
import 'package:nephrogo/constants.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:table_calendar/table_calendar.dart';

class NutritionCalendar extends StatefulWidget {
  final List<DailyIntakesLightReport> dailyIntakesLightReports;
  final void Function(Date date) onDaySelected;
  final Nutrient? nutrient;

  NutritionCalendar(
    this.dailyIntakesLightReports, {
    required this.onDaySelected,
    this.nutrient,
  }) : super(key: UniqueKey());

  @override
  _NutritionCalendarState createState() => _NutritionCalendarState();
}

class _NutritionCalendarState extends State<NutritionCalendar> {
  late Date _today;
  late Date _focusDate;

  late List<DailyIntakesLightReport> _reportsSortedByDateReverse;

  late Set<Date> _dailyNormExceededDatesSet;
  late Set<Date> _dailyNormUnavailableDatesSet;
  late Set<Date> _availableDatesSet;

  @override
  void initState() {
    _today = DateTime.now().toDate();

    _reportsSortedByDateReverse = widget.dailyIntakesLightReports
        .orderBy((e) => e.date, reverse: true)
        .toList();

    final _reportsSortedDates =
        _reportsSortedByDateReverse.map((e) => e.date).toList();

    _focusDate = _reportsSortedDates.firstOrNull() ?? _today;

    _availableDatesSet = _reportsSortedDates.toSet();

    _dailyNormExceededDatesSet =
        generateDailyNormExceededDates(_reportsSortedByDateReverse).toSet();

    _dailyNormUnavailableDatesSet =
        generateDailyNormUnavailableDates(_reportsSortedByDateReverse).toSet();

    super.initState();
  }

  Iterable<Date> generateDailyNormExceededDates(
    List<DailyIntakesLightReport> reports,
  ) {
    if (widget.nutrient == null) {
      return _reportsSortedByDateReverse
          .where((r) => r.nutrientNormsAndTotals.isAtLeastOneNormExceeded())
          .map((r) => r.date);
    }

    return _reportsSortedByDateReverse.where(
      (r) {
        final consumption = r.nutrientNormsAndTotals
            .getDailyNutrientConsumption(widget.nutrient!);

        return consumption.normExceeded == true;
      },
    ).map((r) => r.date);
  }

  Iterable<Date> generateDailyNormUnavailableDates(
    List<DailyIntakesLightReport> reports,
  ) {
    if (widget.nutrient == null) {
      return [];
    }

    return _reportsSortedByDateReverse.where(
      (r) {
        final consumption = r.nutrientNormsAndTotals
            .getDailyNutrientConsumption(widget.nutrient!);

        return !consumption.isNormExists;
      },
    ).map((r) => r.date);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: Constants.earliestDate.toDateTime(),
      lastDay: _today.toDateTime(),
      focusedDay: _focusDate.toDateTime(),
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.none,
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
      ),
      onDaySelected: _onDaySelected,
      headerVisible: false,
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, dt, _) {
          return _buildCalendarCell(dt.toDate());
        },
        defaultBuilder: (context, dt, _) {
          return _buildCalendarCell(dt.toDate());
        },
      ),
    );
  }

  Widget _buildCalendarCell(Date date) {
    Color? fontColor;
    FontWeight fontWeight = FontWeight.normal;
    BoxDecoration boxDecoration = const BoxDecoration();
    final textDecoration = date == _today ? TextDecoration.underline : null;

    if (_dailyNormUnavailableDatesSet.contains(date)) {
      fontColor = Colors.white;
      fontWeight = FontWeight.bold;
      boxDecoration = const BoxDecoration(
        color: Colors.brown,
        shape: BoxShape.circle,
      );
    } else if (!_availableDatesSet.contains(date)) {
      if (_today.isBefore(date)) {
        fontColor = Colors.grey;
      } else {
        fontColor = null;
      }
    } else if (_dailyNormExceededDatesSet.contains(date)) {
      fontColor = Colors.white;
      fontWeight = FontWeight.bold;
      boxDecoration = const BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.circle,
      );
    } else {
      fontColor = Colors.white;
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
        constraints: const BoxConstraints(maxHeight: 128, maxWidth: 128),
        child: Text(
          date.day.toString(),
          style: TextStyle(
            color: fontColor,
            fontWeight: fontWeight,
            decoration: textDecoration,
          ),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    widget.onDaySelected(selectedDay.toDate());
  }

  int getReportPosition(DateTime dateTime) {
    final position = _reportsSortedByDateReverse
        .indexWhere((r) => r.date == dateTime.toDate());

    if (position == -1) {
      return 1;
    }
    return position;
  }
}

class NutrientCalendarExplanation extends StatelessWidget {
  const NutrientCalendarExplanation()
      : super(key: const Key('NutrientCalendarExplanation'));

  @override
  Widget build(BuildContext context) {
    final appLocalizations = context.appLocalizations;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: _buildDailyNormExplanation(
            appLocalizations.dailyNormExplanationExceeded,
            Colors.redAccent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: _buildDailyNormExplanation(
            appLocalizations.dailyNormExplanationNotExceeded,
            Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyNormExplanation(String text, Color color) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(text),
          ),
        )
      ],
    );
  }
}
