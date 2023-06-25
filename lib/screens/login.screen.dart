import 'package:flutter/material.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';

import '../widgets/textField.widget.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/loginScreen";

  const LoginScreen({super.key});

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
            _buildLoginForm(),
            _buildLoginBtn(),
            _buildSignupBtn(),
            _buildForgottenPass()
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
            onTap: () {},
          ),
        ),
      ],
    );
  }

  _buildLogo() {
    return Image.asset(
      'assets/logox.png',
      height: 240,
    );
  }

  _buildLoginForm() {
    return const MvoyFormPanel(
      child: Column(
        children: [
          Row(
            children: [
              MvoyTextField(
                placeHolder: "usuario",
              ),
            ],
          ),
          Row(
            children: [
              MvoyPasswordField(
                placeHolder: "contraseña",
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildLoginBtn() {
    return MvoyMainBtn(
      text: "ingresar",
      onTapp: () {},
    );
  }

  _buildSignupBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MvoyLinkedBtn(
            text: "registrate",
            onTap: () {},
            showArrow: false,
          ),
        ],
      ),
    );
  }

  _buildForgottenPass() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MvoyLinkedBtn(
            text: "olvide mi contraseña",
            fontSize: 15,
            onTap: () {},
            showArrow: false,
          ),
        ],
      ),
    );
  }
}
