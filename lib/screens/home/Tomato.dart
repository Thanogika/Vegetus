import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Application",
      home: Tomato(),
      
);
  }
}




class Tomato extends StatefulWidget {
  @override
  _Tomato createState() => _Tomato();
}

class _Tomato extends State<Tomato> {

  List names = ["Kamal","Vimal","Nimal","Namal"];
  List available = ["12kg","22kg","32kg","42kg"];

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[600],
          title: Text('Farmers Name ',
            style:TextStyle(
              fontSize: 20.0,
              color:Colors.white,
              fontWeight: FontWeight.bold
              ),
      
    ),
  ),

     
      body: ListView.builder(
        itemCount: 4,
        shrinkWrap: true, //give the flexibile animation
        itemBuilder: (BuildContext context, int index) =>Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 5.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(names[index],
                            style: TextStyle(color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),),
                          Text(available[index],
                            style: TextStyle(color: Colors.grey,
                            fontSize: 15.0),),
                          ],
                        ),
                    ],
                  ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: FlatButton(
                    onPressed: () {},
                    color:Colors.green[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                      ),
                    child: Text("View",
                        style: TextStyle(
                          color: Colors.white
                        ),),

           ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
      // body: new ListView(
      //   children: <Widget>[
      //       new ListTile(
      //       title: new Text('Green Grass',
      //       textAlign: TextAlign.left,
      //                style: TextStyle(
      //                 fontSize: 15, 
      //                color: Colors.white
      //           ),
      //       ),
      //     ),
      //   ],
      // ),          
      
    );
  }

}
                


