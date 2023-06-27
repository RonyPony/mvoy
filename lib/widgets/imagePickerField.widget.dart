import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class MvoyImageField extends StatefulWidget {
  final String placeHolder;
  const MvoyImageField({super.key, required this.placeHolder});

  @override
  State<MvoyImageField> createState() => _MvoyImageFieldState();
}

class _MvoyImageFieldState extends State<MvoyImageField> {
  TextEditingController dateController = TextEditingController();
  File? image;
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: baseSize.height * .1,
          width: baseSize.width * .60,
          decoration: const BoxDecoration(),
          child: TextField(
            enabled: false,
            controller: dateController,
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
            onTap: () async {
              _getFromGallery();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: Offset(5, 5), // changes position of shadow
                    )
                  ],
                  color: const Color(0xffDDDDDD),
                  borderRadius: BorderRadius.circular(20)),
              child: SvgPicture.asset("assets/camara.svg"),
            ),
          ),
        )
      ],
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
    }
  }
}
