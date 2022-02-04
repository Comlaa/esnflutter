import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String route;
  String endpoint;
  String basicAuth = "";

  ApiService({
    required this.route,
    required this.endpoint,
  });

  static Future<Response> getWithUserId(String route, String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getInt('id');
    var basicAuth = await prefs.getString('basicAuth');
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8012/$route/$endpoint?userId=' +
            userId.toString()),
        headers: <String, String>{HttpHeaders.authorizationHeader: basicAuth!});

    return response;
  }

  static Future<Response> get(String route, String endpoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var basicAuth = await prefs.getString('basicAuth');
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8012/$route/$endpoint'),
        headers: <String, String>{HttpHeaders.authorizationHeader: basicAuth!});

    return response;
  }
}
