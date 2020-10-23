import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vegetus/models/product.dart';
import 'package:vegetus/models/farmer.dart';


class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> saveProduct(Product product){
    return _db.collection('products').document(product.productId).setData(product.toMap());
  }
  Stream<List<Product>> getProduct(){
    return _db.collection('products').snapshots().map((snapshot) => snapshot.documents.map((document) => Product.fromFirestore(document.data)).toList());
  }
  Stream<List<Farmer>> getUsers(){
    return _db.collection('users').snapshots().map((snapshot) => snapshot.documents.map((document) => Farmer.fromFirestore(document.data)).toList());
  }

  Future <void> removeProduct(String productId){
    return _db.collection("products").document(productId).delete();
  }
}