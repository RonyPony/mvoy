import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MvoyTextField extends StatelessWidget {
  final String placeHolder;
  const MvoyTextField({super.key, required this.placeHolder});

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Container(
      height: baseSize.height * .1,
      width: baseSize.width * .78,
      decoration: BoxDecoration(),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: placeHolder.toUpperCase(),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
            fillColor: Color(0xffDDDDDD),
            filled: true),
      ),
    );
  }
}
