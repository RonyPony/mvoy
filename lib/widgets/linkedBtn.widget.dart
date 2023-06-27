import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MvoyLinkedBtn extends StatelessWidget {
  final String text;
  final bool showArrow;
  final double fontSize;
  const MvoyLinkedBtn(
      {super.key,
      this.showArrow = true,
      required this.text,
      this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
                fontFamily: 'K2D',
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
            showArrow
                ? SizedBox(
                    height: 20,
                    width: 30,
                    child: SvgPicture.asset('assets/left_arrow.svg'))
                : SizedBox()
          ],
        ),
      ],
    );
  }
}
