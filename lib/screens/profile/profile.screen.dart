 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/providers/auth.provider.dart';
import 'package:mvoy/providers/currentUser.provider.dart';
import 'package:mvoy/providers/trip.provider.dart';
import 'package:mvoy/widgets/colors.dart';
import 'package:mvoy/widgets/textField.widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: Center(
        child:Column(
          children: [_buildScreen(context),
          ],
        ),
        
      ),

      bottomNavigationBar: MvoyBottomMenuBarWidget(activeIndex: 2,)
    );
  }

  _buildHeader(BuildContext context, Function onTap) {
    return MvoyAppBarWidget(
      onMenuTap: onTap,
    );
  }


  _buildProfileHeader(BuildContext context, MvoyUser user,  ) {
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
                    "${(user.name)} ${(user.lastname)}".toUpperCase(),
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
                      GestureDetector(
                        onTap: (){
                          Provider.of<UserProvider>(context).clearCurrentUser();
                        },
                        child: Text('data'))
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

  _buildWaitScreen( BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width * .96,
            height: MediaQuery.of(context).size.height * .70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white
            ),
            child: Center(
              child: Container(
               width: MediaQuery.of(context).size.width * .70,
               height: MediaQuery.of(context).size.height * .60,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
                child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        SvgPicture.asset(
          'assets/loading.svg',
          height: 100,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4,
        ),
        const Text(
          "Cargando informacion",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Por favor espera...")
      ],
    ),
              ),
            ),
          );
  }

  _builErrorScreen( BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width * .96,
            height: MediaQuery.of(context).size.height * .70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white
            ),
            child: Center(
              child: Container(
               width: MediaQuery.of(context).size.width * .70,
               height: MediaQuery.of(context).size.height * .60,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
                child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        SvgPicture.asset(
          'assets/loading.svg',
          height: 100,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4,
        ),
        const Text(
          "Error cargando la informacion",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Por favor espera...")
      ],
    ),
              ),
            ),
          );
  }

  _buildScreen(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
  final currentUser = userProvider.currentUser;

  if (currentUser == null) {
    return _buildWaitScreen(context);
  }
    return SafeArea(
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
                      _buildProfileHeader(
                        context, 
                        currentUser),
                      _buildProfileKPIS(),
                      Container(
                        height: MediaQuery.of(context).size.height * .43,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              _label("cedula"),
                              MvoyTextField(placeHolder: "${(currentUser.cedula)}", enabled: false,),
                              _label("primer nombre"),
                              MvoyTextField(placeHolder: "${(currentUser.name)}", enabled: false),
                              _label("segundo nombre"),
                              MvoyTextField(placeHolder: "${(currentUser.middleName)}", enabled: false),
                              _label("primer apellido"),
                              MvoyTextField(placeHolder: "${(currentUser.lastname)}", enabled: false),
                              _label("segundo apellido"),
                              MvoyTextField(placeHolder: "${(currentUser.lastname2)}", enabled: false),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  )),
            ],
          ),
        ),
      );
      
      }


}

    