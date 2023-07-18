import 'package:mvoy/models/driver.dart';
import 'package:mvoy/models/processResponse.dart';
import 'package:mvoy/models/vehicle.dart';

abstract class DriverContract {
  Future<ProcessResponse> registerVehicle(MvoyDriver vehicle);
}
