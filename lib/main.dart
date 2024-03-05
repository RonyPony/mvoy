import 'package:flutter/material.dart';
import 'package:mvoy/providers/auth.provider.dart';
import 'package:mvoy/providers/driver.provider.dart';
import 'package:mvoy/providers/map.provider.dart';
import 'package:mvoy/providers/trip.provider.dart';
import 'package:mvoy/routes/routes.dart';
import 'package:mvoy/screens/landingPage/landingPage1.screen.dart';
import 'package:mvoy/services/auth.service.dart';
import 'package:mvoy/services/driver.service.dart';
import 'package:mvoy/services/trip.service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const InitialScreen());
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(AuthService()),
        ),
        ChangeNotifierProvider(
            create: (context) => DriverProvider(DriverService())),
        ChangeNotifierProvider(
          create: (context)=>TripProvider(TripService()),
        ),      
        ChangeNotifierProvider(
          create: (context)=>MapProvider(),
        )  
      ],
      child: MaterialApp(
        routes: getApplicationRoutes(),
        home: const LandingScreen1(),
      ),
    );
  }
}
