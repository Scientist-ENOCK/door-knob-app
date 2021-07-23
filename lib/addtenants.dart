import 'package:door_lock/Adimin.dart';
import 'package:flutter/material.dart';

class AddTenants extends StatefulWidget {
  @override
  _AddTenantsState createState() => _AddTenantsState();
}

class _AddTenantsState extends State<AddTenants> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _name;

  String _duration;

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'Name'),
      onSaved: (input) => _name = input,
    );
  }

  Widget _buildDuration() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'duration'),
      onSaved: (input) => _duration = input,
    );
  }

  Widget _buildPaidon() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'paid on'),
      onSaved: (input) => _duration = input,
    );
  }

  Widget _buildEndon() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'end on'),
      onSaved: (input) => _duration = input,
    );
  }

  Widget _buildAmount() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'amount'),
      onSaved: (input) => _duration = input,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Add pg',
          style: TextStyle(color: Colors.black),
        ),
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
      body: Container(
        color: Colors.teal,
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildName(),
              SizedBox(
                height: 10,
              ),
              _buildDuration(),
              SizedBox(
                height: 10,
              ),
              _buildPaidon(),
              SizedBox(
                height: 10,
              ),
              _buildEndon(),
              SizedBox(
                height: 10,
              ),
              _buildAmount(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.black54,
                      height: 40,
                      width: 70,
                      child: Center(child: Text('Submit')),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
