import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvoy/widgets/mainBtn.widget.dart';

import '../../widgets/bottomMenuBar.widget.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/homeScreen";

  const HomeScreen({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late GoogleMapController mapController;
  CameraPosition? _googleMapCurrentCameraPosition;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  var _darkMapStyle;
  bool showZoomControl = false;
  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_darkMapStyle);
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMapStyles();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_dark_style.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 222, 48, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildSerchBar(context),
              FutureBuilder<Widget>(
                future: _buildMap(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildWaitScreen();
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return snapshot.data!;
                  }
                  return _buildWaitScreen();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: SvgPicture.asset('assets/usuario.svg'),
            // backgroundImage: AssetImage('assets/images/cat3.png'),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .05),
          Text(
            "Hola, Ernesto!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
          ),
          SvgPicture.asset('assets/MENU.svg')
        ],
      ),
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

  Future<Widget> _buildMap(BuildContext context) async {
    Position position = await _determinePosition();
    final LatLng _center = LatLng(position.latitude, position.longitude);

    return await Container(
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
              GoogleMap(
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                compassEnabled: true,
                onCameraMove: (position) {
                  _googleMapCurrentCameraPosition = position;
                },
                // myLocationButtonEnabled: true,
                // liteModeEnabled: true,
                // mapToolbarEnabled: true,
                trafficEnabled: true,

                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      showZoomControl
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    mapController.getScreenCoordinate(LatLng(
                                        _googleMapCurrentCameraPosition!
                                            .target.latitude,
                                        _googleMapCurrentCameraPosition!
                                            .target.longitude));
                                    mapController.animateCamera(CameraUpdate
                                        .newCameraPosition(CameraPosition(
                                            target:
                                                _googleMapCurrentCameraPosition!
                                                    .target,
                                            zoom:
                                                _googleMapCurrentCameraPosition!
                                                        .zoom +
                                                    1)));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 222, 48, 1),
                                              fontSize: 40),
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    mapController.getScreenCoordinate(LatLng(
                                        _googleMapCurrentCameraPosition!
                                            .target.latitude,
                                        _googleMapCurrentCameraPosition!
                                            .target.longitude));
                                    mapController.animateCamera(CameraUpdate
                                        .newCameraPosition(CameraPosition(
                                            target:
                                                _googleMapCurrentCameraPosition!
                                                    .target,
                                            zoom:
                                                _googleMapCurrentCameraPosition!
                                                        .zoom -
                                                    1)));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 222, 48, 1),
                                              fontSize: 40),
                                        ),
                                      )),
                                ),
                              ],
                            )
                          : SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showZoomControl = !showZoomControl;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  SvgPicture.asset('assets/zoom-control.svg'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: MvoyMainBtn(
                              text: "solicitar viaje",
                              textSize: 16,
                              width: MediaQuery.of(context).size.width * .5,
                              showNextIcon: false,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              Position currentPosition =
                                  await _determinePosition();
                              mapController.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(currentPosition.latitude,
                                          currentPosition.longitude),
                                      zoom: 17)));
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset('assets/location.svg'),
                            ),
                          ),
                        ],
                      ),
                      MvoyBottomMenuBarWidget(
                        activeIndex: 0,
                      )
                    ],
                  );
                },
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

  Widget _buildWaitScreen() {
    return CircularProgressIndicator();
  }
}
