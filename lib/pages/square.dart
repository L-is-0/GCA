import 'package:flutter/material.dart';

class Square extends StatefulWidget{
  static const String id = "/square";

  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Square'),
      ),
      body: Center(
        child: Text('Square Page'),
      ),
    );
  }
}
