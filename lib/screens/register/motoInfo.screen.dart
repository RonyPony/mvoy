import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/models/driver.dart';
import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/models/vehicle.dart';
import 'package:mvoy/screens/login.screen.dart';
import 'package:mvoy/screens/register/motoInfoSecond.screen.dart';
import 'package:mvoy/widgets/booleanSelectorField.widget.dart';
import 'package:mvoy/widgets/colors.dart';
import 'package:mvoy/widgets/datePickerField.widget.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/imagePickerField.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';
import 'package:mvoy/widgets/textField.widget.dart';

import '../../models/credentials.dart';

class MotoInfoScreen extends StatefulWidget {
  static String routeName = "/MotoInfoScreen";

  const MotoInfoScreen({super.key, this.usr, this.credentials});
  final MvoyUser? usr;
  final Credentials? credentials;
  @override
  State<MotoInfoScreen> createState() => _MotoInfoScreenState();
}

class _MotoInfoScreenState extends State<MotoInfoScreen> {
  bool isDriver = false;
  TextEditingController _licencia = TextEditingController();
  TextEditingController _segurp = TextEditingController();
  TextEditingController _chasis = TextEditingController();
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
                  "HABLANOS DE TU MOTO !",
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
      padding: const EdgeInsets.only(bottom: 40),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed(MotoInfoScreenSecond.routeName);
          MvoyDriver driver = MvoyDriver();
          MvoyVehicle vehicle = MvoyVehicle();
          vehicle.license = _licencia.text;
          vehicle.seguro = _segurp.text;
          vehicle.chasis = _chasis.text;
          driver.user = widget.usr;
          driver.vehicle = vehicle;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MotoInfoScreenSecond(
                usr: driver,
                credentials: widget.credentials,
              ),
            ),
          );
        },
        child: MvoyMainBtn(
          text: "siguiente",
        ),
      ),
    );
  }

  _buildFields() {
    return Column(
      children: [
        MvoyTextField(
          placeHolder: "licencia",
          receivedController: _licencia,
        ),
        MvoyTextField(
          placeHolder: "seguro",
          receivedController: _segurp,
        ),
        MvoyTextField(
          placeHolder: "no. de chasis",
          receivedController: _chasis,
        ),
        MvoyImageField(
            placeHolder: "foto del vehiculo",
            hasDescription: true,
            descriptionText:
                "DEBES INCLUIR TRES IMAGENES MOSTRANDO TU VEHICULO EN VARIOS ANGULOS. INCLUYENDO UNO DONDE SEA VISIBLE LA PLACA.",
            descriptionTitle: "informacion"),
        MvoyImageField(
          placeHolder: "foto de matricula",
          hasDescription: true,
          descriptionTitle: "informacion",
          descriptionText:
              "ASEGURATE DE QUE EN ESTA FOTO LA INFORMACION PUEDA SER LEIDA  CORRECTAMENTE. SI LA MATRICULA NO ESTA A TU NOMBRE, ANEXA IMAGENES DEL ACTO DE VENTA.",
        )
      ],
    );
  }
}
