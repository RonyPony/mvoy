import 'package:mvoy/models/driver.dart';
import 'package:mvoy/models/vehicle.dart';

abstract class DriverContract {
  Future<bool> registerVehicle(MvoyDriver vehicle);
}
