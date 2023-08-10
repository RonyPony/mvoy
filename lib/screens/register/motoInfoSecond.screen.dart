import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/models/processResponse.dart';
import 'package:mvoy/providers/driver.provider.dart';
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
import 'package:provider/provider.dart';

import '../../models/credentials.dart';
import '../../models/driver.dart';
import '../../providers/auth.provider.dart';

class MotoInfoScreenSecond extends StatefulWidget {
  static String routeName = "/MotoInfoScreenSecond";

  const MotoInfoScreenSecond({super.key, this.usr, this.credentials});
  final MvoyDriver? usr;
  final Credentials? credentials;
  @override
  State<MotoInfoScreenSecond> createState() => _MotoInfoScreenSecondState();
}

class _MotoInfoScreenSecondState extends State<MotoInfoScreenSecond> {
  TextEditingController _seguroVigente = TextEditingController();
  TextEditingController _placa = TextEditingController();
  TextEditingController _color = TextEditingController();
  TextEditingController _marca = TextEditingController();
  TextEditingController _modelo = TextEditingController();

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
      child: GestureDetector(
        onTap: () async {
          widget.usr!.vehicle!.placa = _placa.text;
          widget.usr!.vehicle!.color = _color.text;
          widget.usr!.vehicle!.marca = _marca.text;
          widget.usr!.vehicle!.modelo = _modelo.text;
          widget.usr!.vehicle!.seguro = _seguroVigente.text;
          widget.usr!.vehicle!.tieneSeguro =
              _seguroVigente.text.toLowerCase() == "si";
          widget.usr!.vehicle!.year = selectedYear;

          final _auth = Provider.of<AuthProvider>(context, listen: false);
          final _vehicle = Provider.of<DriverProvider>(context, listen: false);

          MvoyUser registered =
              await _auth.registerUser(widget.usr!.user!, widget.credentials!);
          if (registered.id != null) {
            widget.usr!.user!.id = registered.id;
            widget.usr!.vehicle!.ownerId = registered.id;
            ProcessResponse vehicleCreated =
                await _vehicle.registerVehicleWithCredentials(
                    widget.usr!, widget.credentials!);

            if (vehicleCreated.success!) {
              showMessage("Registro completado", true);
            } else {
              showMessage(
                  "Usuario registrado, pero algo paso validando la informacion de tu vehiculo, favor contactar la administracion");
            }
          } else {
            showMessage("Ups, algo ha pasado y no pudimos registrarte");
          }
        },
        child: MvoyMainBtn(
          text: "registrate",
        ),
      ),
    );
  }

  Future<bool> showMessage(String text, [bool? isFinalMessage]) async {
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
                        if (isFinalMessage!) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                        } else {
                          Navigator.of(context).pop(true);
                        }
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
    );
    return await showDialog(
      context: context,
      builder: (BuildContext context) => errorDialog,
    );
  }

  _buildFields() {
    List<String> list = [];
    for (var i = 1800; i < 2024; i++) {
      list.add(i.toString());
    }
    return Column(
      children: [
        MvoyTextField(
          placeHolder: "no. placa",
          receivedController: _placa,
        ),
        MvoyTextField(
          placeHolder: "color",
          receivedController: _color,
        ),
        MvoyTextField(
          placeHolder: "marca",
          receivedController: _marca,
        ),
        MvoyTextField(
          placeHolder: "modelo",
          receivedController: _modelo,
        ),
        MvoyBooleanSelectorField(
            controller: _seguroVigente,
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
