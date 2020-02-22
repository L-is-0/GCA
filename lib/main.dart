// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gca_app/pages/login.dart';
import 'package:gca_app/pages/register.dart';
import 'package:gca_app/pages/settings.dart';
import 'package:gca_app/pages/sorting.dart';
import 'package:gca_app/pages/square.dart';
import 'package:gca_app/pages/tips.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      routes: {
        Login.id:(context) => Login(),
        Register.id:(context) => Register(),
        Sorting.id:(context) => Sorting(),
        Tips.id:(context) => Tips(),
        Square.id:(context) => Square(),
        Settings.id:(context) => Settings(),
      },
    );
  }
}
class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to home page',
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('GCA'),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: TextField(
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.white
                            ),
                            labelText: "Search",
                            hintText: "Search",
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
                        padding: const EdgeInsets.all(8),
                        child:
                        Image(image: AssetImage('assets/images/icon1.png')),
                        color: Colors.lightGreen[900],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/tips'),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child:
                        Image(image: AssetImage('assets/images/icon3.png')),
                        color: Colors.yellow[300],
                      ),
                    ),GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/square'),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Image(image: AssetImage('assets/images/icon2.png')),
                        color: Colors.deepOrange[300],
                      ),
                    ),GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/settings'),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Image(image: AssetImage('assets/images/icon4.png')),
                        color: Colors.teal[100],
                    ),
                  ),
                ],
              ),
              ),
            ]
          )
        ),
      ),
    );
  }
}