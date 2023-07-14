import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/screens/register/motoInfo.screen.dart';
import 'package:mvoy/widgets/booleanSelectorField.widget.dart';
import 'package:mvoy/widgets/datePickerField.widget.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';
import 'package:mvoy/widgets/textField.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.screen.dart';

class PersonalInfoSecondScreen extends StatefulWidget {
  static String routeName = "/PersonalInfoSecondScreen";
  final MvoyUser? usr;
  const PersonalInfoSecondScreen({super.key, this.usr});

  @override
  State<PersonalInfoSecondScreen> createState() =>
      _PersonalInfoSecondScreenState();
}

class _PersonalInfoSecondScreenState extends State<PersonalInfoSecondScreen> {
  bool isDriver = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _telefono = TextEditingController();
  TextEditingController _direccion = TextEditingController();
  TextEditingController _relative = TextEditingController();
  TextEditingController _relativeNumber = TextEditingController();
  TextEditingController _gender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 222, 48, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildregisterForm(),
            _buildregisterBtn(),
            _buildSigninBtn()
          ],
        ),
      )),
    );
  }

  _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            "assets/usuario.svg",
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
                  "INFORMACION PERSONAL !",
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
    return GestureDetector(
      onTap: () async {
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // final String? tmpUserJson = prefs.getString('tmpMvoyUser');
        widget.usr!.email = _email.text;
        widget.usr!.phone = _telefono.text;
        widget.usr!.direccion = _direccion.text;
        widget.usr!.relativeName = _relative.text;
        widget.usr!.relativeNumber = _relativeNumber.text;
        widget.usr!.gender = _gender.text;
        if (widget.usr!.isDriver!) {
          // Navigator.of(context).pushNamed(MotoInfoScreen.routeName);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MotoInfoScreen(
                usr: widget.usr,
              ),
            ),
          );
        }
      },
      child: MvoyMainBtn(
        text: "siguiente",
      ),
    );
  }

  _buildFields() {
    return Column(
      children: [
        MvoyTextField(
          placeHolder: "correo electronico",
          receivedController: _email,
        ),
        MvoyTextField(
          placeHolder: "telefono",
          receivedController: _telefono,
        ),
        MvoyTextField(
          placeHolder: "direccion",
          receivedController: _direccion,
        ),
        MvoyTextField(
          placeHolder: "nombre de un familiar",
          receivedController: _relative,
        ),
        MvoyTextField(
          placeHolder: "telefono del familiar",
          receivedController: _relativeNumber,
        ),
        MvoyBooleanSelectorField(
          placeHolder: "sexo",
          option1Text: "M",
          option2Text: "F",
          controller: _gender,
        ),
      ],
    );
  }

  _buildSigninBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
            child: MvoyLinkedBtn(
              text: "inicia sesion",
              showArrow: false,
            ),
          ),
        ],
      ),
    );
  }
}
