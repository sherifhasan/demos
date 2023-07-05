import 'package:flutter/material.dart';
import 'package:color_blindness/color_blindness.dart';
import 'package:color_blindness/color_blindness_color_scheme.dart';
import 'login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        colorScheme: colorBlindnessColorScheme(
            const ColorScheme.light(
              primary: Color(0xff9f0042),
              secondary: Color(0xff1e6100),
            ),
            ColorBlindnessType.tritanopia),
      ),
      home: const LoginPage(),
    );
  }
}
