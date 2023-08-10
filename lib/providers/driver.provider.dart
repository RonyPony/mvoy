import 'package:flutter/material.dart';
import 'package:mvoy/contracts/driver.contract.dart';
import 'package:mvoy/models/credentials.dart';
import 'package:mvoy/models/processResponse.dart';
import 'package:mvoy/models/vehicle.dart';

import '../models/driver.dart';

class DriverProvider with ChangeNotifier {
  DriverContract _contract;
  DriverProvider(this._contract);
  Future<ProcessResponse> registerVehicle(MvoyDriver vehicle) async {
    final result = await _contract.registerVehicle(vehicle);
    return result;
  }

  Future<ProcessResponse> registerVehicleWithCredentials(
      MvoyDriver vehicle, Credentials credentials) async {
    final result =
        await _contract.registerVehicleWithCredentials(vehicle, credentials);
    return result;
  }
}
