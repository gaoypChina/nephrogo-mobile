import 'package:nephrogo/extensions/extensions.dart';
import 'package:nephrogo_api_client/nephrogo_api_client.dart';

class DateHelper {
  DateHelper._();

  static Iterable<Date> generateDates(
    Date startDate,
    Date endDate,
  ) sync* {
    for (var date = startDate;
        date.isBefore(endDate) || date == endDate;
        date = date.addDays(1)) {
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
    return DateTime.utc(dateTime.year, dateTime.month + 1, 0).toDate();
  }

  static Date getFirstDayOfNextMonth(Date dateTime) {
    return DateTime.utc(dateTime.year, dateTime.month + 1).toDate();
  }
}
