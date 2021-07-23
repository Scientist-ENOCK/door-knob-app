import 'package:door_lock/Adimin.dart';
import 'package:door_lock/LoginPg.dart';
import 'package:door_lock/app_state/admin_login_state.dart';
import 'package:flutter/material.dart';
import 'package:door_lock/tenantsPg.dart';

import 'package:form_field_validator/form_field_validator.dart';

class AdiminLoginPg extends StatefulWidget {
  @override
  _AdiminLoginPgState createState() => _AdiminLoginPgState();
}

class _AdiminLoginPgState extends State<AdiminLoginPg> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;

  String _password;

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String passvalidate(input) {
    if (input.isEmpty) {
      return 'password is required';
    } else if (input.length < 2) {
      return 'should be atleast 6 characters';
    } else if (input.length > 12) {
      return 'atmost 8 characters';
    } else {
      return null;
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
                      Row(
                        children: [
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
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.5,
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
                                            validator: passvalidate,
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
                                    new AdminLoginState()
                                        .isAdminValid(_email, _password)
                                        .then((value) {
                                      if (value) {
                                        //is valid
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                transitionDuration: Duration(
                                                    milliseconds: 1000),
                                                pageBuilder: (
                                                  BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
                                                ) {
                                                  return Adimin();
                                                },
                                                transitionsBuilder:
                                                    (BuildContext context,
                                                        Animation<double>
                                                            animation,
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
                                      } else {
                                        //not valid credentials
                                        // final snackBar = SnackBar(
                                        //   key: _scaffoldKey,
                                        //     content: Text(
                                        //         'Sorry, incorrect credentials!'),duration: Duration(seconds: 1),);

                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(snackBar);
                                        print("object incorrect");
                                        setState(() {
                                           AlertDialog(
                                          title: Text("Sorry, incorrect credentials"),
                                        );
                                        });
                                       
                                      }
                                    });
                                  }
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
