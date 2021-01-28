import 'package:intl/intl.dart';

// Dart doesn't have separate Date class so parsing yyyy-MM-dd format leads to
// local Date Time which is incorrect :(
// Related https://github.com/protocolbuffers/protobuf/issues/7411
class Date extends DateTime {
  static final dateFormat = DateFormat('yyyy-MM-dd');

  Date(DateTime dateTime)
      : super(
          dateTime.toLocal().year,
          dateTime.toLocal().month,
          dateTime.toLocal().day,
        );

  @override
  String toString() {
    return dateFormat.format(toLocal());
  }

  @override
  String toIso8601String() {
    return toString();
  }
}
