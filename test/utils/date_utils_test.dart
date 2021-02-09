import 'package:nephrogo/models/date.dart';
import 'package:nephrogo/utils/date_utils.dart';
import 'package:test/test.dart';

void main() {
  group('getStartAndEndOfMonth', () {
    test('returns correct week start and end', () {
      final today = DateTime.parse('2020-12-12T14:34:16.798918');
      final startAndEnd = DateUtils.getStartAndEndOfMonth(today);
      final start = startAndEnd.item1;
      final end = startAndEnd.item2;

      expect(start, DateTime.parse('2020-12-01T00:00:00.000'));
      expect(end, DateTime.parse('2020-12-31T00:00:00.000'));
    });
  });

  group('getFirstDayOfNextMonth', () {
    test('returns correct date', () {
      final today = DateTime.parse('2020-12-12T14:34:16.798918');
      final date = DateUtils.getFirstDayOfNextMonth(today);

      expect(date, Date(2021, 1, 1));
    });
  });
  group('getLastDayOfPreviousMonth', () {
    test('returns correct date', () {
      final today = DateTime.parse('2020-12-12T14:34:16.798918');
      final date = DateUtils.getLastDayOfPreviousMonth(today);

      expect(date, Date(2020, 11, 30));
    });
  });
  group('getLastDayOfPreviousMonth', () {
    test('returns correct dates', () {
      final from = Date(2020, 1, 5);
      final to = Date(2021, 2, 28);
      final dates = DateUtils.generateMonthDates(from, to).toList();

      expect(dates.length, 14);
      expect(dates[0], Date(2020, 1, 1));
      expect(dates[13], Date(2021, 2, 1));
    });
  });
}
