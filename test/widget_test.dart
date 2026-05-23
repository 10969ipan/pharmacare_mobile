import 'package:flutter_test/flutter_test.dart';
import 'package:pharmacare_mobile/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PharmacareApp());

    // Verify that the title is present.
    expect(find.text('Pharmacare'), findsWidgets);
  });
}
