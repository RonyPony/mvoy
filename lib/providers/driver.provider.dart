import 'package:flutter/material.dart';
import 'package:mvoy/contracts/driver.contract.dart';
import 'package:mvoy/models/vehicle.dart';

import '../models/driver.dart';

class DriverProvider with ChangeNotifier {
  DriverContract _contract;
  DriverProvider(this._contract);
  Future<bool> registerVehicle(MvoyDriver vehicle) async {
    final result = await _contract.registerVehicle(vehicle);
    return result;
  }
}
