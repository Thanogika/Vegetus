import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetus/providers/product_provider.dart';
import 'package:vegetus/services/auth.dart';
import 'package:vegetus/services/firestore_service.dart';
import 'screens/wrapper.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        StreamProvider(create: (context)=>firestoreService.getProduct(),
        ),
        StreamProvider(create: (context)=>firestoreService.getUsers()),
        ],
      child: StreamProvider<User>.value(
          value: AuthServices().user, child: MaterialApp(home: Wrapper())),
    );
  }
}
