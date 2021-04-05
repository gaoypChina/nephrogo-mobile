import 'package:flutter/material.dart';
import 'package:nephrogo/l10n/localizations.dart';
import 'package:nephrogo/models/date.dart';

extension DateTimeExtension on DateTime {
  // https://stackoverflow.com/questions/50198891/how-to-convert-flutter-timeofday-to-datetime
  DateTime appliedLocalTime(TimeOfDay time) {
    final appliedDateTime = toLocal().copyWith(
      hour: time.hour,
      minute: time.minute,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    if (isUtc) {
      return appliedDateTime.toUtc();
    }

    return appliedDateTime;
  }

  DateTime appliedDate(Date date) {
    final appliedDateTime = toLocal().copyWith(
      year: date.year,
      month: date.month,
      day: date.day,
    );

    if (isUtc) {
      return appliedDateTime.toUtc();
    }
    return appliedDateTime;
  }

  TimeOfDay get timeOfDayLocal {
    return TimeOfDay.fromDateTime(toLocal());
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
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    if (isUtc) {
      return DateTime.utc(
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

extension DurationExtensions on Duration {
  String formatHoursAndMinutes(AppLocalizations appLocalizations) {
    if (inMinutes >= 60) {
      return '${inMinutes ~/ 60} ${appLocalizations.hoursShortSuffix} '
          '${inMinutes % 60} ${appLocalizations.minutesShortSuffix}';
    }
    return '$inMinutes ${appLocalizations.minutesShortSuffix}';
  }
}
