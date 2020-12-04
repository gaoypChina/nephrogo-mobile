import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nephrolog/main.dart';

void main() {
  testWidgets('App shows tabs', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Mityba'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
  });
}
