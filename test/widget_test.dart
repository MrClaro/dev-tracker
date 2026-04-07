import 'package:flutter_test/flutter_test.dart';
import 'package:devtracker/main.dart';

void main() {
  testWidgets('DevTracker smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DevTrackerApp());
    expect(find.text('Perfil'), findsOneWidget);
  });
}