import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvoy/models/trip.dart';
import 'package:mvoy/widgets/colors.dart';

import '../../widgets/appbar.dart';
import '../../widgets/bottomMenuBar.widget.dart';
import '../../widgets/detailsList.widget.dart';
import '../../widgets/drawer.widget.dart';

class CurrentTripDetailsScreen extends StatefulWidget {
  const CurrentTripDetailsScreen({super.key});
  static String routeName = "/currenttripdetailsscreen";
  @override
  State<CurrentTripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<CurrentTripDetailsScreen>

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
    final tripdata = ModalRoute.of(context)!.settings.arguments as Trip;

    // void _newOffer (Trip newTrip, String newPrice){
    //   setState(() {
    //   });
    // }
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
      body: SingleChildScrollView(
        child: SafeArea(
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
                            _buildTripHeader("Desde "+tripdata.originName!+ "hasta "+tripdata.destinyName!),
                            _buildTripMapInitial(context),
                            _buildTripInfo(tripdata),
                            Padding(padding: const EdgeInsets.only(top: 14),
                            child: ElevatedButton(onPressed: (){
                              TextEditingController  txtControler = TextEditingController();
                              txtControler.text =tripdata.price!;
                              _showDialogo(txtControler, context,tripdata);
                            }
                            , 
                            child: Text("Negociar", style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor
                            ),
                            ),
                            ),
                          ],
                        )),
                      ),
                      // MvoyBottomMenuBarWidget(activeIndex: 1)
                    ],
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MvoyBottomMenuBarWidget(activeIndex: 1),
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
          child: Text(tripid.toUpperCase(),
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
              zoom: 12.0,
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

  

  _buildTripInfo(Trip newtrip) {
    Map<String, String> tripData = <String, String>{
      "duracion del viaje": "${newtrip.duration} minutos",
      "distancia del viaje": newtrip.distance! + " KM",
      "hora de salida": newtrip.leavingTime!,
      "hora de llegada": newtrip.arrivingTime!,
      "conductor": "kevin rosario",
      "precio": "RD: ${newtrip.price}"
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
          return LinearProgressIndicator(
            color: AppColors.primaryColor,
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return snapshot.data!;
        }
        return LinearProgressIndicator(
           color: AppColors.primaryColor,
        );
      },
    );
  }
}

  

_showDialogo(TextEditingController offerController, BuildContext context, Trip myTrip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          title: Center(child: Text('Nueva Oferta',
          style: TextStyle(
            fontWeight: FontWeight.bold 
          ),
          )),
          content: TextField(
            keyboardType: TextInputType.number,
            cursorColor:Colors.black,
            controller: offerController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              fillColor: Colors.black,
              hintText: 'Oferte no menor a \$50 ',
              focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black), 
                  )
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
              onPressed: () {
                int price = int.parse(offerController.text);
                if (price < 50){
                  showMessage(
                    "No puede ofertar menor a \$50", context
                  );
                  print("El precio es menor");
                }else{
                  myTrip.price =offerController.text;
                print(myTrip.price);
                print(price);
                Navigator.of(context).pop(); 
                }
                
              },
              child: Text('Ofertar'.toUpperCase(),
              style: TextStyle(
                color: Colors.white
              ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 12)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                print('object');
              },
              child: Text('Cancelar'.toUpperCase(),
              style: TextStyle(
                color: Colors.white
              ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black
              ),
            ),
              ],
            )
          ],
        );
      },
    );
  }

 showMessage(String text, BuildContext context)  {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5),
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.30,
          width: MediaQuery.of(context).size.width * 0.80,
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
                          child: Center(
                            child: Text(
                              "Error en el monto".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
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
    return showDialog(
      context: context,
      builder: (BuildContext context) => errorDialog,
    );
  }