import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/models/vehicle.dart';

class MvoyDriver {
  MvoyUser? user;
  MvoyVehicle? vehicle;

  MvoyDriver({this.user, this.vehicle});

  MvoyDriver.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    vehicle = json['vehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['vehicle'] = this.vehicle;
    return data;
  }
}
