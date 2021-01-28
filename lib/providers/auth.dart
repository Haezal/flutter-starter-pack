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
    // Api api = new Api();
    // String endPoint = 'auth/login';
    //
    // final response = api.postAsync(endPoint, loginData);
    var response;
    if (username == 'test@test.com' && password == 'password') {
      response = {
        "success": true,
        "message": "Login successfully!!",
        "user": {
          "user_id":"myUserId",
          "name":"Examle User Fullname",
          "email":"example@domain.com",
          "token":"token",
        },
      };
    }
    else {
      response = {
        "success":false,
        "message": 'Invalid username and password',
      };
    }


    await Future.delayed(const Duration(seconds: 1));

    if (response['success'] == true) {
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      User authUser = User.fromJson(response['user']);

      UserPreferences().saveUser(authUser);

      result = {
        "success":true,
        "message":response['message'],
        "user":authUser,
      };
    }
    else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();

      result = {
        "success":false,
        "message":response['message'],
      };
    }

    return result;
  }

  Future<bool> logout() async {
    UserPreferences().removeUser();

    return true;
  }
}
