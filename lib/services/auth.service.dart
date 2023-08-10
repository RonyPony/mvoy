import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:mvoy/contracts/auth.contract.dart';
import 'package:mvoy/models/credentials.dart';
import 'package:mvoy/models/dominicanPerson.dart';
import 'package:http/http.dart' as http;
import 'package:mvoy/models/loginResponse.dart';
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
  Future<MvoyUser> registeruser(MvoyUser info, Credentials credentials) async {
    MvoyUser? dataResponse;
    Map<String, dynamic> data = info.toJson();
    try {
      Response? response;
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
          'relativePhoneNumber': info.relativeNumber!,
          'password': credentials.password!
        }),
      );
      if (response.statusCode == 200) {
        // info.id = r
        dataResponse = MvoyUser.fromJson(jsonDecode(response.body));

        return dataResponse;
      } else {
        if (response.statusCode == 404) {
          dataResponse = MvoyUser();
          return dataResponse;
        } else {
          print(response.body);
          dataResponse = MvoyUser();
          return dataResponse;
        }
      }
    } catch (e) {
      dataResponse = MvoyUser();
      return dataResponse;
    }
  }

  @override
  Future<LoginResponse> signin(Credentials info) async {
    LoginResponse dataResponse = LoginResponse(success: false);
    try {
      Response? response;
      response = await http.post(
          Uri.parse('http://23.19.226.29/api/user/login'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'email': info.email!,
            'password': info.password!
          }));

      if (response.statusCode == 200) {
        dataResponse = LoginResponse.fromJson(jsonDecode(response.body));
        return dataResponse;
      } else {
        if (response.statusCode == 404) {
          return dataResponse;
        } else {
          dataResponse = LoginResponse.fromJson(jsonDecode(response.body));
          return dataResponse;
        }
      }
    } catch (e) {
      print(e.toString());
      return dataResponse!;
    }
  }
}
