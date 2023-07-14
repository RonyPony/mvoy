import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MvoyBooleanSelectorField extends StatefulWidget {
  final String placeHolder;
  final String option1Text;
  final String option2Text;
  final TextEditingController? controller;
  const MvoyBooleanSelectorField(
      {super.key,
      required this.placeHolder,
      required this.option1Text,
      required this.option2Text,
      this.controller});

  @override
  State<MvoyBooleanSelectorField> createState() =>
      _MvoyBooleanSelectorFieldState();
}

class _MvoyBooleanSelectorFieldState extends State<MvoyBooleanSelectorField> {
  bool isOption1Selected = false;
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: baseSize.height * .1,
          width: baseSize.width * .43,
          decoration: const BoxDecoration(),
          child: TextField(
            enabled: false,
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
                isOption1Selected = true;
                widget.controller!.text = widget.option1Text;
              });
            },
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 1,
                          blurRadius: 0,
                          offset: Offset(1, 5), // changes position of shadow
                        )
                      ],
                      color: isOption1Selected
                          ? Color(0xffFFDE30)
                          : Color(0xffDDDDDD),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    child: Text(
                      widget.option1Text.toUpperCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOption1Selected = false;
                      widget.controller!.text = widget.option2Text;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 1,
                            blurRadius: 0,
                            offset: Offset(1, 5), // changes position of shadow
                          )
                        ],
                        color: !isOption1Selected
                            ? Color(0xffFFDE30)
                            : Color(0xffDDDDDD),
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      child: Text(
                        widget.option2Text.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 11, horizontal: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
