import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:http/http.dart' as http;



const String visonML = "Auto ML";

class Sorting extends StatefulWidget{
  static const String id = "/sorting";

  @override
  _SortingState createState() => _SortingState();
}

class _SortingState extends State<Sorting>{
  File _image;
  List _recognitions;
  String res;
  String _model = visonML;


  Future getImage() async {
    loadModel();

    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });
//      makePostRequest(image);
      recognizeImageBinary(_image);
//      predictImage(_image);
    }
//    recognizeImageBinary(_image);
//    await Tflite.close();
  }

  Future predictImage(File image) async {
    print ("debug: start to predict image");
    if (image == null) return;
//    await autoML(image);
    await autoML(image);
  }

  Future encodeImage(File image) async {
    var imageBytes = await image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes).toString();
    print (base64Image);
    return base64Image;
  }

//  Future makePostRequest(File image) async {
//    var encodedimg = encodeImage(image);
//
//    String url = 'https://automl.googleapis.com/v1beta1/projects/639315848103/locations/us-central1/models/ICN3643161409891598336:predict';
//    Map jsonMap =
//    {
//        "payload":
//        {
//          "image":
//          {
//            "imageBytes": "123"
//          }
//        }
//    };
//
//    var body = json.encode(jsonMap);
//    var response = await http.post(url,
//        headers: {
//          "Content-Type": "application/json",
//          'Authorization': 'Bearer $(gcloud auth application-default print-access-token)',
//        },
//        body: body
//    );
//
//    print("${response.statusCode}");
//    print("${response.body}");
//    return response;
//  }

  Future loadModel() async {
    try{
      res = await Tflite.loadModel(
          model: "assets/models/model.tflite",
          labels: "assets/models/dict.txt",
      );
      print("loading tf model...");
      print(res);
    }on PlatformException{
      print ("Failed to load model");
    }
  }

  Future recognizeImageBinary(File image) async {
//    var imageBytes = (new File(image.path)).readAsBytes().asUnit8List();
    var imageBytes = await image.readAsBytesSync();
//    var base64Image = base64Encode(imageBytes);
    var bytes = imageBytes.buffer.asUint8List();

//    var imageBytes = (await rootBundle.load(image.path)).buffer;
//    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    img.Image oriImage = img.decodeJpg(bytes);
    img.Image resizedImage = img.copyResize(oriImage, height: 112, width: 112);

    var recognitions = await Tflite.runModelOnBinary(
//        binary: imageToByteListFloat32(resizedImage, 112, 127.5, 127.5),
//        numResults: 6,
//        threshold: 0.05,
//        asynch: true
      binary: imageToByteListUint8(resizedImage, 112),
      numResults: 2,
      threshold: 0.4,
      asynch: true
    );
    setState(() {
      _recognitions = recognitions;
    });
  }

  Future autoML(File image)async {
    print ("debug: start automl");
    var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 3,    // defaults to 5
        threshold: 0.2,   // defaults to 0.1
        asynch: true      // defaults to true
    );

    if (recognitions != null){
      setState(() {
        _recognitions = recognitions;
      });
    }else{
      _recognitions = [{"confidence":"0", "index":"0", "label":"null"}];
    }
    print ("debugging");
    print (recognitions);

  }

  Uint8List imageToByteListFloat32(img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3 );
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(4 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
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
//                     : _recognitions
                     : Container(
//                         children : _recognitions != null
                            child : _recognitions != null
                             ? Text("not null")
                             : Text("null")
//                             ? _recognitions.map((res) {
//                               return Text(
//                                 "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",
//                               );
//                         }).toList()
//                             : _recognitions.map((res) {
//                           return Text(
//                             "test:0",
//                           );
//                         }).toList(), //if recognition is null
                        )
//                 )_recognitions!=null
//                     ? _recognitions.map((res) {
//                   return Text(
//                     "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20.0,
//                       background: Paint()..color = Colors.white,
//                     ),
//                   );
//                 }).toList() : [],
//                 Container(
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               alignment: Alignment.topCenter,
//                               image: MemoryImage(_recognitions),
//                               fit: BoxFit.fill)),
//                       child: Opacity(opacity: 0.3, child: Image.file(_image))),

//                     : Image.file(_image),
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


