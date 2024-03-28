import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvoy/models/autocomplate_prediction.dart';
import 'package:mvoy/models/coordinates.dart';
import 'package:mvoy/models/place_auto_complate_response.dart';
import 'package:mvoy/models/trip.dart';
import 'package:mvoy/providers/map.provider.dart';
import 'package:mvoy/providers/trip.provider.dart';
import 'package:mvoy/screens/currentTripDetails/CurrentTripsDetailsScreen.dart';
import 'package:mvoy/services/googleMaps.service.dart';

import 'dart:math' show cos, sqrt, asin;

import 'package:mvoy/widgets/colors.dart';
import 'package:mvoy/widgets/location_list_tile.dart';
import 'package:mvoy/widgets/map.TextField.dart';
import 'package:provider/provider.dart';

class MyMapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MyMapView> {

    final _scaffoldKey = GlobalKey<ScaffoldState>();
  

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
          builder: (BuildContext context, controller, _) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  // Map View
                  GoogleMap(
                    markers: Set<Marker>.from(controller.markers),
                    initialCameraPosition: controller.initialLocation,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    polylines: Set<Polyline>.of(controller.polylines.values),
                    onMapCreated: controller.onMapCreated,
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
                                  splashColor:
                                      AppColors.secundaryColor, // inkwell color
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.add),
                                  ),
                                  onTap: () {
                                    controller.mapController.animateCamera(
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
                                  splashColor:
                                      AppColors.secundaryColor, // inkwell color
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.remove),
                                  ),
                                  onTap: () {
                                    controller.mapController.animateCamera(
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
                  controller.showBottom
                      ? Positioned(
                          left: MediaQuery.of(context).size.width * .35,
                          bottom: 24,
                          child: ElevatedButton(
                            onPressed: () {
                              Trip newTrip = Trip();
                              newTrip.originName = controller.startAddress;
                              newTrip.destinyName = controller.destinationAddress;
                              newTrip.distance = controller.placeDistance;
                              newTrip.arrivingTime = "7:40";
                              newTrip.clientId =
                                  "6b29fc40-ca47-1067-b31d-00dd010662da";
                              newTrip.leavingTime = "7:20";
                              newTrip.status = 0;
                              newTrip.duration = "20";
                              newTrip.price = "50";
                              newTrip.driverId =
                                  "6b29fc40-ca47-1067-b31d-00dd010662da";

                              final getTrip = Provider.of<TripProvider>(context,
                                  listen: false);

                              getTrip.createTrip(newTrip);

                              Navigator.of(context).pushNamed(
                                  CurrentTripDetailsScreen.routeName,
                                  arguments: newTrip);
                            },
                            child: Text(
                              'Todo listo'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20, color: AppColors.primaryColor),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              surfaceTintColor: Colors.black,
                            ),
                          ))
                      : Container(),
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
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'CUAL SERA NUESTRO DESTINO?',
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  MapTextField(
                                      label: controller.startAddress.isEmpty
                                          ? "Seleccione punto de salida?"
                                          : "",
                                      hint: 'Seleccione punto de salida',
                                      prefixIcon: Icon(
                                        Icons.looks_one,
                                        color: AppColors.primaryColor,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.my_location),
                                        onPressed: () {
                                          controller.startAddressController.text =
                                              controller.currentAddress;
                                          controller.startAddress = controller.currentAddress;
                                        },
                                      ),
                                      controller: controller.startAddressController,
                                      focusNode: controller.startAddressFocusNode,
                                      width: width,
                                      locationCallback: (String value) {
                                        setState(() {
                                          controller.startAddress = value;
                                        });
                                      }),
                                  SizedBox(height: 10),
                                  MapTextField(
                                      label: controller.destinationAddress.isEmpty
                                          ? "Hacia donde vamos?"
                                          : "",
                                      hint: 'Seleccione el destino',
                                      prefixIcon: Icon(
                                        Icons.looks_two,
                                        color: AppColors.primaryColor,
                                      ),
                                      controller: controller.destinationAddressController,
                                      focusNode: controller.desrinationAddressFocusNode,
                                      suffixIcon: controller.destinationAddress == ''
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  controller.destinationAddressController
                                                      .clear();
                                                  controller.destinationAddress = '';
                                                  controller.showPredictionContainer =
                                                      false;
                                                });
                                              },
                                              child: Icon(Icons.my_location))
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  controller.destinationAddressController
                                                      .clear();
                                                  controller.destinationAddress = '';
                                                  controller.showPredictionContainer =
                                                      false;
                                                });
                                              },
                                              child: Icon(Icons.delete)),
                                      width: width,
                                      locationCallback: (String value) {
                                        controller.destinationAddressController.text == ''
                                            ? controller.showPredictionContainer = false
                                            : controller.showPredictionContainer = true;
                                        setState(() {
                                          controller.placeAutoComplete(value);
                                          controller.destinationAddress = value;
                                          controller.placeDistance == '';
                                        });
                                      }),
                                  SizedBox(height: 10),
                                  Visibility(
                                    visible:
                                        controller.placeDistance == "" ? false : true,
                                    child: controller.placeDistance == null
                                        ? Text(
                                            'DISTANCIA: Calculando...',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Text(
                                            'DISTANCIA: ${(controller.placeDistance)} km',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                  SizedBox(height: 5),
                                  Visibility(
                                    visible: controller.showPredictionContainer == false
                                        ? false
                                        : true,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            controller.placesPredictions.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return LocationListTile(
                                            press: () {
                                              controller.destinationAddressController
                                                      .text =
                                                  controller.placesPredictions[index]
                                                      .description!;
                                              controller.destinationAddress = controller
                                                  .placesPredictions[index]
                                                  .description!;
                                              FocusScope.of(context).unfocus();

                                              setState(() {
                                                controller.showPredictionContainer = false;
                                                FocusScope.of(context)
                                                    .unfocus();
                                              });
                                            },
                                            location: controller
                                                .placesPredictions[index]
                                                .description!,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: (controller.startAddress != '' &&
                                            controller.destinationAddress != '')
                                        ? () async {
                                            controller.startAddressFocusNode.unfocus();
                                            controller.desrinationAddressFocusNode
                                                .unfocus();
                                            setState(() {
                                              if (controller.markers.isNotEmpty)
                                                controller.markers.clear();
                                              if (controller.polylines.isNotEmpty)
                                                controller.polylines.clear();
                                              if (controller.polylineCoordinates
                                                  .isNotEmpty)
                                                controller.polylineCoordinates.clear();
                                              controller.placeDistance = null;
                                            });
                                            controller.calculateDistance()
                                                .then((isCalculated) {
                                              if (isCalculated) {
                                                controller.showBottom = true;
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   SnackBar(
                                                //     content: Text(
                                                //         'Distance Calculated Sucessfully'),
                                                //   ),
                                                // );
                                              } else {
                                                controller.showBottom = false;
                                                //   ScaffoldMessenger.of(context)
                                                //       .showSnackBar(
                                                //     SnackBar(
                                                //       content: Text(
                                                //           'Error Calculating Distance'),
                                                //     ),

                                                //   );
                                              }

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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                        padding:
                            const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        child: ClipOval(
                          child: Material(
                            color: AppColors.primaryColor, // button color
                            child: InkWell(
                              splashColor:
                                  AppColors.secundaryColor, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.my_location),
                              ),
                              onTap: () {
                                controller.mapController.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                        controller.currentPosition.latitude,
                                        controller.currentPosition.longitude,
                                      ),
                                      zoom: 18.0,
                                    ),
                                  ),
                                );
                                controller.getCurrentLocation();
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
