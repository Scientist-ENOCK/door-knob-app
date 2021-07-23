import 'dart:io';

import 'dart:convert';

import 'package:door_lock/util/service/http_service/http_service.dart';
import 'package:http/http.dart' as http;

import 'package:door_lock/models/tenant_model.dart';

class AdminLoginService {
  Future<Map<String, dynamic>> loginAdminFromHttp(
      String email, String password) async {
    try {
      Map<String, String> authData = {"email": email,"password": password};
      http.Response response = await HttpService()
          .httpPost("http://huduma-api.herokuapp.com/account/login", authData);

      Map<String, dynamic> res = json.decode(response.body);
     
      return res;
    } on Exception catch (e) {
      throw e;
    }
  }
}
