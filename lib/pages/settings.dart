import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:settings/settings.dart';

class Setting extends StatefulWidget{
  static const String id = "/setting";

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: Center(
            child: Column(children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              RaisedButton(onPressed: Settings.openWiFiSettings, child: new Text("Open wifi settings")),
            ]),
          ),
        ));
  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title:Text('Settings'),
//      ),
//      body: Center(
//        child: Text('Settings Page'),
//      ),
//    );
//  }
}
