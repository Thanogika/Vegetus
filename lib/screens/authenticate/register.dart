import 'package:flutter/material.dart';
import 'package:vegetus/services/auth.dart';
import 'package:vegetus/shared/constants.dart';
import 'package:vegetus/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = "";
  String email = "";
  String password = "";
  String phone = "";
  String location = "";
  String userType = "Customer";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green[600],
              elevation: 0.0,
              title: Text('Sign up to Vegetus'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text("Sign In"),
                  textColor: Colors.white,
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            TextInputDecoration.copyWith(hintText: "Name"),
                        validator: (val) => val.isEmpty ? 'Enter a name' : null,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          height: 50.0,
                          child: TextFormField(
                            decoration:
                                TextInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          )),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration:
                            TextInputDecoration.copyWith(hintText: "Password"),
                        validator: (val) => val.isEmpty
                            ? 'Enter password'
                            : val.length < 6
                                ? 'Enter a password 6+ char long'
                                : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration:
                            TextInputDecoration.copyWith(hintText: 'Phone'),
                        validator: (val) => val.isEmpty
                            ? 'Enter mobile numer'
                            : val.length == 10
                                ? null
                                : 'Enter phone number in 10 digits',
                        onChanged: (val) {
                          setState(() {
                            phone = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration:
                            TextInputDecoration.copyWith(hintText: 'Location'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter your location' : null,
                        onChanged: (val) {
                          setState(() {
                            location = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),

                      //Droupdown list

                      DropdownButton<String>(
                        value: userType,
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            userType = newValue;
                          });
                        },
                        items: <String>['Customer', 'Farmer']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                      Container(
                        width: 500,
                        height: 45,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            color: Colors.green[600],
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        name,
                                        email,
                                        password,
                                        phone,
                                        location,
                                        userType);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                    loading = false;
                                  });
                                }
                              } else {
                                loading = false;
                              }
                            }),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
