import 'package:flutter/material.dart';

class Sorting extends StatefulWidget{
  static const String id = "/sorting";

  @override
  _SortingState createState() => _SortingState();
}

class _SortingState extends State<Sorting>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Sorting'),
      ),
      body: Center(
        child: Text('Sorting Page'),
      ),
    );
  }
}
