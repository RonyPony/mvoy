import 'package:flutter/material.dart';
import 'package:mvoy/contracts/auth.contract.dart';

import '../models/dominicanPerson.dart';

class AuthProvider with ChangeNotifier {
  AuthContract _contract;

  AuthProvider(this._contract);

  Future<bool> isUserAuthenticated() async {
    final result = await _contract.isUserAuthenticated();
    return result;
  }

  Future<DominicanPerson> getPersonInfoByCedula(String cedula) async {
    final result = await _contract.getPersonInfoByCedula(cedula);
    return result;
  }

  // Future<User> getCurrentUser()async{
  //   final result = await _contract.getCurrentUser();
  //   return result;
  // }

  // Future<ProcessResponse> registerUser(Credentials info)async{
  //   final result = await _contract.registerUser(info);
  //   return result;
  // }
  // Future<ProcessResponse> signin(Credentials info)async{
  //   final result = await _contract.signin(info);
  //   return result;
  // }
  Future<bool> verifyUserEmail(String email) async {
    final result = await _contract.verifyUserEmail(email);
    return result;
  }

  Future<bool> signout() async {
    final result = await _contract.signout();
    return result;
  }
}
