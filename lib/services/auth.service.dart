import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:mvoy/contracts/auth.contract.dart';
import 'package:mvoy/models/dominicanPerson.dart';
import 'package:http/http.dart' as http;
import 'package:mvoy/models/mvoyUser.dart';
import 'package:mvoy/models/processResponse.dart';

class AuthService implements AuthContract {
  @override
  Future<DominicanPerson> getPersonInfoByCedula(String cedula) async {
    DominicanPerson? dataResponse;
    try {
      Response? response;
      response =
          await http.get(Uri.parse("http://23.19.226.29:8020/Cedula/$cedula"));
      if (response.statusCode == 200) {
        dataResponse = DominicanPerson.fromJson(jsonDecode(response.body));
        return dataResponse;
      } else {
        if (response.statusCode == 404) {
          dataResponse = DominicanPerson();
          return dataResponse;
        } else {
          return dataResponse!;
        }
      }
    } catch (e) {
      print(e.toString());
      return dataResponse!;
    }
  }

  @override
  Future<bool> isUserAuthenticated() {
    // TODO: implement isUserAuthenticated
    throw UnimplementedError();
  }

  @override
  Future<bool> signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }

  @override
  Future<bool> verifyUserEmail(String email) {
    // TODO: implement verifyUserEmail
    throw UnimplementedError();
  }

  @override
  Future<ProcessResponse> registeruser(MvoyUser info) async {
    ProcessResponse finalData = ProcessResponse(false, "process not completed");
    MvoyUser? dataResponse;
    Map<String, dynamic> data = info.toJson();
    try {
      Response? response;
      Uri addr = Uri.parse('http://23.19.226.29/api/user');
      response = await http.post(
        Uri.parse('http://23.19.226.29/api/user'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'cedula': info.cedula!,
          'email': info.email!,
          'name': info.name!,
          'middleName': info.middleName!,
          'lastname1': info.lastname!,
          'lastname2': info.lastname2!,
          'birthDate': info.birthDate!,
          'gender': info.gender!,
          'phoneNumber': info.phone!,
          'address': info.direccion!,
          'relativeName': info.relativeName!,
          'relativePhoneNumber': info.relativeNumber!
        }),
      );
      if (response.statusCode == 200) {
        dataResponse = MvoyUser.fromJson(jsonDecode(response.body));
        finalData.success = true;
        finalData.errorMessage = "Usuario Creado";
        return finalData;
      } else {
        if (response.statusCode == 404) {
          finalData.success = false;
          finalData.errorMessage =
              "Favor valida la informacion e intentalo luego.";
          return finalData;
        } else {
          finalData.success = false;
          print(response.body);
          finalData.errorMessage =
              "Error al intentar registrarte, intentalo luego";
          return finalData;
        }
      }
    } catch (e) {
      finalData.success = false;
      //TODO fix exception message
      finalData.errorMessage = e.toString();
      return finalData;
    }
  }
}