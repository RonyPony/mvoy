import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/widgets/colors.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';

import '../login.screen.dart';

class LandingScreen3 extends StatelessWidget {
  static String routeName = "/landingScreen3";
  const LandingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              _buildLogo(),
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
          height: 130,
        ),
      ],
    );
  }

  _buildFirstLabel() {
    return const Padding(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "MAS QUE UN CONDUCTOR",
            style: TextStyle(fontSize: 29),
          )
        ],
      ),
    );
  }

  _buildNextBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          },
          child: MvoyMainBtn(
            text: "siguiente",
            fontColor: Colors.black,
            color: Colors.white,
            width: 300,
          ),
        ),
      ],
    );
  }

  _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SvgPicture.asset(
        "assets/landing3.svg",
        width: MediaQuery.of(context).size.height * .4,
      ),
    );
  }

  _buildSecondLabel() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "AQUI EL LIMITE LO PONES TU",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  _buildChip() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const SizedBox(
                height: 10,
                width: 20,
              )),
          const SizedBox(
            width: 10,
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const SizedBox(
                height: 10,
                width: 50,
              )),
        ],
      ),
    );
  }
}
