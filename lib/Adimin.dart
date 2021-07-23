import 'package:door_lock/LoginPg.dart';
import 'package:door_lock/addtenants.dart';
import 'package:door_lock/app_state/tenant_state.dart';
import 'package:door_lock/models/tenant_model.dart';

import 'package:door_lock/pages/detailpg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Adimin extends StatelessWidget {
  List<TenantModel> detailList;

  fillTenants(BuildContext context) {
    Provider.of<TenantState>(context,listen: true).getTenants();

  }

  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      fillTenants(context);
      firstTime = false;
    }
     detailList = Provider.of<TenantState>(context).tenants;

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(
          'Admin',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.teal,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1000),
                pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return LoginPg();
                },
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return Align(
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: child,
                    ),
                  );
                }));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: detailList.length,
        itemBuilder: (BuildContext context, int index) => DetailPg(
          detail: detailList[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return AddTenants();
              },
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return Align(
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: child,
                  ),
                );
              }));
        },
      ),
    ));
  }
}
