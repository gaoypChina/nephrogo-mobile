import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo/models/date.dart';

class DateHelper {
  DateHelper._();

  static Iterable<Date> generateDates(
    Date startDate,
    Date endDate,
  ) sync* {
    for (var date = startDate;
        date.isBefore(endDate) || date == endDate;
        date = date.add(const Duration(days: 1)).toDate()) {
      yield Date.from(date);
    }
  }

  static Iterable<Date> generateWeekDates(
    Date startDate,
    Date endDate,
  ) sync* {
    for (var date = startDate.firstDayOfWeek();
        date.isBefore(endDate) || date == endDate;
        date = date.add(const Duration(days: 7)).toDate()) {
      yield date;
    }
  }

  static Iterable<Date> generateMonthDates(
    Date startDate,
    Date endDate,
  ) sync* {
    final finalEndDate = getLastDayOfCurrentMonth(endDate);
    for (var date = getFirstDayOfCurrentMonth(startDate);
        date.isBefore(finalEndDate);
        date = getFirstDayOfNextMonth(date)) {
      yield date;
    }
  }

  static Date getFirstDayOfCurrentMonth(DateTime dateTime) {
    return Date(dateTime.year, dateTime.month, 1);
  }

  static Date getLastDayOfCurrentMonth(DateTime dateTime) {
    return Date(dateTime.year, dateTime.month + 1, 0);
  }

  static Date getFirstDayOfNextMonth(DateTime dateTime) {
    return Date(dateTime.year, dateTime.month + 1, 1);
  }
}
