import 'package:flutter/material.dart';
import 'package:vegetus/models/farmer.dart';
import 'package:vegetus/screens/home/UserProductList.dart';
import 'package:vegetus/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:vegetus/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vegetus/models/user.dart';
import 'package:vegetus/shared/constants.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String keyword = "";
  AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Enter correct product name"),
      actions: [
        okButton,
      ],
    );

    final products = Provider.of<List<Product>>(context);
    var firebaseUser = FirebaseAuth.instance.currentUser();
    final user = Provider.of<User>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Search"),
          backgroundColor: Colors.green[600],
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
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 230,
                  margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: TextFormField(
                    decoration:
                        TextInputDecoration.copyWith(hintText: 'Product name'),
                    onChanged: (val) {
                      setState(() {
                        keyword = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                    height: 45.0,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.5),
                          side: BorderSide(color: Colors.green)),
                      onPressed: () => {
                        if (keyword == "Eggplant" ||
                            keyword == "Tomato" ||
                            keyword == "Broccoli" ||
                            keyword == "Potato" ||
                            keyword == "Corn" ||
                            keyword == "Carrot")
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProductList(
                                    text: keyword,
                                  ),
                                ))
                          }
                        else
                          {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            )
                          }
                      },
                      child: Text("Search",
                          style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "AvenirLTStd-Book",
                              fontWeight: FontWeight.bold)),
                    )),
              ],
            )
          ],
        ));
  }
}
