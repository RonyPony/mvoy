import 'package:flutter/material.dart';
import 'package:mvoy/screens/password/forgottenPassword.screen.dart';
import 'package:mvoy/screens/register/chooseRole.screen.dart';
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
            _buildSignupBtn(context),
            _buildForgottenPass(context)
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
              top: baseSize.height * .01, right: baseSize.width * .04),
          child: MvoyLinkedBtn(
            text: "saltar",
          ),
        ),
      ],
    );
  }

  _buildLogo() {
    return Image.asset(
      'assets/base-logo.png',
      height: 130,
    );
  }

  _buildLoginForm() {
    return const MvoyFormPanel(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MvoyTextField(
                placeHolder: "usuario",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  _buildSignupBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ChooseRoleScreen.routeName);
            },
            child: MvoyLinkedBtn(
              text: "registrate",
              showArrow: false,
            ),
          ),
        ],
      ),
    );
  }

  _buildForgottenPass(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ForgottenPasswordScreen.routeName);
            },
            child: MvoyLinkedBtn(
              text: "olvide mi contraseña",
              fontSize: 15,
              showArrow: false,
            ),
          ),
        ],
      ),
    );
  }
}
