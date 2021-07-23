import 'dart:io';

import 'dart:convert';

import 'package:door_lock/util/service/http_service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:door_lock/models/tenant_model.dart';

class TenantSignupService {
  Future<Map<String, dynamic>> signupTenantFromHttp(
      { @required String email,
     @required String password,
     @required String firstname,
     @required String lastname,
     @required String mobile}) async {
    try {
      Map<String, String> authData = {
        "firstname":firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "mobile": mobile
      };
      http.Response response = await HttpService()
          .httpPost("http://huduma-api.herokuapp.com/account/signup", authData);

      Map<String, dynamic> res = json.decode(response.body);

      return res;
    } on Exception catch (e) {
      throw e;
    }
  }
}
