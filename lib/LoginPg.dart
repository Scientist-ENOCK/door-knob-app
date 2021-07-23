import 'package:door_lock/adminLog.dart';

import 'package:door_lock/signup.dart';
import 'package:door_lock/tenantsPg.dart';
import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';

class LoginPg extends StatefulWidget {
  @override
  _LoginPgState createState() => _LoginPgState();
}

class _LoginPgState extends State<LoginPg> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email;
  String _password;
  

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<String> passvalidate(input) async {
    if (input.isEmpty) {
      return 'password is required';
    } else if (input.length < 6) {
      return 'should be atleast 6 characters';
    } else if (input.length > 12) {
      return 'atmost 8 characters';
    } else {
      return null;
    //  await authService.LoginEmailAndPass(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              height: size.height,
              width: size.width,
              color: Colors.black54,
              child: Stack(
                children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/h20.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1000),
                              pageBuilder: (
                                BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                              ) {
                                return AdiminLoginPg();
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.black54,
                                  height: 40,
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      'Admin',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.49,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                      width: size.width * 0.75,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(
                                            color: Colors.purple,
                                            width: 1,
                                          )),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Card(
                                          color: Colors.transparent,
                                          elevation: 10,
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: 'email required'),
                                              EmailValidator(
                                                  errorText:
                                                      ' enter a valid email'),
                                            ]),
                                            onSaved: (input) => _email = input,
                                            decoration: InputDecoration(
                                                labelText: 'email',
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                errorStyle: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17,
                                                ),
                                                //      fillColor: Colors.blue,
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                      width: size.width * 0.75,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(
                                            color: Colors.purple,
                                            width: 1,
                                          )),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Card(
                                          color: Colors.transparent,
                                          elevation: 10,
                                          child: TextFormField(
                                            obscureText: _obscureText,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                            ),
                                            // validator: passvalidate,
                                            onSaved: (input) =>
                                                _password = input,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _obscureText
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: _toggle,
                                                ),
                                                labelText: 'password',
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                errorStyle: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17,
                                                ),
                                                //      fillColor: Colors.blue,
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () {
                                  if (!_formkey.currentState.validate()) {
                                    return;
                                  } else {
                                    _formkey.currentState.save();
                                    print(_email);
                                    print(_password);
                                  }

                                  Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 1000),
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
                                child: Container(
                                  color: Colors.red,
                                  height: 50,
                                  width: 200,
                                  child: Center(
                                    child: Text('login'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                        transitionDuration:
                                            Duration(milliseconds: 1000),
                                        pageBuilder: (
                                          BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                        ) {
                                          return SignUp();
                                        },
                                        transitionsBuilder:
                                            (BuildContext context,
                                                Animation<double> animation,
                                                Animation<double>
                                                    secondaryAnimation,
                                                Widget child) {
                                          return Align(
                                            child: SizeTransition(
                                              sizeFactor: animation,
                                              child: child,
                                            ),
                                          );
                                        }));
                                  },
                                  child: Text(
                                    'sign up',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'forget password',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
