import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MvoyPasswordField extends StatefulWidget {
  final String placeHolder;
  final TextEditingController? receivedController;
  const MvoyPasswordField(
      {super.key, required this.placeHolder, this.receivedController});

  @override
  State<MvoyPasswordField> createState() => _MvoyPasswordFieldState();
}

class _MvoyPasswordFieldState extends State<MvoyPasswordField> {
  bool isShowingPassword = true;
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          height: 80,
          width: baseSize.width * .60,
          decoration: const BoxDecoration(),
          child: TextField(
            cursorColor: Colors.black,
            obscureText: isShowingPassword,
            controller: widget.receivedController,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: widget.placeHolder.toUpperCase(),
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                fillColor: const Color(0xffDDDDDD),
                filled: true),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 18),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isShowingPassword = !isShowingPassword;
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xffDDDDDD),
                  borderRadius: BorderRadius.circular(20)),
              child: SvgPicture.asset("assets/eye.svg"),
            ),
          ),
        )
      ],
    );
  }
}
