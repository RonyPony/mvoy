import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MvoyPasswordField extends StatefulWidget {
  final String placeHolder;
  const MvoyPasswordField({super.key, required this.placeHolder});

  @override
  State<MvoyPasswordField> createState() => _MvoyPasswordFieldState();
}

class _MvoyPasswordFieldState extends State<MvoyPasswordField> {
  bool isShowingPassword = false;
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          height: baseSize.height * .1,
          width: baseSize.width * .60,
          decoration: const BoxDecoration(),
          child: TextField(
            obscureText: isShowingPassword,
            controller: passwordController,
            decoration: InputDecoration(
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
          padding: const EdgeInsets.only(left: 10, bottom: 11),
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
