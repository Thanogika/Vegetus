import 'package:flutter/material.dart';
import 'package:vegetus/screens/Order/orders.dart';

import 'package:vegetus/screens/products/farmerProducts.dart';
import 'package:vegetus/screens/profile/farmerProfile.dart';
import 'package:vegetus/screens/profile/profile.dart';

class FarmerNavigation extends StatefulWidget {
  @override
  _FarmerNavigationState createState() => _FarmerNavigationState();
}

class _FarmerNavigationState extends State<FarmerNavigation> {
  int currentTab = 0;
  final List<Widget> screens = [FarmerProducts(), Order(), Profile()];

  Widget currentScreen = FarmerProducts();
  final PageStorageBucket backet = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: backet, child: currentScreen),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = FarmerProducts();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.widgets,
                        color: currentTab == 0 ? Colors.green : Colors.grey),
                    Text(
                      'Product',
                      style: TextStyle(
                          color: currentTab == 0 ? Colors.green : Colors.grey),
                    )
                  ],
                ),
                minWidth: 40,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = Order();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.local_shipping,
                        color: currentTab == 1 ? Colors.green : Colors.grey),
                    Text(
                      'Order',
                      style: TextStyle(
                          color: currentTab == 1 ? Colors.green : Colors.grey),
                    )
                  ],
                ),
                minWidth: 40,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = FarmerProfile();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person,
                        color: currentTab == 2 ? Colors.green : Colors.grey),
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: currentTab == 2 ? Colors.green : Colors.grey),
                    )
                  ],
                ),
                minWidth: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
