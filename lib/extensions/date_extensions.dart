import 'package:nephrogo_api_client/nephrogo_api_client.dart';

extension DateExtensions on Date {
  static Date today({bool utc = false}) {
    final now = DateTime.now();
    if (utc) {
      return now.toUtc().toDate();
    }
    return now.toUtc().toDate();
  }

  bool isBefore(Date other) {
    return compareTo(other).isNegative;
  }

  Date addDays(int days) {
    return toDateTime(utc: true).add(Duration(days: days)).toDate();
  }

  Date subtractDays(int days) {
    return toDateTime(utc: true).subtract(Duration(days: days)).toDate();
  }

  Date firstDayOfWeek() {
    final dt = toDateTime(utc: true);

    return dt.subtract(Duration(days: dt.weekday - DateTime.monday)).toDate();
  }

  Date lastDayOfWeek() {
    final dt = toDateTime(utc: true);

    return dt.add(Duration(days: DateTime.daysPerWeek - dt.weekday)).toDate();
  }
}
