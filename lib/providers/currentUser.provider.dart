import 'package:flutter/material.dart';
import 'package:mvoy/models/mvoyUser.dart';

class UserProvider extends ChangeNotifier {
  MvoyUser? _currentUser;

  MvoyUser? get currentUser => _currentUser;

  void setCurrentUser(MvoyUser user) {
    _currentUser = user;
    notifyListeners();
  }

  void clearCurrentUser(MvoyUser user) {
    _currentUser = user;
    notifyListeners();
  }
}


