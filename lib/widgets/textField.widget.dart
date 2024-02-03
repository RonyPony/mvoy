import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MvoyTextField extends StatelessWidget {
  final String placeHolder;
  final bool? hideTeext;
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
      this.keyboardType,
      this.hideTeext = false});

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        height: 80,
        width: baseSize.width * .78,
        decoration: BoxDecoration(),
        child: TextField(
          cursorColor: Colors.black,
          obscureText: hideTeext!,
          keyboardType: keyboardType,
          controller: receivedController,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!();
            }
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
