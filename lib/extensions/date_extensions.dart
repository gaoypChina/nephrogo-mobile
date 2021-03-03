import 'package:flutter/material.dart';
import 'package:nephrogo/models/date.dart';

extension DateTimeExtension on DateTime {
  // https://stackoverflow.com/questions/50198891/how-to-convert-flutter-timeofday-to-datetime
  DateTime applied(TimeOfDay time) {
    final date = Date.from(this);

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  TimeOfDay timeOfDayLocal() {
    return TimeOfDay.fromDateTime(toLocal());
  }

  DateTime appliedDate(Date date) {
    if (isUtc) {
      return DateTime.utc(date.year, date.month, date.day, hour, minute);
    }

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59);
  }

  Date toDate() {
    return Date.from(this);
  }

  Date firstDayOfWeek() {
    return subtract(Duration(days: weekday - DateTime.monday)).toDate();
  }

  Date lastDayOfWeek() {
    return add(Duration(days: DateTime.daysPerWeek - weekday)).toDate();
  }

  // https://stackoverflow.com/questions/52627973/dart-how-to-set-the-hour-and-minute-of-datetime-object
  DateTime copyWith({
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
    int millisecond,
    int microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
