import 'package:mvoy/models/driver.dart';
import 'package:mvoy/models/processResponse.dart';

abstract class DriverContract {
  Future<ProcessResponse> registerVehicle(MvoyDriver vehicle);
}
