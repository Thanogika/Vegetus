import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference vegetableCollection =
      Firestore.instance.collection('vegetable');

  Future updateUserData(String name, String email, String phone,
      String location, String userType, String uid) async {
    return await userCollection.document(uid).setData({
      'Name': name,
      'UserId': uid,
      'Email': email,
      'phone': phone,
      'location': location,
      'userType': userType
    });
  }

  Future updateVegetableData() async {
    return await vegetableCollection.document(uid).setData({
      'Vegetable Name': 'Tomato',
      'Price': '80',
      'Owner': uid,
      'Farm Name': 'NK Farm'
    });
  }

  Stream<QuerySnapshot> get vegetables {
    return vegetableCollection.snapshots();
  }
}
