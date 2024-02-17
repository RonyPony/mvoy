import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvoy/screens/homeScreen/homePage.screen.dart';
import 'package:mvoy/screens/login.screen.dart';
import 'package:mvoy/screens/mytrips/mytrips.screen.dart';
import 'package:mvoy/screens/profile/profile.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MvoyDrawerWidget extends StatefulWidget {
  final Function? onMenuTap;
  const MvoyDrawerWidget({Key? key, this.onMenuTap}) : super(key: key);

  @override
  State<MvoyDrawerWidget> createState() => _MvoyDrawerWidgetState();
}

class _MvoyDrawerWidgetState extends State<MvoyDrawerWidget> {
  double? activeTab;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child:
          // Column(
          //   children: [
          //     Container(
          //       height: 100,
          //       decoration: const BoxDecoration(
          //           image: DecorationImage(
          //         image: AssetImage("assets/logo.png"),
          //       )),
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         SvgPicture.asset('assets/caco.svg'),
          //         const SizedBox(
          //           width: 30,
          //         ),
          //         const Text(
          //           'INICIO',
          //           style: TextStyle(fontSize: 25),
          //         ),
          //       ],
          //     )
          //   ],
          // )
          ListView(
        padding: EdgeInsets.only(top: 10),
        children: [
          _buildDrawerHeader(),
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/caco.svg'),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  'INICIO',
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false);
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/trip.svg'),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'MIS VIAJES',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => MyTripsScreen(),
                  ),
                  (route) => false);
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/profile.svg'),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'PERFIL',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                  (route) => false);
            },
          ),
          SizedBox(
            height: 200,
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/logout.svg'),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'SALIR',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            onTap: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('userId');
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);

            },
          ),
        ],
      ),
    );
  }

  _buildDrawerHeader() {
    return DrawerHeader(
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/logo.png"),
        )),
      ),
    );
  }
}
