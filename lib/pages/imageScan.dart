import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageScan extends StatefulWidget {
  static const String id = "/scan";
  @override
  _ImageScanState createState() => _ImageScanState();
}

class _ImageScanState extends State<ImageScan> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);
    Map<String, String> headers = {"Accept": "application/json"};
    Map body = {"image": base64Image};
    var response = await http.post('http://YourVM PUBLIC IP/automl.php',
    body: body, headers: headers);
    print(response.body);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}