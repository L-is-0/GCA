import 'package:flutter/material.dart';

class Tips extends StatefulWidget{
  static const String id = "/tips";

  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Tips'),
      ),
      body: Center(
        child: Text('Tips Page'),
      ),
    );
  }
}
