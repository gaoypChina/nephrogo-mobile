import 'package:nephrogo/models/date.dart';
import 'package:tuple/tuple.dart';

class DateUtils {
  DateUtils._();

  static Iterable<Date> generateDates(
    DateTime startDate,
    DateTime endDate,
  ) sync* {
    for (var date = startDate;
        date.isBefore(endDate) || date == endDate;
        date = date.add(const Duration(days: 1))) {
      yield Date.from(date);
    }
  }

  static Iterable<Date> generateMonthDates(
    DateTime startDate,
    DateTime endDate,
  ) sync* {
    final finalEndDate = getLastDateOfCurrentMonth(endDate);
    for (var date = Date(startDate.year, startDate.month, 1);
        date.isBefore(finalEndDate);
        date = getFirstDayOfNextMonth(date)) {
      yield date;
    }
  }

  static Date getLastDateOfCurrentMonth(DateTime dateTime) {
    return Date(dateTime.year, dateTime.month + 1, 0);
  }

  static Date getFirstDayOfNextMonth(DateTime dateTime) {
    return Date(dateTime.year, dateTime.month + 1, 1);
  }

  static Date getLastDayOfPreviousMonth(DateTime dateTime) {
    return Date(dateTime.year, dateTime.month, 0);
  }

  static Tuple2<Date, Date> getStartAndEndOfMonth(DateTime dateTime) {
    final start = Date(dateTime.year, dateTime.month, 1);
    final end = DateUtils.getLastDateOfCurrentMonth(dateTime);

    return Tuple2(start, end);
  }
}
