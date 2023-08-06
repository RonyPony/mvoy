import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvoy/screens/landingPage/landingPage2.screen.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';

class LandingScreen1 extends StatefulWidget {
  static String routeName = "/landingScreen1";
  const LandingScreen1({super.key});

  @override
  State<LandingScreen1> createState() => _LandingScreen1State();
}

class _LandingScreen1State extends State<LandingScreen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/landing1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(top: baseSize.height * .75),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(LandingScreen2.routeName);
                        },
                        child: MvoyMainBtn(
                          text: "comencemos",
                          color: Color(0xffFFDE30),
                          fontColor: Colors.black,
                          width: 300,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
