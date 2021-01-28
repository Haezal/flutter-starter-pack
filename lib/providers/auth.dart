import 'package:flutter/material.dart';
import 'package:starterpack/config/config.dart';
import 'package:starterpack/models/models.dart';
import 'package:starterpack/services/services.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
}

class AuthProvider with ChangeNotifier {
  AuthService authService = new AuthService();

  // initial declaration
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String username, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password,
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    // calling webservices
    var response = await authService.login(loginData);

    if (response['status'] == true) {
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      /// key data is come from backend data structure
      /// is depend your data response
      User authUser = User.fromJson(response['data']);

      UserPreferences().saveUser(authUser);

      result = {
        "success": true,
        "message": response['message'],
        "user": authUser,
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();

      result = {
        "success": false,
        "message": response['message'],
      };
    }

    return result;
  }

  Future<bool> logout() async {
    UserPreferences().removeUser();

    return true;
  }
}
