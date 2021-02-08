import 'package:nephrogo/models/date.dart';

class DateUtils {
  DateUtils._();

  static Iterable<Date> generateDates(
    DateTime startDate,
    DateTime endDate,
  ) sync* {
    for (var date = startDate;
        date.isBefore(endDate) || date == endDate;
        date = date.add(const Duration(days: 1))) {
      yield Date(date);
    }
  }
}
