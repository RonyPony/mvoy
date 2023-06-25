import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MvoyMainBtn extends StatelessWidget {
  final String text;
  final double width;
  final Function onTapp;
  const MvoyMainBtn(
      {super.key, required this.text, this.width = 300, required this.onTapp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: GestureDetector(
        onTap: onTapp(),
        child: Container(
          width: width,
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Text(
                text.toUpperCase(),
                style: TextStyle(color: Color(0xffFFDE30), fontSize: 28),
              ),
              Container(
                  child: SvgPicture.asset("assets/left_arrow.svg",
                      height: 28, color: Color(0xffFFDE30))),
            ],
          ),
        ),
      ),
    );
  }
}
