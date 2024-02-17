import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/models/credentials.dart';
import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/screens/register/motoInfo.screen.dart';
import 'package:mvoy/widgets/booleanSelectorField.widget.dart';
import 'package:mvoy/widgets/colors.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/textField.widget.dart';
import 'package:provider/provider.dart';
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
  String _validationError = "";
  TextEditingController _email = TextEditingController();
  TextEditingController _telefono = TextEditingController();
  TextEditingController _direccion = TextEditingController();
  TextEditingController _relative = TextEditingController();
  TextEditingController _relativeNumber = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _validationError,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.normal),
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
        if (validateForm()) {
          widget.usr!.email = _email.text;
          widget.usr!.phone = _telefono.text;
          widget.usr!.direccion = _direccion.text;
          widget.usr!.relativeName = _relative.text;
          widget.usr!.relativeNumber = _relativeNumber.text;
          widget.usr!.gender = _gender.text;
          widget.usr!.creationDate = DateTime.now().toString();
          widget.usr!.isDeleted = false;
          widget.usr!.userKind = 1;
          Credentials cred =
              Credentials(password: _password.text, email: _email.text);
          if (widget.usr!.isDriver!) {
            // Navigator.of(context).pushNamed(MotoInfoScreen.routeName);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MotoInfoScreen(
                  usr: widget.usr,
                  credentials: cred,
                ),
              ),
            );
          } else {
            final _auth = Provider.of<AuthProvider>(context, listen: false);
            MvoyUser registered = await _auth.registerUser(widget.usr!, cred);
            if (registered.id != null) {
              showMessageSucess("Registrado");
              
            } else {
              showMessage("error");
            }
          }
        } else {
          setState(() {
            print("No valid Form");
          });
        }
        
      },
      child: MvoyMainBtn(
        text: "Registrarse",
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
              color: AppColors.primaryColor,
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
          placeHolder: "Clave",
          hideTeext: true,
          receivedController: _password,
        ),
        MvoyTextField(
          hideTeext: true,
          placeHolder: "Rep. Clave",
          receivedController: _password2,
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

  bool validateForm() {
    bool validEmail = !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email.text);
    if (validEmail) {
      _validationError = "Correo electronico no es valido";
      return false;
    }
    if (_password.text != _password2.text) {
      _validationError = "Las claves no coinciden";
      return false;
    }
    if (_telefono.text.length != 10) {
      _validationError = "Telefono no es valido";
      return false;
    }
    if (_direccion.text.length < 2) {
      _validationError = "Direccion no valida";
      return false;
    }
    if (_relative.text.length < 2) {
      _validationError = "Nombre de familiar no es valido";
      return false;
    }
    if (_relativeNumber.text.length < 2) {
      _validationError = "Numero de familiar no es valido";
      return false;
    }
    setState(() {
      _validationError = "";
    });
    return true;
  }

  Future<bool> showMessageSucess(String text) async {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5),
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * .25,
          width: MediaQuery.of(context).size.width * 0,
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
                          Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false);
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
}

