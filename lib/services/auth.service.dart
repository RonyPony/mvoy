import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvoy/contracts/auth.contract.dart';
import 'package:mvoy/models/dominicanPerson.dart';
import 'package:http/http.dart' as http;

class AuthService implements AuthContract {
  @override
  Future<DominicanPerson> getPersonInfoByCedula(String cedula) async {
    DominicanPerson? dataResponse;
    try {
      Response? response;

      try {
        response = await http
            .get(Uri.parse("http://23.19.226.29:8020/Cedula/$cedula"));
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
        print(e);
        return dataResponse!;
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
}
