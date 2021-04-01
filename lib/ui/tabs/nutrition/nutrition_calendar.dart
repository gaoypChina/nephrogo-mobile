import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/contract.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';
import 'package:table_calendar/table_calendar.dart';

class NutritionCalendar extends StatefulWidget {
  final List<DailyIntakesLightReport> dailyIntakesLightReports;
  final void Function(Date date) onDaySelected;
  final Nutrient nutrient;

  NutritionCalendar(
    this.dailyIntakesLightReports, {
    this.onDaySelected,
    this.nutrient,
  })  : assert(dailyIntakesLightReports != null),
        super(key: UniqueKey());

  @override
  _NutritionCalendarState createState() => _NutritionCalendarState();
}

class _NutritionCalendarState extends State<NutritionCalendar> {
  Date _today;
  DateTime _minDate;
  DateTime _maxDate;

  CalendarController _calendarController;

  List<DailyIntakesLightReport> _reportsorderByDateReverse;

  Set<DateTime> _dailyNormExceededDatesSet;
  Set<DateTime> _dailyNormUnavailableDatesSet;
  Set<DateTime> _availableDatesSet;

  @override
  void initState() {
    _today = Date.today();

    _calendarController = CalendarController();

    _reportsorderByDateReverse = widget.dailyIntakesLightReports
        .orderBy((e) => e.date, reverse: true)
        .toList();

    _minDate = _reportsorderByDateReverse.lastOrNull()?.date;
    _maxDate = _reportsorderByDateReverse.firstOrNull()?.date;

    _availableDatesSet =
        _reportsorderByDateReverse.map((r) => Date.from(r.date)).toSet();

    _dailyNormExceededDatesSet =
        generateDailyNormExceededDates(_reportsorderByDateReverse).toSet();

    _dailyNormUnavailableDatesSet =
        generateDailyNormUnavailableDates(_reportsorderByDateReverse).toSet();

    super.initState();
  }

  Iterable<DateTime> generateDailyNormExceededDates(
    List<DailyIntakesLightReport> reports,
  ) {
    if (widget.nutrient == null) {
      return _reportsorderByDateReverse
          .where((r) => r.nutrientNormsAndTotals.isAtLeastOneNormExceeded())
          .map((r) => r.date);
    }

    return _reportsorderByDateReverse.where(
      (r) {
        final consumption = r.nutrientNormsAndTotals
            .getDailyNutrientConsumption(widget.nutrient);

        return consumption.normExceeded == true;
      },
    ).map((r) => r.date);
  }

  Iterable<DateTime> generateDailyNormUnavailableDates(
    List<DailyIntakesLightReport> reports,
  ) {
    if (widget.nutrient == null) {
      return [];
    }

    return _reportsorderByDateReverse.where(
      (r) {
        final consumption = r.nutrientNormsAndTotals
            .getDailyNutrientConsumption(widget.nutrient);

        return !consumption.isNormExists;
      },
    ).map((r) => r.date);
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
    Color fontColor;
    FontWeight fontWeight = FontWeight.normal;
    BoxDecoration boxDecoration;

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
    return _reportsorderByDateReverse
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

class NutrientCalendarExplanation extends StatelessWidget {
  const NutrientCalendarExplanation()
      : super(key: const Key('NutrientCalendarExplanation'));

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

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
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(text),
        )
      ],
    );
  }
}
