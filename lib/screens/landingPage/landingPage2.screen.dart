import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/screens/landingPage/landingPage3.screen.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';

class LandingScreen2 extends StatelessWidget {
  static String routeName = "/landingScreen2";
  const LandingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFDE30),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _buildLogo(),
              _buildFirstLabel(),
              _buildImage(context),
              _buildSecondLabel(),
              _buildChip(),
              _buildNextBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/base-logo.png",
          height: 140,
        ),
      ],
    );
  }

  _buildFirstLabel() {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "MAS QUE UN CONDUCTOR",
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }

  _buildNextBtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(LandingScreen3.routeName);
            },
            child: MvoyMainBtn(
              text: "siguiente",
              fontColor: Colors.black,
              color: Colors.white,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }

  _buildImage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: SvgPicture.asset(
        "assets/landing2.svg",
        height: MediaQuery.of(context).size.width * .6,
      ),
    );
  }

  _buildSecondLabel() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "AQUI EL LIMITE LO PONES TU",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  _buildChip() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const SizedBox(
                height: 10,
                width: 50,
              )),
          const SizedBox(
            width: 10,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const SizedBox(
                height: 10,
                width: 20,
              )),
        ],
      ),
    );
  }
}
