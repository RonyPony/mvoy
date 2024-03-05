 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/providers/auth.provider.dart';
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
          children: [_buildList(context)],
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

  // _buildFrom() {
  //   final String? cedula;
  //   final String? pNombre;
  //   final String? sNombre;
  //   final String? pApellido;
  //   final String? sApellido;
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 20,
  //       ),
  //       _label("cedula"),
  //       MvoyTextField(placeHolder: ""),
  //       _label("primer nombre"),
  //       MvoyTextField(placeHolder: "ronel"),
  //       _label("segundo nombre"),
  //       MvoyTextField(placeHolder: "ronel"),
  //       _label("primer apellido"),
  //       MvoyTextField(placeHolder: "ronel"),
  //       _label("segundo apellido"),
  //       MvoyTextField(placeHolder: "ronel"),
  //     ],
  //   );
  // }

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


  // _currentId()async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? id = prefs.getString('userId');
  //   return id;
  // }

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
          "Cargando Lista de Viajes",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Por favor espera ...")
      ],
    ),
              ),
            ),
          );
  }

  _buildList(BuildContext context) {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    final getUser = Provider.of<AuthProvider>(context, listen: false);
    var future =getUser.getCurrentUser();
    return  FutureBuilder(
      future: future, 
      builder:(context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error obteniendo lista de viajes");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildWaitScreen(context);
          
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
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
                      _buildProfileHeader(context),
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
                              MvoyTextField(placeHolder: "${(snapshot.data!.cedula)}", enabled: false,),
                              _label("primer nombre"),
                              MvoyTextField(placeHolder: "${(snapshot.data!.name)}", enabled: false),
                              _label("segundo nombre"),
                              MvoyTextField(placeHolder: "${(snapshot.data!.middleName)}", enabled: false),
                              _label("primer apellido"),
                              MvoyTextField(placeHolder: "${(snapshot.data!.lastname)}", enabled: false),
                              _label("segundo apellido"),
                              MvoyTextField(placeHolder: "${(snapshot.data!.lastname2)}", enabled: false),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  )),
            ],
          ),
        ),
      );;
          // Text("${(snapshot.data!.name)}");
        }
        return LinearProgressIndicator(
          color: AppColors.primaryColor,
        );
      },);}


}

    