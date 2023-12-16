import 'package:flutter/material.dart';
import 'package:mvoy/contracts/trip.contract.dart';
import 'package:mvoy/models/processResponse.dart';
import 'package:mvoy/models/trip.dart';

class TripProvider extends ChangeNotifier{
  TripContract _contract;
  TripProvider(this._contract);

  Future<ProcessResponse> createTrip (Trip tripInfo) async {
    final result = await _contract.createTrip(tripInfo);
    return result;
  }

  Future<ProcessResponse> makeOffer(String tripId, String offerID, bool isDriveroffering) async {
    final result = await _contract.makeOffer(tripId,offerID,isDriveroffering);
    return result;
  }
  Future<ProcessResponse> acceptOffer(Trip tripInfo,String offerID) async {
    final result = await _contract.acceptOffer(tripInfo,offerID);
    return result;
  }
  Future<ProcessResponse> cancelTrip (String tripId) async {
    final result = await _contract.cancelTrip(tripId);
    return result;
  }
}