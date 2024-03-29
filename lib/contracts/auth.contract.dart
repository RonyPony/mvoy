import 'package:mvoy/models/loginResponse.dart';

import '../models/credentials.dart';
import '../models/dominicanPerson.dart';
import '../models/mvoyUser.dart';
import '../models/processResponse.dart';

abstract class AuthContract {
  Future<bool> isUserAuthenticated();
  Future<DominicanPerson> getPersonInfoByCedula(String cedula);
  // Future<User> getCurrentUser();
  Future<MvoyUser> registeruser(MvoyUser info, Credentials credentials);
  Future<LoginResponse> signin(Credentials info);
  Future<bool> verifyUserEmail(String email);
  Future<bool> signout();
}
