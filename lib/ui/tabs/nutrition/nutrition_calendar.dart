import 'package:flutter/material.dart';
import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:nephrogo_api_client/model/daily_intakes_light_report.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NutritionCalendar extends StatefulWidget {
  final List<DailyIntakesLightReport> dailyIntakesLightReports;
  final void Function(DateTime dateTime) onSelectionChanged;

  const NutritionCalendar(
    this.dailyIntakesLightReports, {
    Key key,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  _NutritionCalendarState createState() => _NutritionCalendarState();
}

class _NutritionCalendarState extends State<NutritionCalendar> {
  DateRangePickerController _datePickerController;

  DateTime _minDate;
  DateTime _maxDate;

  List<DailyIntakesLightReport> _reportsSortedByDateReverse;

  List<Date> _blackoutDates;
  Set<DateTime> _dailyNormExceededDatesSet;
  Set<DateTime> _availableDatesSet;

  @override
  void initState() {
    _reportsSortedByDateReverse = widget.dailyIntakesLightReports
        .sortedBy((e) => e.date, reverse: true)
        .toList();

    _minDate = _reportsSortedByDateReverse.last.date;
    _maxDate = _reportsSortedByDateReverse.first.date;

    _datePickerController = DateRangePickerController();

    final allDates = _reportsSortedByDateReverse.map((r) => Date(r.date));

    _availableDatesSet = allDates.toSet();

    _blackoutDates = DateUtils.generateDates(_minDate, _maxDate)
        .where((d) => !_availableDatesSet.contains(d))
        .toList();

    _dailyNormExceededDatesSet = _reportsSortedByDateReverse
        .where((r) => r.nutrientNormsAndTotals.isAtLeastOneNormExceeded())
        .map((r) => r.date)
        .toSet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      view: DateRangePickerView.month,
      showNavigationArrow: true,
      minDate: _minDate,
      maxDate: _maxDate,
      controller: _datePickerController,
      selectionColor: Colors.transparent,
      headerStyle: const DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
      ),
      cellBuilder: (context, cellDetails) {
        final date = Date(cellDetails.date);

        Color fontColor = Colors.white;
        BoxDecoration boxDecoration;

        if (!_availableDatesSet.contains(date)) {
          fontColor = Colors.grey;
        } else if (_dailyNormExceededDatesSet.contains(date)) {
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
        blackoutDates: _blackoutDates,
        weekendDays: const [],
      ),
      onSelectionChanged:
          widget.onSelectionChanged != null ? _onSelectionChanged : null,
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs arg) {
    if (arg.value is DateTime) {
      widget.onSelectionChanged(arg.value as DateTime);
    }
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
