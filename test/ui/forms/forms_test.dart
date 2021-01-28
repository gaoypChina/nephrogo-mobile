import 'package:nephrogo/ui/forms/forms.dart';
import 'package:test/test.dart';

void main() {
  group('AppFloatInputField', () {
    test('regex validation', () {
      final regexPrecision0 = AppDoubleInputField.floatRegexPattern;

      expect(regexPrecision0.stringMatch('12.1'), '12.1');
      expect(regexPrecision0.stringMatch('1,1'), '1,1');
      expect(regexPrecision0.stringMatch('1.21'), '1.21');
      expect(regexPrecision0.stringMatch('1'), '1');
      expect(regexPrecision0.stringMatch('01.2'), null);
      expect(regexPrecision0.stringMatch('h1.1'), null);
    });
  });
}
