import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvoy/mapa/mapStyles.dart';
import 'package:mvoy/models/autocomplate_prediction.dart';
import 'package:mvoy/models/coordinates.dart';
import 'package:mvoy/models/place_auto_complate_response.dart';
import 'package:mvoy/services/googleMaps.service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mvoy/models/trip.dart';

import 'dart:math' show cos, sqrt, asin;



class MapProvider extends ChangeNotifier {




 
//   Position? currentPosition;

//   Map<MarkerId, Marker> markers ={};

//   Set<Marker> get Markers => markers.values.toSet();

//   final initialCameraPosition = CameraPosition(target: LatLng(18.4808386,-70.0234465),);

//    onMapCreated(GoogleMapController controller) {
//     controller.setMapStyle(darkMapString);
//     notifyListeners();
//   }
//   _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         _currentPosition = position;
//         print('Posicion actual: $_currentPosition');
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 18.0,
//             ),
//           ),
//         );
//       });
//       await _getAddress();
//     }).catchError((e) {
//       print(e);
//     });
//   }


//   // set markers on map (will be removed)
//   void onTap (LatLng position){
//     final markerId = MarkerId(markers.length.toString());
//     final marker = Marker(
//       markerId: markerId,
//       icon: BitmapDescriptor.defaultMarker,
//       position: position,
//       draggable: true,
//       onDragEnd: (value) {
//         onTap(position){
//           print(markerId.toString());
//         }
//       },
//       );
      
//       markers[markerId] = marker;
//       notifyListeners();
//   }

// void cleanMarkers(){
//   markers.clear();
//   notifyListeners();
// }


// =====================================================================================================

// Coordinates startCordinates = Coordinates(startLatitude, startLongitude);
// Coordinates endCordinates = Coordinates(destinationLatitude, destinationLongitude);

Coordinates? startCordinates;
Coordinates? endCordinates;

CameraPosition initialLocation = CameraPosition(target: LatLng(18.4808386,-70.0234465), zoom: 10);

  Trip currentTrip =Trip();
  
  late GoogleMapController mapController;
  static const API_KEY = 'AIzaSyCY47HTgLpdMDimZ49YdWqzWk-rt5UI3jA';
  late Position currentPosition;
  String currentAddress = '';
  bool showPredictionContainer = false;
  List<AutocompletePrediction> placesPredictions = [];
  void placeAutoComplete(String query) async{
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json", //undecpder path
      {"input":query,//parametro requerido por el api
      "key": API_KEY,
      "language": "es",
      "components": "country:do",
      "radius":"500"
      },
      
      ); 

      String? response = await GoogleMapServices().placeAutoComplete(uri);
      if (response != null){
        PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
        if(result.predictions != null){
         placesPredictions = result.predictions!;
        }
      }
      
      
  }

  //  onMapCreated(GoogleMapController controller) {
//     controller.setMapStyle(darkMapString);
//     notifyListeners();
//   }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(darkMapString);
    mapController = controller;
    getCurrentLocation();
  }
  // Future _loadMapStyles() async {
  //   darkMapStyle = await rootBundle.loadString('assets/map_dark_style.json');
  //   getCurrentLocation();
  // }

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String startAddress = '';
  String destinationAddress = '';
  String? placeDistance = "";
  double startLatitude = 0;
  double startLongitude = 0;
  double destinationLatitude = 0;
  double destinationLongitude = 0;

  bool showBottom = false;

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {}; 
  List<LatLng> polylineCoordinates = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  clearMap(){
    polylineCoordinates.clear();
    polylineCoordinates.clear();
  }

  // Method for retrieving the current location
  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
        currentPosition = position;
        print('Posicion actual: $currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      await getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];
        currentAddress =
            "${place.street}, ${place.locality}, ${place.postalCode} ";
        startAddressController.text = currentAddress;
        startAddress = currentAddress;
        notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = startAddress == currentAddress
          ? currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = startAddress == currentAddress
          ? currentPosition.longitude
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
          snippet: startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destino $destinationCoordinatesString',
          snippet: destinationAddress,
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

      await createPolylines(
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
        placeDistance = totalDistance.toStringAsFixed(2);
        // print('Distancia: $_placeDistance km');
      notifyListeners();

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
        notifyListeners();
    return 12742 * asin(sqrt(a));
    
  }


  // Create the polylines for showing the route between two places
  createPolylines(
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
        notifyListeners();
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
    notifyListeners();
  }

  // =======================================================


}