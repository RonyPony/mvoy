import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';

class LandingScreen2 extends StatelessWidget {
  static String routeName = "/landingScreen2";
  const LandingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/landing2.png"),
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
                  child: MvoyMainBtn(
                    text: "siguiente",
                    width: 300,
                    onTapp: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
