import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvoy/screens/driverDetailScreen/driverDetail.screen.dart';

import '../../widgets/appbar.dart';
import '../../widgets/bottomMenuBar.widget.dart';
import '../../widgets/detailsList.widget.dart';
import '../../widgets/drawer.widget.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});
  static String routeName = "/tripdetailsscreen";
  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen>
    with SingleTickerProviderStateMixin {
  late GoogleMapController mapController;
  late AnimationController _controller;
  var _darkMapStyle;
  CameraPosition? _googleMapCurrentCameraPosition;
  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_darkMapStyle);
    mapController = controller;
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_dark_style.json');
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _loadMapStyles();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final tripId = ModalRoute.of(context)!.settings.arguments as int;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                // height: MediaQuery.of(context).size.height * .85,
                width: MediaQuery.of(context).size.width * .95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .71,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          _buildTripHeader(tripId.toString()),
                          _buildTripMapInitial(context),
                          _buildTripInfo()
                        ],
                      )),
                    ),
                    MvoyBottomMenuBarWidget(activeIndex: 1)
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _buildHeader(BuildContext context, Function onTap) {
    return MvoyAppBarWidget(
      onMenuTap: onTap,
    );
  }

  _buildTripHeader(String tripid) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 20),
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            "viaje no. ".toUpperCase() +
                tripid +
                " | de los mameyes a san isidro".toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SvgPicture.asset(
          'assets/trip.svg',
          height: 80,
        )
      ],
    );
  }

  Future<Widget> _buildTripMap() async {
    Position position = await _determinePosition();
    final LatLng _center = LatLng(position.latitude, position.longitude);

    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width * .9,
          child: GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            compassEnabled: false,
            zoomGesturesEnabled: false,
            onCameraMove: (position) {
              _googleMapCurrentCameraPosition = position;
            },
            trafficEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            scrollGesturesEnabled: false,
            tiltGesturesEnabled: false,
            liteModeEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("PUNTO DE LLEGADA"),
                SizedBox(
                  width: 35,
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(50)),
                ),
                SizedBox(
                  width: 5,
                ),
                Text("PUNTO DE SALIDA"),
              ],
            ),
          ],
        )
      ],
    );
  }

  _buildTripInfo() {
    Map<String, String> tripData = <String, String>{
      "duracion del viaje": "15 minutos",
      "distancia del viaje": "2.5 kilometros",
      "hora de salida": "1:22 PM",
      "hora de llegada": "1:38 PM",
      "conductor": "kevin rosario",
      "precio": "RD: 145.00"
    };
    return MvoyDetailsListWidget(
      data: tripData,
      height: 170,
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

  _buildTripMapInitial(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _buildTripMap(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return snapshot.data!;
        }
        return LinearProgressIndicator();
      },
    );
  }
}
