import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetus/screens/home/UserProduct.dart';

import '../../models/product.dart';

class UserProductList extends StatefulWidget {
  final String text;
  UserProductList({Key key, @required this.text}) : super(key: key);
  @override
  _UserProductListState createState() => _UserProductListState(text);
}

class _UserProductListState extends State<UserProductList> {
  _UserProductListState(String text);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.text),
          backgroundColor: Colors.green[600],
        ),
        body: (products != null)
            ? ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (products[index].name == widget.text) {
                    return Card(
                      child: ListTile(
                        leading: Image.asset(
                            'graphics/${widget.text.toLowerCase()}.png'),
                        title: Text(products[index].name.toString()),
                        subtitle: Text(products[index].price.toString() +
                            " Rs\n" +
                            products[index].price.toString() +
                            " Kg"),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserProduct(
                                      productId: products[index].productId)))
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                })
            : Center(child: CircularProgressIndicator()));
  }
}
