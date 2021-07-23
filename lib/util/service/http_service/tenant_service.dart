import 'dart:convert';

import 'package:door_lock/util/service/http_service/http_service.dart';
import 'package:http/http.dart' as http;

import 'package:door_lock/models/tenant_model.dart';

class TenantService {
  Future<List<TenantModel>> getTenantsFromHttp() async {
    try {
      http.Response response = await HttpService()
          .httpGet("http://huduma-api.herokuapp.com/tenants/all");

      List<TenantModel> tenants = [];
   
      for (dynamic data in json.decode(response.body)["tenants"]) {
        tenants.add(TenantModel.fromjson(data));
      }

      return tenants;
    } on Exception catch (e) {
      throw e;
    }
  }
}
