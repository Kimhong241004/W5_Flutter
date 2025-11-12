// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

// Import the EX2 demo app to run a simple smoke test against it.
import 'package:flutter_application_1/ex2/main.dart';

void main() {
  testWidgets('EX2 app smoke test builds and shows app bar title', (WidgetTester tester) async {
    // Build the EX2 demo app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app bar title is present.
    expect(find.text('Custom buttons'), findsOneWidget);
  });
}
