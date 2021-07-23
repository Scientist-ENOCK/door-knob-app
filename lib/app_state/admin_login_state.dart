import 'package:door_lock/util/service/http_service/admin_login_service.dart';
import 'package:flutter/material.dart';

class AdminLoginState extends ChangeNotifier {
  //initiator

  //selector

  //reducer

  Future<bool> isAdminValid(String email,String password) async {
    Map<String, dynamic> resp = await AdminLoginService().loginAdminFromHttp(email,password);
    if (resp.containsKey("success")) {
      return true;
    } else {
      return false;
    }
  }

}
