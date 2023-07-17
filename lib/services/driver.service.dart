import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvoy/contracts/driver.contract.dart';
import 'package:mvoy/models/driver.dart';
import 'package:mvoy/models/vehicle.dart';
import 'package:http/http.dart' as http;

class DriverService implements DriverContract {
  @override
  Future<bool> registerVehicle(MvoyDriver driver) async {
    MvoyVehicle dataResponse = MvoyVehicle();
    try {
      Response? response;
      response = await http.post(
        Uri.parse("http://23.19.226.29/api/Vehicle"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'ownerId': driver.user!.id!,
          'license': driver.vehicle!.license!,
          'seguro': driver.vehicle!.seguro!,
          'chasis': driver.vehicle!.chasis!,
          'placa': driver.vehicle!.placa!,
          'color': driver.vehicle!.color!,
          'marca': driver.vehicle!.marca!,
          'modelo': driver.vehicle!.modelo!,
          'tieneSeguro': driver.vehicle!.tieneSeguro!.toString(),
          'year': driver.vehicle!.year!
        }),
      );
      if (response.statusCode == 200) {
        dataResponse = MvoyVehicle.fromJson(jsonDecode(response.body));
        return dataResponse.Id != null;
      } else {
        if (response.statusCode == 404) {
          return false;
        } else {
          return false!;
        }
      }
    } catch (e) {
      print(e.toString());
      return false!;
    }
  }
}
