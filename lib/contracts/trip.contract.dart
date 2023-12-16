import 'package:mvoy/models/credentials.dart';
import 'package:mvoy/models/driver.dart';
import 'package:mvoy/models/processResponse.dart';
import 'package:mvoy/models/trip.dart';

abstract class TripContract {
  Future<ProcessResponse> createTrip (Trip tripInfo);
  Future<ProcessResponse> makeOffer(String tripId, String offerID, bool isDriveroffering, );
  Future<ProcessResponse> acceptOffer(Trip tripInfo,String offerID);
  Future<ProcessResponse> cancelTrip (String tripId);
}

