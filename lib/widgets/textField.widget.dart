import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MvoyTextField extends StatelessWidget {
  final String placeHolder;
  final TextEditingController? receivedController;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final void Function()? onChanged;
  const MvoyTextField(
      {super.key,
      required this.placeHolder,
      this.onTap,
      this.onChanged,
      this.receivedController,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        height: baseSize.height * .1,
        width: baseSize.width * .78,
        decoration: BoxDecoration(),
        child: TextField(
          keyboardType: keyboardType,
          controller: receivedController,
          onChanged: (value) {
            onChanged!();
          },
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: placeHolder.toUpperCase(),
              labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
              fillColor: Color(0xffDDDDDD),
              filled: true),
        ),
      ),
    );
  }
}
