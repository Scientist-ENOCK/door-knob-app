import 'package:door_lock/Adimin.dart';
import 'package:flutter/material.dart';

class AdiminDetail extends StatelessWidget {
  String name;
  String duration;
  String paidOn;
  String endOn;
  String status;
  String amount;

  AdiminDetail(
      {@required this.name,
      @required this.duration,
      @required this.endOn,
      @required this.paidOn,
      @required this.status,
      @required this.amount});

  avoidNulls() {
    if (paidOn == null) {
      paidOn = "";
    }
    if (amount == null) {
      amount = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    avoidNulls();

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
                    return Adimin();
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
                            name,
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
                            status,
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
                            duration,
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
                            paidOn,
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
                            endOn,
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
                            amount,
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
