import 'package:door_lock/models/tenant_model.dart';
import 'package:door_lock/util/service/http_service/tenant_service.dart';
import 'package:flutter/material.dart';

class TenantState extends ChangeNotifier {
//initiator
  List<TenantModel> _tenants;

  //selector
  List<TenantModel> get tenants =>
      _tenants ??
      [
        TenantModel(
            name: 'Adam juma',
            status: 'paid',
            duration: '6 months',
            paidOn: '2/5/2021',
            endOn: '2/10/2021',
            amount: '540000'),
      ];

  //reducer

  Future getTenants() async {
    _tenants = await TenantService().getTenantsFromHttp();

    notifyListeners();
  }
}
