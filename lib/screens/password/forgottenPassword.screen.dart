import 'package:flutter/material.dart';
import 'package:mvoy/screens/login.screen.dart';
import 'package:mvoy/screens/register/chooseRole.screen.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';

import '../../widgets/textField.widget.dart';

class ForgottenPasswordScreen extends StatelessWidget {
  static String routeName = "/ForgottenPasswordScreen";

  const ForgottenPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 222, 48, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildLogo(),
            _buildLoginForm(),
            _buildLoginBtn(),
            _buildSignupBtn(context)
          ],
        ),
      )),
    );
  }

  _buildLogo() {
    return Image.asset(
      'assets/base-logo.png',
      height: 200,
    );
  }

  _buildLoginForm() {
    return const MvoyFormPanel(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "RECUPERAR CONTRASEÑA",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MvoyTextField(
                placeHolder: "correo electronico",
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildLoginBtn() {
    return MvoyMainBtn(
      text: "solicitar",
    );
  }

  _buildSignupBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 150,
      ),
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
