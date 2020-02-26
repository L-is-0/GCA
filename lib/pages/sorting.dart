import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      body: Align(
        alignment: Alignment.center,
         child: Column(
           children: <Widget>[
             Padding(
               padding:const EdgeInsets.all(20),
               child: Text(
                 "Hello, Peter!",
                 style: TextStyle(
                     fontSize: 16
                 ),
               ),
             ),
             Padding(
               padding:const EdgeInsets.all(10),
               child: Text(
                 "Let's begin your recycle!",
                 style: TextStyle(
                     fontSize: 16
                 ),
               ),
             ),
             GestureDetector(
               onTap: () => Navigator.pushNamed(context, '/tips'),
               child: Container(
                 padding: const EdgeInsets.all(8),
                 child:
                 Image(image: AssetImage('assets/images/tap.png')),
                 //          color: Colors.red[400],
               ),
             ),
           ],
        )
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
//        visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.accessibility),
              backgroundColor: Colors.red,
              label: 'Search Item',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('SEARCH ITEM')
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: Colors.blue,
            label: 'Scan Barcode',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SCAN BARCODE'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Colors.green,
            label: 'Scan Item',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SCAN ITEM'),
          ),
        ],
      ),
    );
  }
}
