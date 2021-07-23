
import 'package:door_lock/Adimin.dart';
import 'package:door_lock/LoginPg.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _name;
  String _duration;
  // AuthService authService = new AuthService();
  // ignore: non_constant_identifier_names
  bool _isLoading = false;
  
  SignUp(){
    if(_formkey.currentState.validate()) {
      setState((){
      _isLoading = true;
      });
      // authService.signUpWithEmailAndPassword(email, password).then((value){
      //   if(value!=null) {
      //     setState(() {
      //   _isLoading = false;
      //     });
      //     Navigator.PushReplacement(context,MaterialPageRoute){(
      //     builder: (context) => home()});
      //   };
      // });
      
      }
  }

  Widget _buildNamef() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'first name'),
      onSaved: (input) => _name = input,
    );
  }

  Widget _buildNameL() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'last name'),
      onSaved: (input) => _duration = input,
    );
  }

  Widget _buildemail() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'email'),
      onSaved: (input) => _duration = input,
    );
  }

  Widget _buildpassword() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'password'),
      onSaved: (input) => _duration = input,
    );
  }

  Widget _buildphone() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 1.0),
          ),
          labelText: 'phone'),
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
          'SignUp pg',
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
      body: Container(
        color: Colors.teal,
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNamef(),
              SizedBox(
                height: 10,
              ),
              _buildNameL(),
              SizedBox(
                height: 10,
              ),
              _buildemail(),
              SizedBox(
                height: 10,
              ),
              _buildpassword(),
              SizedBox(
                height: 10,
              ),
              _buildphone(),
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
