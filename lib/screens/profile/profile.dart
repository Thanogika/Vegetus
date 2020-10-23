import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vegetus/services/auth.dart';
import 'package:vegetus/shared/loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userid = "";
  String userlocation = "";
  String usertype = "";
  String useremail = "";
  String phoneno = "";
  String username = "";
  bool isLoading = true;
  AuthServices _auth = AuthServices();

  final firestoreInstance = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    getImagePath();
    return isLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Colors.green[600],
              title: Text(
                "Profile",
                style: TextStyle(fontFamily: 'Celias-Medium'),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  label: Text('logout'),
                  textColor: Colors.white,
                  onPressed: () async {
                    await _auth.SignOut();
                  },
                )
              ],
            ),
            body: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage('graphics/logo.png'),
                  ),
                ),
                Container(
                  child: Text(username),
                ),
                Container(
                  child: Text(phoneno),
                ),
                Container(
                  child: Text(useremail),
                ),
                Container(
                  child: Text(userlocation),
                ),
                Container(
                  child: Text(usertype),
                )
              ],
            )));
  }

  getImagePath() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var document = await firestoreInstance
        .collection("users")
        .document(firebaseUser.uid)
        .get();

    String id = document["UserId"];
    String name = document["Name"];
    String phone = document["phone"];
    String email = document["Email"];
    String userType = document["userType"];
    String location = document["location"];

    if (mounted) {
      setState(() {
        usertype = userType.toString();
        userid = id;
        username = name;
        phoneno = phone;
        useremail = email;
        userlocation = location;
        isLoading = false;
      });
    }
  }
}
