import 'package:accessibility/home_page.dart';
import 'package:accessibility/login_page.dart';
import 'package:color_blindness/color_blindness_contrast_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accessibility/main.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('testing a responsive layout', () {
    testGoldens('testing a responsive layout for Login page', (tester) async {
      await tester.pumpWidgetBuilder(const LoginPage());
      await multiScreenGolden(
        tester,
        'login_page',
        devices: [
          Device.phone,
          Device.iphone11,
          Device.tabletPortrait,
          Device.tabletLandscape,
          const Device(size: Size(1024, 768), name: 'Web')
        ],
      );
    });
    testGoldens('testing a responsive layout for Home page', (tester) async {
      await tester.pumpWidgetBuilder(const HomePage());
      await multiScreenGolden(
        tester,
        'home_page',
        devices: [
          Device.phone,
          Device.iphone11,
          Device.tabletPortrait,
          Device.tabletLandscape,
          const Device(size: Size(1024, 768), name: 'Web')
        ],
      );
    });
  });
}

//
// void main() {
//   testWidgets('the app should meet contrast requirements', (tester) async {
//     final SemanticsHandle handle = tester.ensureSemantics();
//     await tester.pumpWidget(const MyApp());
//     // Checks whether semantic nodes meet the minimum text contrast levels.
//     // The recommended text contrast is 3:1 for larger text
//     // (18 point and above regular).
//     await expectLater(tester, meetsGuideline(textContrastGuideline));
//     handle.dispose();
//   });
//
//   testWidgets('the android app should meet  minimum size requirements ',
//       (tester) async {
//     final SemanticsHandle handle = tester.ensureSemantics();
//     await tester.pumpWidget(const MyApp());
//     // Checks that tappable nodes have a minimum size of 48 by 48 pixels
//     // for Android.
//     await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
//     handle.dispose();
//   });
//   testWidgets('the iOS app should meet  minimum size requirements ',
//       (tester) async {
//     final SemanticsHandle handle = tester.ensureSemantics();
//     await tester.pumpWidget(const MyApp());
//     // Checks that tappable nodes have a minimum size of 44 by 44 pixels
//     // for iOS.
//     await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
//     handle.dispose();
//   });
//   testWidgets('the app should meet tap requirements ', (tester) async {
//     final SemanticsHandle handle = tester.ensureSemantics();
//     await tester.pumpWidget(const MyApp());
//     // Checks that touch targets with a tap or long press action are labeled.
//     await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
//     handle.dispose();
//   });
//   testWidgets('testing color scheme meets requirements', (tester) async {
//     const colorScheme = ColorScheme.light(
//       primary: Color(0xff9f0042),
//       secondary: Color(0xff1e6100),
//     );
//     expect(
//         () => colorBlindnessAssertContrast(colorScheme, 4.0), returnsNormally);
//   });
// }
