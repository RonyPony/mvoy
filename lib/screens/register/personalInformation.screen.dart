import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/screens/register/personalInformationSecond.screen.dart';
import 'package:mvoy/widgets/datePickerField.widget.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';
import 'package:mvoy/widgets/textField.widget.dart';

import '../login.screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  static String routeName = "/personalInfoScreen";

  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  bool isDriver = false;
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
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Image.asset(
            'assets/logox.png',
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "REGISTRATE",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
      onTap: () {
        Navigator.of(context).pushNamed(PersonalInfoSecondScreen.routeName);
      },
      child: MvoyMainBtn(
        text: "siguiente",
      ),
    );
  }

  _buildFields() {
    return const Column(
      children: [
        MvoyTextField(placeHolder: "cedula"),
        MvoyTextField(placeHolder: "primer nombre"),
        MvoyTextField(placeHolder: "segundo nombre"),
        MvoyTextField(placeHolder: "primer apellido"),
        MvoyTextField(placeHolder: "segundo apellido"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MvoyDateField(placeHolder: "fecha de nacimiento"),
          ],
        )
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
