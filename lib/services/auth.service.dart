import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvoy/contracts/auth.contract.dart';
import 'package:mvoy/models/credentials.dart';
import 'package:mvoy/models/dominicanPerson.dart';
import 'package:http/http.dart' as http;
import 'package:mvoy/models/loginResponse.dart';
import 'package:mvoy/models/mvoyUser.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mvoy/models/processResponse.dart';
import 'package:mvoy/providers/currentUser.provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService implements AuthContract {
  @override
  Future<DominicanPerson> getPersonInfoByCedula(String cedula) async {
    DominicanPerson? dataResponse;
    try {
      Response? response;
      response =
          await http.get(Uri.parse("http://69.197.150.152:8066/cedula/$cedula"));
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
        Uri.parse('http://69.197.150.152:8043/api/user'),
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
          Uri.parse('http://69.197.150.152:8043/api/user/login'),
          headers: <String, String>{
            'Content-Type': 'application/json', 
          },
          body: jsonEncode(<String, String>{
            'email': info.email!,
          'password': info.password!
          }));
      if (response.statusCode == 200) {
        dataResponse = LoginResponse.fromJson(jsonDecode(response.body));
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var jwtData = dataResponse.result;  
        Map<String, dynamic>? decodedToken = JwtDecoder.decode(jwtData!);
        prefs.setString("userId", decodedToken['id']);
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
      return dataResponse;
    }
  }
                  
  @override
Future<MvoyUser> getCurrentUser(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? id = prefs.getString('userId');

  try {
    Response response = await http.get(Uri.parse('http://69.197.150.152:8043/api/user/$id'));
    if (response.statusCode == 200) {
      MvoyUser dataResponse = MvoyUser.fromJson(json.decode(response.body));
      Provider.of<UserProvider>(context, listen: false).setCurrentUser(dataResponse);
      return dataResponse;
    } else if (response.statusCode == 400) {
      throw Exception('Error de solicitud: ${response.statusCode}');
    }
    return MvoyUser(); // En caso de error, devolver un usuario vacío
  } catch (e) {
    print('Error en la solicitud: $e');
    throw Exception('No se pudo obtener la información del usuario');
  }
}

//   Future<MvoyUser> getCurrentUser(BuildContext context) async {
//   MvoyUser dataResponse = MvoyUser(); 
//   // final setUser =  Provider.of<UserProvider>(context, listen: false);
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? id = prefs.getString('userId');
//   // // prefs.setString('userId', "790691a5-6cbb-41a0-c0e3-08dc0da1b818");
//   // final String id = "0fb828c2-6348-4743-b190-08dc3a36e525";
//   try {
//     Response response = await http.get(Uri.parse('http://69.197.150.152:8043/api/user/$id'));
//     if (response.statusCode == 200) {
//       // Provider.of<UserProvider>(context, listen: false).setCurrentUser(dataResponse);
//       dataResponse = MvoyUser.fromJson(json.decode(response.body));
//     } else if (response.statusCode == 400) {
//       throw Exception('Error de solicitud: ${response.statusCode}');
//     }
//     return dataResponse;
//   } catch (e) {
//     print('Error en la solicitud: $e');
//     throw Exception('No se pudo obtener la información del usuario');
//   }
  
// }



}