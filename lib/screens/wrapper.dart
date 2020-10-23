import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vegetus/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:vegetus/models/user.dart';
import 'package:vegetus/screens/farmerNavigation.dart';

import 'package:vegetus/screens/userNavigation.dart';
import 'package:vegetus/shared/loading.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final Firestore database = Firestore.instance;

  final firestoreInstance = Firestore.instance;
  String userType = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //Return either home or login
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      setState(() {
        isLoading = true;
      });
      if (isLoading) {
        getUserType();
        Loading();
      }

      if (userType == 'Farmer') {
        // print("object");
        return FarmerNavigation();
      } else if (userType == 'Customer') {
        return UserNavigation();
      } else {
        return UserNavigation();
      }
    }
  }

  getUserType() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var document = await firestoreInstance
        .collection("users")
        .document(firebaseUser.uid)
        .get();

    String type = document["userType"];
    setState(() {
      userType = type;
      isLoading = false;
    });
  }
}
