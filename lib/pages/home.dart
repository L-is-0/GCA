import 'package:flutter/material.dart';
import 'package:gca_app/pages/login.dart';
import 'package:gca_app/pages/profile.dart';
import 'package:gca_app/pages/register.dart';
import 'package:gca_app/pages/settings.dart';
import 'package:gca_app/pages/sorting.dart';
import 'package:gca_app/pages/square.dart';
import 'package:gca_app/pages/tips.dart';
import 'package:getflutter/components/drawer/gf_drawer.dart';

class Home extends StatefulWidget{
  static const String id = "/home";

  @override
  _HomeState createState() => _HomeState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Login.id:(context) => Login(),
        Register.id:(context) => Register(),
        Sorting.id:(context) => Sorting(),
        Tips.id:(context) => Tips(),
        Square.id:(context) => Square(),
        Setting.id:(context) => Setting(),
        Profile.id:(context) => Profile()
      },
    );
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to home page',
      home: Scaffold(
        backgroundColor: Colors.white,

        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child :SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top:10.0),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Colors.blue
                                ),
                                labelText: "Search",
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    color: Colors.white
                                ),
                                prefixIcon: Icon(Icons.search),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(color: Colors.blue)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 800,
                      child: GridView.count(
                        primary:false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/sorting'),
                            child: Container(
                              color: Colors.lightGreen[900],
//                          padding: const EdgeInsets.all(30),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(image: AssetImage('assets/images/icon1.png')),
                                  Text("Sorting", style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/tips'),
                            child: Container(
                              color: Colors.red[400],
//                          padding: const EdgeInsets.all(30),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(image: AssetImage('assets/images/icon3.png')),
                                  SizedBox(height: 5),
                                  Text("Tips", style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/square'),
                            child: Container(
                              color: Colors.orange,
//                          padding: const EdgeInsets.all(30),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(image: AssetImage('assets/images/icon2.png')),
                                  SizedBox(height: 5),
                                  Text("Square", style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/profile'),
                            child: Container(
                              color: Colors.grey[700],
//                          padding: const EdgeInsets.all(30),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(image: AssetImage('assets/images/icon4.png')),
                                  SizedBox(height: 5),
                                  Text("Profile", style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
              )
          ),
        ),
        drawer:
        GFDrawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text('Item 1'),
                onTap: null,
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
