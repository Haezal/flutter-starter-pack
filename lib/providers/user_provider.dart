import 'package:flutter/material.dart';
import 'package:starterpack/config/config.dart';
import '../models/models.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();
  User get user => _user;

  void setUser(User user) async{
    _user = user;
    // notifyListeners();
  }
}