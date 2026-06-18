import 'package:flutter_test/flutter_test.dart';
import 'package:interview_task_1/app.dart';

void main() {
  testWidgets('App smoke test - shows flight search screen title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const App());

    expect(find.text('Flight Search'), findsOneWidget);
  });
}
