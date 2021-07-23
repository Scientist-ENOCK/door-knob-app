import 'package:door_lock/util/service/http_service/tenants_signup_service.dart';
import 'package:flutter/material.dart';

class TenantSignUpState {
  Future<bool> isAdminValid(
      {@required String email,
      @required String password,
      @required String firstname,
      @required String lastname,
      @required String mobile}) async {
    Map<String, dynamic> resp = await TenantSignupService()
        .signupTenantFromHttp(
            email: email,
            firstname: firstname,
            lastname: lastname,
            mobile: mobile,
            password: password);
    if (resp["success"]==true) {
      return true;
    } else {
      return false;
    }
  }
}
