import 'package:flutter_test/flutter_test.dart';
import 'package:quizp/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const QuizApp());
    expect(find.text('Begin quest'), findsOneWidget);
  });
}