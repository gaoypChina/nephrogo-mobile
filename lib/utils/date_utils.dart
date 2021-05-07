import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class DateHelper {
  DateHelper._();

  static Iterable<Date> generateDates(
    Date startDate,
    Date endDate,
  ) sync* {
    for (var date = startDate;
        date.toDateTime().isBefore(endDate.toDateTime()) || date == endDate;
        date = date.toDateTime().add(const Duration(days: 1)).toDate()) {
      yield date;
    }
  }

  static Iterable<Date> generateWeekDates(
    Date startDate,
    Date endDate,
  ) sync* {
    for (var date = startDate.firstDayOfWeek();
        date.isBefore(endDate) || date == endDate;
        date = date.addDays(7)) {
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

  static Date getFirstDayOfCurrentMonth(Date dateTime) {
    return Date(dateTime.year, dateTime.month, 1);
  }

  static Date getLastDayOfCurrentMonth(Date dateTime) {
    return Date(dateTime.year, dateTime.month + 1, 0);
  }

  static Date getFirstDayOfNextMonth(Date dateTime) {
    return Date(dateTime.year, dateTime.month + 1, 1);
  }
}
