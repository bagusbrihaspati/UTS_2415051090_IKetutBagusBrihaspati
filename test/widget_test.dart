import 'package:flutter_test/flutter_test.dart';
import 'package:uts_2415051090_iketutbagusbrihaspati/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const EventHubApp());
  });
}