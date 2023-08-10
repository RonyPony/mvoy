import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvoy/contracts/driver.contract.dart';
import 'package:mvoy/models/credentials.dart';
import 'package:mvoy/models/driver.dart';
import 'package:mvoy/models/loginResponse.dart';
import 'package:mvoy/models/processResponse.dart';
import 'package:mvoy/models/vehicle.dart';
import 'package:http/http.dart' as http;

class DriverService implements DriverContract {
  @override
  Future<ProcessResponse> registerVehicle(MvoyDriver driver) async {
    MvoyVehicle dataResponse = MvoyVehicle();
    try {
      Response? response;
      response = await http.post(
        Uri.parse("http://23.19.226.29/api/Vehicle"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'ownerId': driver.user!.id!,
          'license': driver.vehicle!.license!,
          'seguro': driver.vehicle!.seguro!,
          'chasis': driver.vehicle!.chasis!,
          'placa': driver.vehicle!.placa!,
          'color': driver.vehicle!.color!,
          'marca': driver.vehicle!.marca!,
          'modelo': driver.vehicle!.modelo!,
          'tieneSeguro': driver.vehicle!.tieneSeguro!,
          'year': driver.vehicle!.year!
        }),
      );
      if (response.statusCode == 200) {
        dataResponse = MvoyVehicle.fromJson(jsonDecode(response.body));
        ProcessResponse result =
            ProcessResponse(dataResponse.Id != null, response.body);
        return result;
      } else {
        if (response.statusCode == 404) {
          ProcessResponse result = ProcessResponse(false, response.body);
          return result;
        } else {
          ProcessResponse result = ProcessResponse(false, response.body);
          return result;
        }
      }
    } catch (e) {
      print(e.toString());
      ProcessResponse result = ProcessResponse(false, e.toString());
      return result;
    }
  }

  @override
  Future<ProcessResponse> registerVehicleWithCredentials(
      MvoyDriver driver, Credentials credentials) async {
    MvoyVehicle dataResponse = MvoyVehicle();
    try {
      Response? response;
      String token = "";
      Response tokenRequest =
          await http.post(Uri.parse("http://23.19.226.29/api/user/login"),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: jsonEncode(<String, dynamic>{
                'email': credentials.email,
                'password': credentials.password,
              }));
      if (tokenRequest.statusCode == 200) {
        LoginResponse response =
            LoginResponse.fromJson(jsonDecode(tokenRequest.body));
        if (response.success!) {
          token = response.result!;
        }
      }
      response = await http.post(
        Uri.parse("http://23.19.226.29/api/Vehicle"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
        body: jsonEncode(<String, dynamic>{
          'ownerId': driver.user!.id!,
          'license': driver.vehicle!.license!,
          'seguro': driver.vehicle!.seguro!,
          'chasis': driver.vehicle!.chasis!,
          'placa': driver.vehicle!.placa!,
          'color': driver.vehicle!.color!,
          'marca': driver.vehicle!.marca!,
          'modelo': driver.vehicle!.modelo!,
          'tieneSeguro': driver.vehicle!.tieneSeguro!,
          'year': driver.vehicle!.year!
        }),
      );
      if (response.statusCode == 200) {
        dataResponse = MvoyVehicle.fromJson(jsonDecode(response.body));
        ProcessResponse result =
            ProcessResponse(dataResponse.Id != null, response.body);
        return result;
      } else {
        if (response.statusCode == 404) {
          ProcessResponse result = ProcessResponse(false, response.body);
          return result;
        } else {
          ProcessResponse result = ProcessResponse(false, response.body);
          return result;
        }
      }
    } catch (e) {
      print(e.toString());
      ProcessResponse result = ProcessResponse(false, e.toString());
      return result;
    }
  }
}
