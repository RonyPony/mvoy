import 'package:flutter/material.dart';
import 'package:mvoy/routes/routes.dart';
import 'package:mvoy/screens/landingPage/landingPage1.screen.dart';

void main() {
  runApp(const InitialScreen());
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: getApplicationRoutes(),
      home: const LandingScreen1(),
    );
  }
}
