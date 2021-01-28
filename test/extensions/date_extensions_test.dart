import 'package:nephrogo/extensions/date_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('startAndEndOfWeek', () {
    test('returns correct week start and end', () {
      final today = DateTime.parse('2020-12-12T14:34:16.798918');
      final startAndEnd = today.startAndEndOfWeek();
      final start = startAndEnd.item1;
      final end = startAndEnd.item2;

      expect(start, DateTime.parse('2020-12-07T00:00:00.000'));
      expect(end, DateTime.parse('2020-12-13 23:59:59.000'));
    });
  });
}
