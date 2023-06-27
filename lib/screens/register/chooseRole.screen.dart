import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvoy/screens/register/personalInformation.screen.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';

class ChooseRoleScreen extends StatefulWidget {
  static String routeName = "/registerScreen";

  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
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
            _buildSkiptBtn(baseSize),
            _buildLogo(),
            _buildregisterForm(),
            _buildregisterBtn()
          ],
        ),
      )),
    );
  }

  _buildSkiptBtn(Size baseSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: baseSize.height * .04, right: baseSize.width * .04),
          child: MvoyLinkedBtn(
            text: "saltar",
          ),
        ),
      ],
    );
  }

  _buildLogo() {
    return Image.asset(
      'assets/logox.png',
      height: 200,
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
                  "ELIGE TU EQUIPO !",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          _buildOptions()
        ],
      ),
    );
  }

  _buildregisterBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PersonalInfoScreen.routeName);
      },
      child: MvoyMainBtn(
        text: "siguiente",
      ),
    );
  }

  _buildOptions() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isDriver = true;
            });
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Color(0xffFFDE30),
                border: isDriver
                    ? Border.all(color: Colors.black, width: 5)
                    : Border.symmetric(),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/caco.svg",
                  width: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "CONDUCTOR",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isDriver = false;
            });
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Color(0xffFFDE30),
                border: !isDriver
                    ? Border.all(color: Colors.black, width: 5)
                    : Border.symmetric(),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/usuarios.svg",
                  width: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "PASAJERO",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
