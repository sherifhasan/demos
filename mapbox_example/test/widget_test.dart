import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mapbox_example/pages/home_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testGoldens('testing a responsive layout', (tester) async {
    await tester.pumpWidgetBuilder(const ProviderScope(child: HomePage()));
    await multiScreenGolden(tester, 'home_page');
  });
}
