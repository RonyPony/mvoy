import 'package:flutter/cupertino.dart';
import 'package:mvoy/screens/driverDetailScreen/driverDetail.screen.dart';
import 'package:mvoy/screens/homeScreen/homePage.screen.dart';
import 'package:mvoy/screens/landingPage/landingPage1.screen.dart';
import 'package:mvoy/screens/landingPage/landingPage3.screen.dart';
import 'package:mvoy/screens/login.screen.dart';
import 'package:mvoy/screens/mytrips/mytrips.screen.dart';
import 'package:mvoy/screens/password/forgottenPassword.screen.dart';
import 'package:mvoy/screens/profile/profile.screen.dart';
import 'package:mvoy/screens/register/chooseRole.screen.dart';
import 'package:mvoy/screens/register/motoInfo.screen.dart';
import 'package:mvoy/screens/register/motoInfoSecond.screen.dart';
import 'package:mvoy/screens/register/personalInformation.screen.dart';
import 'package:mvoy/screens/register/personalInformationSecond.screen.dart';
import 'package:mvoy/screens/tripDetailsScreen/tripDetails.screen.dart';

import '../screens/landingPage/landingPage2.screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    LandingScreen1.routeName: (BuildContext context) => const LandingScreen1(),
    LandingScreen2.routeName: (BuildContext context) => const LandingScreen2(),
    LandingScreen3.routeName: (BuildContext context) => const LandingScreen3(),
    ChooseRoleScreen.routeName: (BuildContext context) =>
        const ChooseRoleScreen(),
    MotoInfoScreen.routeName: (BuildContext context) => const MotoInfoScreen(),
    MotoInfoScreenSecond.routeName: (BuildContext context) =>
        const MotoInfoScreenSecond(),
    PersonalInfoScreen.routeName: (BuildContext context) =>
        const PersonalInfoScreen(),
    PersonalInfoSecondScreen.routeName: (BuildContext context) =>
        const PersonalInfoSecondScreen(),
    LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
    ForgottenPasswordScreen.routeName: (BuildContext context) =>
        const ForgottenPasswordScreen(),
    HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
    MyTripsScreen.routeName: (BuildContext context) => const MyTripsScreen(),
    ProfileScreen.routeName: (BuildContext context) => const ProfileScreen(),
    TripDetailsScreen.routeName: (BuildContext context) =>
        const TripDetailsScreen(),
    DriverDetailScreen.routeName: (BuildContext) => const DriverDetailScreen(),
  };
}
