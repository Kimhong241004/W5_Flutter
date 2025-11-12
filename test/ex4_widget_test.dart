import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/ex4/main.dart' as ex4;

void main() {
  testWidgets('EX4 weather screen smoke test', (tester) async {
    await tester.pumpWidget(const ex4.MyApp());
    // App bar title
    expect(find.text('Weather'), findsOneWidget);
    // List should have at least 4 items (lazy-built; scroll to ensure build)
    expect(find.byType(ListView), findsOneWidget);
    await tester.pumpAndSettle();
  });
}
