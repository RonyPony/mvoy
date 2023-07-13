import '../models/dominicanPerson.dart';
import '../models/processResponse.dart';

abstract class AuthContract {
  Future<bool> isUserAuthenticated();
  Future<DominicanPerson> getPersonInfoByCedula(String cedula);
  // Future<User> getCurrentUser();
  // Future<ProcessResponse> registeruser(Credentials info);
  // Future<ProcessResponse> signin(Credentials info);
  Future<bool> verifyUserEmail(String email);
  Future<bool> signout();
}
