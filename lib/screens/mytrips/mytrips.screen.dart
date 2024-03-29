import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvoy/screens/tripDetailsScreen/tripDetails.screen.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';

import '../../widgets/appbar.dart';
import '../../widgets/bottomMenuBar.widget.dart';
import '../../widgets/drawer.widget.dart';

class MyTripsScreen extends StatefulWidget {
  static String routeName = "/MyTripsScreen";

  const MyTripsScreen({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<MyTripsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Color.fromRGBO(255, 222, 48, 1),
        automaticallyImplyLeading: false,
        actions: [
          _buildHeader(context, () => _scaffoldKey.currentState!.openDrawer()),
        ],
      ),
      drawer: MvoyDrawerWidget(),
      backgroundColor: Color.fromRGBO(255, 222, 48, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [_buildSerchBar(context), _buildList(context)],
          ),
        ),
      ),
    );
  }

  _buildHeader(BuildContext context, Function onTap) {
    return MvoyAppBarWidget(
      onMenuTap: onTap,
    );
  }

  _buildSerchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .8,
            height: 60,
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    'assets/moto.svg',
                    height: 10,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: "  A DONDE VAMOS ?",
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  fillColor: Color.fromRGBO(255, 222, 48, 1),
                  filled: true),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5)),
            child: SvgPicture.asset('assets/search.svg'),
          )
        ],
      ),
    );
  }

  _buildList(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .96,
      height: MediaQuery.of(context).size.height * .75,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "MIS VIAJES",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      // color: Colors.red,
                      height: MediaQuery.of(context).size.height * .60,
                      width: MediaQuery.of(context).size.width * .9,
                      child: ListView.builder(
                        itemCount: 300,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    TripDetailsScreen.routeName,
                                    arguments: index + 1);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(255, 222, 48, 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: SvgPicture.asset(
                                            'assets/trip.svg',
                                            height: 90,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              // color: Colors.red,
                                              width: 200,
                                              child: Text(
                                                "viaje ".toUpperCase() +
                                                    (index + 1).toString() +
                                                    " | de los mameyes a san isidro"
                                                        .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "lunes 14 de febrero, 2020"
                                                  .toUpperCase(),
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MvoyBottomMenuBarWidget(
                    activeIndex: 1,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
