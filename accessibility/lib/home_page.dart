import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          textScaleFactor: MediaQuery.textScaleFactorOf(context),
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to the home page!',
          textScaleFactor: MediaQuery.textScaleFactorOf(context),
        ),
      ),
    );
  }
}
