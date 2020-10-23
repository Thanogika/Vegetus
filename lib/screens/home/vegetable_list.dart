import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class VegetableList extends StatefulWidget {
  @override
  _VegetableListState createState() => _VegetableListState();
}

class _VegetableListState extends State<VegetableList> {
  @override
  Widget build(BuildContext context) {
    final vegetables = Provider.of<QuerySnapshot>(context);
    for (var doc in vegetables.documents) {
      // print(doc.data);
    }
    return Container();
  }
}
