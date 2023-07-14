import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/screens/register/personalInformationSecond.screen.dart';
import 'package:mvoy/widgets/datePickerField.widget.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';
import 'package:mvoy/widgets/textField.widget.dart';
import 'package:provider/provider.dart';

import '../../models/dominicanPerson.dart';
import '../../models/processResponse.dart';
import '../../providers/auth.provider.dart';
import '../login.screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  static String routeName = "/personalInfoScreen";
  final MvoyUser? usr;
  const PersonalInfoScreen({super.key, this.usr});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  bool isDriver = false;
  TextEditingController _cedula = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _secondName = TextEditingController();
  TextEditingController _lastName1 = TextEditingController();
  TextEditingController _lastName2 = TextEditingController();
  TextEditingController _birthDate = TextEditingController();
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
      onTap: () {
        // Navigator.of(context).pushNamed(PersonalInfoSecondScreen.routeName);
        widget.usr!.cedula = _cedula.text;
        widget.usr!.name = _firstName.text;
        widget.usr!.middleName = _secondName.text;
        widget.usr!.lastname = _lastName1.text;
        widget.usr!.lastname2 = _lastName2.text;
        widget.usr!.birthDate = _birthDate.text;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalInfoSecondScreen(
              usr: widget.usr,
            ),
          ),
        );
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
          placeHolder: "cedula",
          keyboardType: TextInputType.number,
          receivedController: _cedula,
          onChanged: () {
            if (_cedula.text.length >= 11) {
              getDominicanPerson(_cedula.text);
            }
          },
        ),
        MvoyTextField(
            placeHolder: "primer nombre", receivedController: _firstName),
        MvoyTextField(
          placeHolder: "segundo nombre",
          receivedController: _secondName,
        ),
        MvoyTextField(
          placeHolder: "primer apellido",
          receivedController: _lastName1,
        ),
        MvoyTextField(
          placeHolder: "segundo apellido",
          receivedController: _lastName2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MvoyDateField(
              placeHolder: "fecha de nacimiento",
              receivedController: _birthDate,
            ),
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

  getDominicanPerson(String cedula) async {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    DominicanPerson person = await _auth.getPersonInfoByCedula(cedula);
    if (person.cedula == null) {
      clearForm();
    } else {
      setState(() {
        _firstName.text = person.nombres!.split(' ')[0];
        _secondName.text =
            person.nombres!.contains(' ') ? person.nombres!.split(' ')[1] : "";
        _lastName1.text = person.apellido1!;
        _lastName2.text = person.apellido2!;
        _birthDate.text = person.fechaNacimiento!.split(' ')[0];
      });
    }
  }

  void clearForm() {
    setState(() {
      _firstName.clear();
      _secondName.clear();
      _lastName1.clear();
      _lastName2.clear();
      _birthDate.clear();
    });
  }
}
