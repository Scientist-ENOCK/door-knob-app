import 'package:door_lock/adminDetai.dart';
import 'package:door_lock/models/tenant_model.dart';

import 'package:flutter/material.dart';

class DetailPg extends StatelessWidget {
  final TenantModel detail;
  DetailPg({this.detail});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return AdiminDetail(
                name: detail.name,
                amount: detail.amount,
                status: detail.status,
                duration: detail.duration,
                paidOn: detail.paidOn,
                endOn: detail.endOn,
              );
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
      child: Row(
        children: [
          Column(
            children: [
              Container(
                color: Colors.teal,
                height: 50,
                width: size.width * 0.7,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(detail.name),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.7,
                height: 2,
                color: Colors.black12,
              )
            ],
          ),
          Column(
            children: [
              Container(
                width: size.width * 0.3,
                color: Colors.teal,
                height: 50,
                child: Center(
                  child: Text(detail.status),
                ),
              ),
              Container(
                width: size.width * 0.3,
                height: 2,
                color: Colors.black12,
              )
            ],
          ),
        ],
      ),
    );
  }
}
