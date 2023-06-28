import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/screens/login.screen.dart';
import 'package:mvoy/widgets/booleanSelectorField.widget.dart';
import 'package:mvoy/widgets/datePickerField.widget.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/imagePickerField.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/optionSelectorField.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';
import 'package:mvoy/widgets/textField.widget.dart';

class MotoInfoScreenSecond extends StatefulWidget {
  static String routeName = "/MotoInfoScreenSecond";

  const MotoInfoScreenSecond({super.key});

  @override
  State<MotoInfoScreenSecond> createState() => _MotoInfoScreenSecondState();
}

class _MotoInfoScreenSecondState extends State<MotoInfoScreenSecond> {
  String selectedYear = "año";
  bool isDriver = false;
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 222, 48, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [_buildHeader(), _buildregisterForm(), _buildregisterBtn()],
        ),
      )),
    );
  }

  _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 0),
          child: Image.asset(
            'assets/base-logo.png',
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            "REGISTRATE",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            "assets/moto.svg",
            height: 50,
          ),
        )
      ],
    );
  }

  _buildregisterForm() {
    return MvoyFormPanel(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "CUENTANOS MAS DE LA MOTO !",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          _buildFields()
        ],
      ),
    );
  }

  _buildregisterBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: MvoyMainBtn(
        text: "registrate",
      ),
    );
  }

  _buildFields() {
    List<String> list = [];
    for (var i = 1800; i < 2024; i++) {
      list.add(i.toString());
    }
    return Column(
      children: [
        MvoyTextField(placeHolder: "no. placa"),
        MvoyTextField(placeHolder: "color"),
        MvoyTextField(placeHolder: "marca"),
        MvoyTextField(placeHolder: "modelo"),
        MvoyBooleanSelectorField(
            placeHolder: "seguro vigente",
            option1Text: "si",
            option2Text: "no"),
        MvoyOptionSelectorField(
          placeHolder: selectedYear,
          list: list,
          onSelected: (x) {
            setState(() {
              selectedYear = list[x];
            });
          },
        )
      ],
    );
  }
}
