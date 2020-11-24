import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/50198891/how-to-convert-flutter-timeofday-to-datetime
extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
