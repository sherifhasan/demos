import 'package:color_blindness/color_blindness_contrast_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accessibility/main.dart';

void main() {
  testWidgets('the app should meet contrast requirements', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const MyApp());
    // Checks whether semantic nodes meet the minimum text contrast levels.
    // The recommended text contrast is 3:1 for larger text
    // (18 point and above regular).
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });

  testWidgets('the android app should meet  minimum size requirements ',
      (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const MyApp());
    // Checks that tappable nodes have a minimum size of 48 by 48 pixels
    // for Android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    handle.dispose();
  });
  testWidgets('the iOS app should meet  minimum size requirements ',
      (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const MyApp());
    // Checks that tappable nodes have a minimum size of 44 by 44 pixels
    // for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    handle.dispose();
  });
  testWidgets('the app should meet tap requirements ', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(const MyApp());
    // Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    handle.dispose();
  });
  testWidgets('testing color scheme meets requirements', (tester) async {
    const colorScheme = ColorScheme.light(
      primary: Color(0xff9f0042),
      secondary: Color(0xff1e6100),
    );
    expect(
        () => colorBlindnessAssertContrast(colorScheme, 4.0), returnsNormally);
  });
}
