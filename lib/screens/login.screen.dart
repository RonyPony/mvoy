import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/models/credentials.dart';
import 'package:mvoy/models/loginResponse.dart';
import 'package:mvoy/screens/homeScreen/homePage.screen.dart';
import 'package:mvoy/screens/password/forgottenPassword.screen.dart';
import 'package:mvoy/screens/register/chooseRole.screen.dart';
import 'package:mvoy/widgets/colors.dart';
import 'package:mvoy/widgets/formPanel.widget.dart';
import 'package:mvoy/widgets/linkedBtn.widget.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';
import 'package:mvoy/widgets/passwordField.widget.dart';
import 'package:provider/provider.dart';

import '../providers/auth.provider.dart';
import '../widgets/textField.widget.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/loginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSkiptBtn(baseSize),
            _buildLogo(),
            _buildLoginForm(),
            _buildLoginBtn(context),
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
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
            child: MvoyLinkedBtn(
              text: "saltar",
            ),
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
    return MvoyFormPanel(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MvoyTextField(
                receivedController: _emailController,
                placeHolder: "email",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MvoyPasswordField(
                receivedController: _passwordController,
                placeHolder: "contraseña",
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildLoginBtn(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final _auth = Provider.of<AuthProvider>(context, listen: false);
        Credentials credenciales = Credentials();
        credenciales.email = _emailController.text;
        credenciales.password = _passwordController.text;
        if (credenciales.email == null ||
            credenciales.email == "" ||
            credenciales.password == null ||
            credenciales.password == "") {
          showMessage(
              "por favor ingresa tu correo y tu clave para poder acceder");
          return;
        }
        LoginResponse loginResponse = await _auth.signin(credenciales);
        if (loginResponse.success!) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        } else {
          showMessage(loginResponse.message == null
              ? "Error Iniciando sesion"
              : loginResponse.message!);
        }
      },
      child: MvoyMainBtn(
        text: "ingresar",
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
          height: MediaQuery.of(context).size.height * .3,
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
                            "inicia sesion".toUpperCase(),
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
