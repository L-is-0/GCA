import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

class Sorting extends StatefulWidget{
  static const String id = "/sorting";

  @override
  _SortingState createState() => _SortingState();
}

class _SortingState extends State<Sorting>{
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

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
//               onTap: () => Navigator.pushNamed(context, '/scan'),
               child: Container(
                 padding: const EdgeInsets.all(8),
                 child:
                 _image == null
                     ? Text('No image selected.')
                     : Image.file(_image),
//                 Image(image: AssetImage('assets/images/tap.png')),
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
              label: 'Search',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('SEARCH ITEM')
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: Colors.blue,
            label: 'Barcode',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SCAN BARCODE'),
          ),
          SpeedDialChild(
            child: Icon(Icons.add_a_photo),
            backgroundColor: Colors.green,
            label: 'Scan',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => getImage(),
          ),
        ],
      ),
    );
  }
}


