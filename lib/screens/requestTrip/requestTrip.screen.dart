import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvoy/models/autocomplate_prediction.dart';
import 'package:mvoy/models/place_auto_complate_response.dart';
import 'package:mvoy/models/trip.dart';
import 'package:mvoy/providers/map.provider.dart';
import 'package:mvoy/providers/trip.provider.dart';
import 'package:mvoy/screens/currentTripDetails/CurrentTripsDetailsScreen.dart';
import 'package:mvoy/services/googleMaps.service.dart';
import 'package:mvoy/widgets/colors.dart';
import 'package:mvoy/widgets/location_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:mvoy/models/coordinates.dart'  ;

class RequestTrip extends StatefulWidget {
  static String routeName = "/RequestTrip";
  const RequestTrip({super.key});
  @override
  State<StatefulWidget> createState() => _RequestTripState();

}

class _RequestTripState extends State<RequestTrip> {
  
  
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;
  static const API_KEY = 'AIzaSyCY47HTgLpdMDimZ49YdWqzWk-rt5UI3jA';
  late Position _currentPosition;
  String _currentAddress = '';
  bool showPredictionContainer = false;
  List<AutocompletePrediction> placesPredictions = [];
  void placeAutoComplete(String query) async{
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json", //undecpder path
      {"input":query,//parametro requerido por el api
      "key": API_KEY},
      
      ); 

