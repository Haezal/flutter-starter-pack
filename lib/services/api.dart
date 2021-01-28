import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../config/constants.dart';

class Api {
  String baseUrl;
  int version;

  Api({this.baseUrl = Constants.API_URL, this.version = 1});

  /// GET METHOD
  Future<dynamic> getAsync(String endPoint) async {
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
      };
      String url = baseUrl + endPoint;
      print('URL : ' + url);
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('${response.statusCode} : Error occurred during calling web service');
      }
    } on TimeoutException catch (e) {
      throw TimeoutException('Timeout exception : $endPoint');
    }
    on Exception catch (e) {
      throw Exception('Error Exception ${ e.toString()}');
    }
  }

  /// POST METHOD
  Future<dynamic> postAsync(String endPoint, Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
      };
      String url = baseUrl + endPoint;
      print('URL : ' + url);
      final response = await http.post(url, body: json.encode(body), headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('${response.statusCode} : Error occurred during calling web service');
      }
    } on TimeoutException catch (e) {
      throw TimeoutException('Timeout exception : $endPoint');
    }
    on Exception catch (e) {
      throw Exception('Error Exception ${ e.toString()}');
    }
  }
}
