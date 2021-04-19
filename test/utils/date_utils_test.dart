import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:test/test.dart';

void main() {
  group('getFirstDayOfNextMonth', () {
    test('returns correct date', () {
      final today = DateTime.parse('2020-12-12T14:34:16.798918');
      final date = DateHelper.getFirstDayOfNextMonth(today);

      expect(date, Date(2021, 1, 1));
    });
  });
  group('generateMonthDates', () {
    test('returns correct dates', () {
      final from = Date(2020, 1, 5);
      final to = Date(2021, 2, 28);
      final dates = DateHelper.generateMonthDates(from, to).toList();

      expect(dates.length, 14);
      expect(dates[0], Date(2020, 1, 1));
      expect(dates[13], Date(2021, 2, 1));
    });
  });
  group('generateWeekDates', () {
    test('returns correct dates', () {
      final from = Date(2021, 1, 16);
      final to = Date(2021, 4, 19);
      final dates = DateHelper.generateWeekDates(from, to).toList();

      expect(dates.length, 15);
      expect(dates.first, Date(2021, 1, 11));
      expect(dates.last, Date(2021, 4, 19));
    });
    test('returns correct dates', () {
      final from = Date(2021, 1, 16);
      final to = Date(2021, 4, 18);
      final dates = DateHelper.generateWeekDates(from, to).toList();

      expect(dates.length, 14);
      expect(dates.first, Date(2021, 1, 11));
      expect(dates.last, Date(2021, 4, 12));
    });
  });
}
