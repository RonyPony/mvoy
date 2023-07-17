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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/processResponse.dart';
import '../../providers/auth.provider.dart';
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
        widget.usr!.creationDate = DateTime.now().toString();
        widget.usr!.isDeleted = false;
        widget.usr!.userKind = 1;
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
        } else {
          final _auth = Provider.of<AuthProvider>(context, listen: false);
          ProcessResponse registered = await _auth.registerUser(widget.usr!);
          if (registered.success!) {
            showMessage(registered.errorMessage!);
          } else {
            showMessage(registered.errorMessage!);
          }
        }
      },
      child: MvoyMainBtn(
        text: "siguiente",
      ),
    );
  }

  Future<bool> showMessage(String text) async {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
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
                          Navigator.of(context).pop(true);
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
                            "titulo".toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
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
                      text.toUpperCase(),
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 50.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return await showDialog(
      context: context,
      builder: (BuildContext context) => errorDialog,
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
