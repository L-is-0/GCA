import 'package:flutter/material.dart';

class Settings extends StatefulWidget{
  static const String id = "/settings";

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Settings>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
