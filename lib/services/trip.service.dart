import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvoy/contracts/trip.contract.dart';
import 'package:mvoy/models/driver.dart';
import 'package:mvoy/models/processResponse.dart';
import 'package:mvoy/models/trip.dart';
import 'package:mvoy/services/driver.service.dart';

class TripService implements TripContract {
  @override
  Future<ProcessResponse> acceptOffer(Trip tripInfo, String offerID) {
    // TODO: implement acceptOffer
    throw UnimplementedError();
  }

  @override
  Future<ProcessResponse> cancelTrip(String tripId) {
    // TODO: implement cancelTrip
    throw UnimplementedError();
  }

  @override
  Future<ProcessResponse> createTrip(Trip tripInfo) async {
    ProcessResponse dataResponse = ProcessResponse(success:false,errorMessage: "");
    try {
      http.Response? response;
      response = await http.post(
          Uri.parse('http://69.197.150.152:8043/api/trip'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{         
            'originName': tripInfo.originName!,
            'destinyName': tripInfo.destinyName!,
            'duration': tripInfo.duration!,
            'distance': tripInfo.distance!,
            'statusTrip': tripInfo.status!,
            'leavingTime': tripInfo.leavingTime!,
            'driverId': tripInfo.driverId!,
            'clientId': tripInfo.clientId!,
            'price': tripInfo.price!,
            'arrivingTime': tripInfo.arrivingTime!
          }));

      if (response.statusCode == 200) {
        Trip finalTrip = Trip.fromJson(jsonDecode(response.body));
        dataResponse.success = true;
        dataResponse.errorMessage = response.body;
        return dataResponse;
      } else {
        if (response.statusCode == 404) {
          return dataResponse;
        } else {
          dataResponse.success = false;
          dataResponse.errorMessage="error";
          return dataResponse;
        }
      }
    } catch (e) {
      print(e.toString());
      return dataResponse!;
    }
  }

  @override
  Future<ProcessResponse> makeOffer(String tripId, String offerID, bool isDriveroffering) async {
    ProcessResponse dataResponse = ProcessResponse(success:false,errorMessage: "");
    try {
      http.Response? response;
      response = await http.post(
          Uri.parse('http://69.197.150.152:8043/api/trip'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
            
          body: jsonEncode(<String, String>{        

              // "clientId":  ,
              // "tripId": ,
              // "motorcycleUserId": ,
              // "price": ,

          }));

      if (response.statusCode == 200) {
        Trip finalTrip = Trip.fromJson(jsonDecode(response.body));
        dataResponse.success = true;
        dataResponse.errorMessage = response.body;
        return dataResponse;
      } else {
        if (response.statusCode == 404) {
          return dataResponse;
        } else {
          dataResponse.success = false;
          dataResponse.errorMessage="error";
          return dataResponse;
        }
      }
    } catch (e) {
      print(e.toString());
      return dataResponse!;
    }
  }
  
  @override
  Future<ProcessResponse> updateTrip(String tripId) {
    // TODO: implement updateTrip
    throw UnimplementedError();
  }
  
  @override
  Future<List<Trip>> getAllHistoricalTrips() {
    // TODO: implement getAllHistoricalTrips
    throw UnimplementedError();
  }

  }
  
