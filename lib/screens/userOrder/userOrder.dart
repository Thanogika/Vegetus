import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetus/models/user.dart';
import 'package:vegetus/services/auth.dart';

class userOrder extends StatefulWidget {
  @override
  _userOrderState createState() => _userOrderState();
}

class _userOrderState extends State<userOrder> {
  final firestoreInstance = Firestore.instance;

  AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser();
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Order'),
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
      body: StreamBuilder(
        stream: Firestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot orders = snapshot.data.documents[index];
                if (!snapshot.hasData || snapshot.data.documents == null)
                  return CircularProgressIndicator();
                else if (orders['UserId'] == user.uid) {
                  return Card(
                    child: ListTile(
                      title: Text(orders["ProductName"]),
                      subtitle: Text(
                          orders["Price"] + " Rs\n " + orders["Kg"] + " Kg"),
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
