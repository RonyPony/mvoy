import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvoy/models/autocomplate_prediction.dart';
import 'package:mvoy/models/place_auto_complate_response.dart';
import 'package:mvoy/services/googleMaps.service.dart';

class MapProvider extends ChangeNotifier {
  // List de auto completado
  List<AutocompletePrediction> placesPredictions = [];
  bool showPredictionContainer = false; 

  // AutoComplete logic

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
            placesPredictions = result.predictions!;
            notifyListeners();
        }
      }
  }

  // Maps controllers
  late GoogleMapController mapController;
  CameraPosition initialLocation = CameraPosition(target: LatLng(25.0762804,54.8978121));
  static const API_KEY = 'AIzaSyCY47HTgLpdMDimZ49YdWqzWk-rt5UI3jA';

  var _darkMapStyle;
  bool showZoomControl = false;
  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_darkMapStyle);
    mapController = controller;
  }


  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_dark_style.json');
  }

  

  Future<Position> determinePosition() async {
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