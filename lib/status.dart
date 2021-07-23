import 'package:door_lock/tenantsPg.dart';
import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
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
                    return TenantsPg();
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: size.height * 0.5,
                  width: size.width * 0.8,
                  color: Colors.black54,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'name',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 120,
                          ),
                          Text(
                            'adam juma',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'status',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 120,
                          ),
                          Text(
                            'paid',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Duration',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 110,
                          ),
                          Text(
                            'six months',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'paid on',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 110,
                          ),
                          Text(
                            '2/5/2021',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'end on',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 110,
                          ),
                          Text(
                            '2/11/2021',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'amount',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 110,
                          ),
                          Text(
                            '540000',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
