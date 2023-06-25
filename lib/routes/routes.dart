import 'package:flutter/cupertino.dart';
import 'package:mvoy/screens/landingPage/landingPage1.screen.dart';
import 'package:mvoy/screens/login.screen.dart';

import '../screens/landingPage/landingPage2.screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    LandingScreen1.routeName: (BuildContext context) => const LandingScreen1(),
    LandingScreen2.routeName: (BuildContext context) => const LandingScreen2(),
    LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
  };
}
