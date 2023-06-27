import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MvoyMainBtn extends StatelessWidget {
  final String text;
  final double width;
  final Color color;
  final Color fontColor;
  const MvoyMainBtn(
      {super.key,
      required this.text,
      this.width = 300,
      this.color = Colors.black,
      this.fontColor = const Color(0xffFFDE30)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        width: width,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text.toUpperCase(),
              style: TextStyle(
                  color: fontColor, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Container(
                child: SvgPicture.asset("assets/left_arrow.svg",
                    height: 28, color: fontColor)),
          ],
        ),
      ),
    );
  }
}
