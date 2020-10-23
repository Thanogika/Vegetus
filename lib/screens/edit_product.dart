import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vegetus/models/product.dart';
import 'package:vegetus/providers/product_provider.dart';
import 'package:vegetus/screens/products/farmerProducts.dart';
import 'package:path/path.dart';
import 'dart:io';

class EditProduct extends StatefulWidget {
  final Product product;
  EditProduct([this.product]);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File _image;
  String productType = 'Tomato';
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    final productProvider = Provider.of<ProductProvider>(context);

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      productProvider.changeFilePath(fileName);

      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      productProvider.changeOwnerId(firebaseUser.uid);
      print(firebaseUser.uid);
      setState(() {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Product is successfully uploaded')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.green,
      ),
      body: Builder(
        builder: (context) => Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 100,
                        child: ClipOval(
                          child: SizedBox(
                            height: 180,
                            width: 180,
                            child: (_image != null)
                                ? Image.file(_image, fit: BoxFit.fill)
                                : Image.network(
                                    "https://blogs.extension.iastate.edu/spendsmart/files/2014/06/vegetables-variety.jpg",
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: IconButton(
                          icon: Icon(
                            Icons.camera,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImage();
                          }),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  child: DropdownButton<String>(
                    value: productType,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        productType = newValue;
                      });
                    },
                    items: <String>[
                      'Tomato',
                      'Broccoli',
                      'Potato',
                      'Eggplant',
                      'Carrot',
                      'Corn'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 50.0,
                  child: TextField(
                    // productProvider.changeName(value);
                    decoration: InputDecoration(hintText: 'Product Price'),
                    onChanged: (value) => productProvider.changePrice(value),
                  ),
                ),
                Container(
                  height: 50.0,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Product kg'),
                    onChanged: (value) {
                      productProvider.changeKg(value);
                    },
                  ),
                ),
                Container(
                  height: 50.0,
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: 'Product Description'),
                    onChanged: (value) {
                      productProvider.changeDes(value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 500,
                  height: 45,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    color: Colors.green[600],
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      uploadPic(context);

                      productProvider.changeName(productType);

                      productProvider.saveProduct();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (FarmerProducts())),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
