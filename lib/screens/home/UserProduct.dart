import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vegetus/screens/home/home.dart';
import 'package:vegetus/shared/loading.dart';

class UserProduct extends StatefulWidget {
  final String productId;

  UserProduct({Key key, @required this.productId}) : super(key: key);

  @override
  _UserProductState createState() => _UserProductState(productId);
}

class _UserProductState extends State<UserProduct> {
  String filePath = "";
  String pathFinal = "";
  String productName = "";
  String productPrice = "";
  String productKG = "";
  String productDes = "";
  String productOwnerId = "";
  bool isLoading = true;

  String orderedKg = "";

  _UserProductState(String productId);
  final firestoreInstance = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Your order has been recorded !"),
      actions: [
        okButton,
      ],
    );
    getImagePath();
    return isLoading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Colors.green[600],
              title: Text(
                "Vegetable",
                style: TextStyle(fontFamily: 'Celias-Medium'),
              ),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Image.network(
                    pathFinal,
                    width: 200,
                  ),
                ),
                SizedBox(),
                Container(
                  child: Text(
                    productName,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Celias-Medium',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "Rs. " + productPrice,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "AvenirLTStd-Book",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "  About " + productName,
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'Times New Roman'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    productDes,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 120,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Enter Kg",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    onChanged: (value) => {
                      setState(() {
                        orderedKg = value;
                      })
                    },
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: "AvenirLTStd-Book",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green)),
                    padding: EdgeInsets.fromLTRB(45, 10, 45, 10),
                    onPressed: () async {
                      var firebaseUser =
                          await FirebaseAuth.instance.currentUser();

                      firestoreInstance
                          .collection("orders")
                          .document()
                          .setData({
                        "ProductName": productName,
                        "Kg": orderedKg,
                        "Price": productPrice,
                        "UserId": firebaseUser.uid,
                        "OwnerId": productOwnerId
                      }).then((_) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      });
                    },
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "AvenirLTStd-Book",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ));
  }

  getImagePath() async {
    var document = await firestoreInstance
        .collection("products")
        .document(widget.productId)
        .get();

    String path = document["filePath"];
    String name = document["name"];
    String description = document["des"];
    String kg = document["kg"].toString();
    String ownerid = document["ownerId"];
    String price = document["price"].toString();

    if (mounted) {
      setState(() {
        filePath = path;
        productDes = description;
        productKG = kg;
        productName = name;
        productOwnerId = ownerid;
        productPrice = price;
        isLoading = false;
      });
    }

    String pathfinal = await getStorageUrl(path);

    if (mounted) {
      setState(() {
        pathFinal = pathfinal;
      });
    }
  }

  Future<String> getStorageUrl(String fileName) async {
    String url = "";
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("$fileName");
    url = await storageReference.getDownloadURL();

    return url;
  }
}
