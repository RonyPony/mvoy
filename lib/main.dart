import 'package:flutter/material.dart';
import 'package:mvoy/routes/routes.dart';
import 'package:mvoy/screens/landingPage/landingPage1.screen.dart';
import 'package:mvoy/screens/landingPage/landingPage2.screen.dart';
import 'package:mvoy/screens/landingPage/landingPage3.screen.dart';
import 'package:mvoy/screens/login.screen.dart';
import 'package:mvoy/screens/register/chooseRole.screen.dart';
import 'package:mvoy/screens/register/motoInfo.screen.dart';
import 'package:mvoy/screens/register/personalInformation.screen.dart';
import 'package:mvoy/screens/register/personalInformationSecond.screen.dart';

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
