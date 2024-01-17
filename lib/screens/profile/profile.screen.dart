 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/widgets/colors.dart';
import 'package:mvoy/widgets/textField.widget.dart';

import '../../widgets/appbar.dart';
import '../../widgets/bottomMenuBar.widget.dart';
import '../../widgets/drawer.widget.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        actions: [
          _buildHeader(context, () => _scaffoldKey.currentState!.openDrawer()),
        ],
      ),
      drawer: MvoyDrawerWidget(),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  // height: MediaQuery.of(context).size.height * .85,
                  width: MediaQuery.of(context).size.width * .95,
                  child: Column(
                    children: [
                      _buildProfileHeader(context),
                      _buildProfileKPIS(),
                      Container(
                        height: MediaQuery.of(context).size.height * .43,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: _buildFrom(),
                        ),
                      ),
                      
                    ],
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MvoyBottomMenuBarWidget(activeIndex: 0,)
    );
  }

  _buildHeader(BuildContext context, Function onTap) {
    return MvoyAppBarWidget(
      onMenuTap: onTap,
    );
  }

  _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.black, width: 4)),
                width: 110,
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Text(
                    "{username}{userLastname}}".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/locationSpot.svg',
                        height: 30,
                      ),
                      Text(
                        "{{userLocation}}".toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  _buildProfileKPIS() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(30)),
        width: 350,
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "172",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text("viajes".toUpperCase())
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(.3)),
                    width: 2,
                    height: 80,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "436KM",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text("recorridos".toUpperCase())
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(.3)),
                    width: 2,
                    height: 80,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "7H",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text("de viaje".toUpperCase())
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildFrom() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        _label("cedula"),
        MvoyTextField(placeHolder: "40227599079"),
        _label("primer nombre"),
        MvoyTextField(placeHolder: "ronel"),
        _label("segundo nombre"),
        MvoyTextField(placeHolder: "ronel"),
        _label("primer apellido"),
        MvoyTextField(placeHolder: "ronel"),
        _label("segundo apellido"),
        MvoyTextField(placeHolder: "ronel"),
      ],
    );
  }

  _label(String s) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 35),
          child: Text(
            s.toUpperCase(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
