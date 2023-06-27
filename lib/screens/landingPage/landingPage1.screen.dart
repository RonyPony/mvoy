import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvoy/screens/landingPage/landingPage2.screen.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';

class LandingScreen1 extends StatelessWidget {
  static String routeName = "/landingScreen1";
  const LandingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/landing1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(LandingScreen2.routeName);
                    },
                    child: MvoyMainBtn(
                      text: "comencemos",
                      color: Color(0xffFFDE30),
                      fontColor: Colors.black,
                      width: 300,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