      String? response = await GoogleMapServices().placeAutoComplete(uri);
      if (response != null){
        PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
        if(result.predictions != null){
          setState(() {
            placesPredictions = result.predictions!;
          });
        }
      }
      
      
  }

  var _darkMapStyle;
  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_darkMapStyle);
    mapController = controller;
  }
  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_dark_style.json');
    _getCurrentLocation();
  }

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance = "";
  double startLatitude = 0;
  double startLongitude = 0;
  double destinationLatitude = 0;
  double destinationLongitude = 0;

  bool showBottom = false;

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {}; 
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Widget prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        
        focusNode: focusNode,
        decoration: new InputDecoration(
          
          focusColor: Colors.black,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('Posicion actual: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.locality}, ${place.postalCode} ";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destino $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'Cordenadas de inicio: ($startLatitude, $startLongitude)',
      );
      print(
        'Cordenadas de destino: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(
        startLatitude, startLongitude, destinationLatitude,
          destinationLongitude
          );

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        // print('Distancia: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


  // Create the polylines for showing the route between two places
  _createPolylines(
   startLatitude,
   startLongitude,
   destinationLatitude,
   destinationLongitude,
    
  ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      API_KEY,
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    ); 

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadMapStyles();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Consumer<MapProvider>(
          builder: (BuildContext context, value, _) { 
            return SafeArea(
            child: Stack(
              children: <Widget>[
                // Map View
                GoogleMap(
                  
                  markers: Set<Marker>.from(markers),
                  initialCameraPosition: _initialLocation,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  polylines: Set<Polyline>.of(polylines.values),
                  onMapCreated: _onMapCreated,
                  
                ),
                // Show zoom buttons
                
                Positioned(
                  left: 4,
                  // top: ,
                  bottom: 10,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Material(
                              color: AppColors.primaryColor, // button color
                              child: InkWell(
                                splashColor: AppColors.secundaryColor, // inkwell color
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(Icons.add),
                                ),
                                onTap: () {
                                  mapController.animateCamera(
                                    CameraUpdate.zoomIn(),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ClipOval(
                            child: Material(
                              color: AppColors.primaryColor, // button color
                              child: InkWell(
                                splashColor: AppColors.secundaryColor, // inkwell color
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(Icons.remove),
                                ),
                                onTap: () {
                                  mapController.animateCamera(
                                    CameraUpdate.zoomOut(),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                showBottom ?
                Positioned(
                  left: MediaQuery.of(context).size.width * .35,
                  bottom: 24,
                  child:ElevatedButton(onPressed: () {
                    Coordinates startCordinates = Coordinates(startLatitude, startLongitude);
                    Coordinates endCordinates = Coordinates(destinationLatitude, destinationLongitude);
                    Trip newargument = Trip();
                    newargument.originName =  _startAddress;
                    newargument.destinyName =  _destinationAddress;
                    newargument.distance =  _placeDistance;
                    newargument.arrivingTime = "11:22 PM";
                    newargument.clientId = "clientId";
                    newargument.leavingTime ="11:10 PM";
                    newargument.duration = "12";
                    newargument.price = "50";
                    newargument.driverId= "driverId";
                    newargument.startPoint= startCordinates;
                    newargument.destiniPoint= endCordinates;
                    Navigator.of(context).pushNamed(
                                      CurrentTripDetailsScreen.routeName,
                                      arguments:newargument);
                    },
                    
                  child: Text('Todo listo'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryColor
                  ),
                  ),
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    surfaceTintColor: Colors.black,
                    
                  ),
                  )
                  ) : Container(),
                // Show the place input fields & button for
                // showing the route
                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        width: width * 0.9,
                        
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'CUAL SERA NUESTRO DESTINO?',
                                  style: TextStyle(fontSize: 19.0, 
                                  color: Colors.black, 
                                  fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                
                                _textField(
                                    label: _startAddress.isEmpty ? "Seleccione punto de salida?" : "",
                                    hint: 'Seleccione punto de salida',
                                    prefixIcon: Icon(Icons.looks_one, color: AppColors.primaryColor, ),
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.my_location),
                                      onPressed: () {
                                        startAddressController.text = _currentAddress;
                                        _startAddress = _currentAddress;
                               
                                      },
                                    ),
                                    
                                    controller: startAddressController,
                                    focusNode: startAddressFocusNode,
                                    width: width,
                                    locationCallback: (String value) {
                                      setState(() {
                                        _startAddress = value;
                                      });
                                    }),
                                SizedBox(height: 10),
                                _textField(
                                    
                                    label: _destinationAddress.isEmpty ? "Hacia donde vamos?" : "",
                                    hint: 'Seleccione el destino',
                                    prefixIcon: Icon(Icons.looks_two, color: AppColors.primaryColor, ),
                                    controller: destinationAddressController,
                                    focusNode: desrinationAddressFocusNode,
                                    suffixIcon: _destinationAddress == ''? 
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          destinationAddressController.clear();
                                         _destinationAddress = '';
                                         showPredictionContainer = false;
                                        });

                                      },
                                      child: Icon(Icons.my_location)
                                    ): 
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          destinationAddressController.clear();
                                         _destinationAddress = '';
                                         showPredictionContainer = false;
                                        });

                                      },
                                      child: Icon(Icons.delete)),
                                    width: width,
                                    locationCallback: (String value) {
                                      // if(destinationAddressController.text == ''){
                                      //   showPredictionContainer = false;
                                        
                                      // }else{
                                      //   showPredictionContainer = true;
                                      // }
                                      destinationAddressController.text ==''? showPredictionContainer = false : showPredictionContainer = true;
                                      
                                      setState(() {
                                        placeAutoComplete(value);
                                        _destinationAddress = value;
                                        _placeDistance == '';
                                      });
                                    }),
                                SizedBox(height: 10),
                                Visibility(
                                  visible: _placeDistance == "" ? false : true,
                                  child: _placeDistance == null ? 
                                  Text(  
                                    'DISTANCIA: Calculando...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ) :
                                  Text(  
                                    'DISTANCIA: $_placeDistance km',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                               
                               Visibility(
                                  visible: showPredictionContainer == false? false : true,
                                  child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.4,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: placesPredictions.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return LocationListTile(
                                  press: () {
                                    destinationAddressController.text = placesPredictions[index].description!;
                                    _destinationAddress = placesPredictions[index].description!;
                                    FocusScope.of(context).unfocus();

                                    setState(() {
                                      showPredictionContainer = false;
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                  location: placesPredictions[index].description!,
                                );
                                  },
                                ),
                                ),
                                ),
                                
                                SizedBox(height: 5,),
                                ElevatedButton(
                                  onPressed: (_startAddress != '' &&
                                          _destinationAddress != '')
                                      ? () async {
                                          startAddressFocusNode.unfocus();
                                          desrinationAddressFocusNode.unfocus();
                                          setState(() {
                                            if (markers.isNotEmpty) markers.clear();
                                            if (polylines.isNotEmpty)
                                              polylines.clear();
                                            if (polylineCoordinates.isNotEmpty)
                                              polylineCoordinates.clear();
                                            _placeDistance = null;
                                          });
                                          _calculateDistance().then((isCalculated) {
                                            if (isCalculated) {
                                              showBottom = true;
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(
                                              //   SnackBar(
                                              //     content: Text(
                                              //         'Distance Calculated Sucessfully'),
                                              //   ),
                                              // );
                                            } 
                                            else {
                                              showBottom = false;
                                            //   ScaffoldMessenger.of(context)
                                            //       .showSnackBar(
                                            //     SnackBar(
                                            //       content: Text(
                                            //           'Error Calculating Distance'),
                                            //     ),
                                                
                                            //   ); 
                                            }
                                            // Trip newTrip = Trip();
                                            // newTrip.originName =  _startAddress;
                                            // newTrip.destinyName =  _destinationAddress;
                                            // newTrip.distance =  _placeDistance;
                                            // newTrip.arrivingTime = "7:40";
                                            // newTrip.clientId = "6b29fc40-ca47-1067-b31d-00dd010662da";
                                            // newTrip.leavingTime ="7:20";
                                            // newTrip.duration = "20";
                                            // newTrip.price = "50";
                                            // newTrip.driverId= "6b29fc40-ca47-1067-b31d-00dd010662da";
                            
                                            // final getTrip = Provider.of<TripProvider>(context, listen: false);
                                            
                                            //   getTrip.createTrip(newTrip);
                            
                                            //   print(_destinationAddress);
                                              
                                          });
                                          
                                        }
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Vamonos'.toUpperCase(),
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 20.0,
                                        
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Show current location button
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      child: ClipOval(
                        child: Material(
                          color: AppColors.primaryColor, // button color
                          child: InkWell(
                            splashColor: AppColors.secundaryColor, // inkwell color
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(Icons.my_location),
                            ),
                            onTap: () {
                              mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      _currentPosition.latitude,
                                      _currentPosition.longitude,
                                    ),
                                    zoom: 18.0,
                                  ),
                                ),
                              );
                              _getCurrentLocation();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        
           },
          ),
      ),
    );
  }


}