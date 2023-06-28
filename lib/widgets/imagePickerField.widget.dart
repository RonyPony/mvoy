import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class MvoyImageField extends StatefulWidget {
  final String placeHolder;
  final bool hasDescription;

  final String descriptionText;
  final String descriptionTitle;
  const MvoyImageField(
      {super.key,
      required this.placeHolder,
      this.hasDescription = false,
      this.descriptionText = "Descripcion",
      this.descriptionTitle = "titulo"});

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
              if (widget.hasDescription) {
                await showDescription(widget.descriptionText);
              }
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

  Future<bool> showDescription(String text) async {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 5),
            color: Color(0xffFFDE30),
            borderRadius: BorderRadius.circular(20)),
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset("assets/close.svg")),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.descriptionTitle.toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Text(
                    widget.descriptionText.toUpperCase(),
                    style: TextStyle(color: Colors.black, fontSize: 23),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 50.0)),
                // TextButton(
                //     onPressed: () {
                //       Navigator.of(context).pop(true);
                //     },
                //     child: Text(
                //       'Got It!',
                //       style: TextStyle(color: Colors.purple, fontSize: 18.0),
                //     ))
              ],
            ),
          ],
        ),
      ),
    );
    return await showDialog(
      context: context,
      builder: (BuildContext context) => errorDialog,
    );
  }
}
