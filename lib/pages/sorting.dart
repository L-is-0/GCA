import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
//import 'package:firebase_mlvision/firebase_mlvision.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mlkit/mlkit.dart';



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
  Map<String, List<String>> labels = {
    "gcp": null,
  };

  FirebaseModelInterpreter interpreter = FirebaseModelInterpreter.instance;
  FirebaseModelManager manager = FirebaseModelManager.instance;

  Future getImage() async {
    loadModel();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = image;
      });
      predictImage(_image);
    }
  }

  Future predictImage(File image) async {
    print ("debug: start to predict image");
    if (image == null) return;
    await autoML(image);
  }

  Future encodeImage(File image) async {
    var imageBytes = await image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes).toString();
    print (base64Image);
    return base64Image;
  }

  Future makePostRequest(File image) async {
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);
    Map<String, String> headers = {"Accept": "application/json"};
    Map body = {"image": base64Image};
    var response = await http.post("http://YourVM PUBLIC IP/automl.php",
    body: body, headers: headers);
    print(response.body);
  }

  Future loadModel() async {
    try{
      //Register Local Backup
      manager.registerLocalModelSource(FirebaseLocalModelSource(modelName: 'gcp',  assetFilePath: 'assets/models/model.tflite'));
      rootBundle.loadString('assets/models/dict.txt').then((string) {
        var _l = string.split('\n');
        _l.removeLast();
        labels["gcp"] = _l;
      });
      print("TF model loaded");
    }on PlatformException{
      print ("Failed to load model");
    }
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File imagefile = new File.fromUri(myUri);
    Uint8List bytes;
    await imagefile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }

  Future autoML(File image)async {
    print ("debug: start automl");
    var imageBytes = _readFileByte(image.path);
    img.Image oriImage = img.decodeJpg(await imageBytes);
    img.Image resizedImage = img.copyResize(oriImage, height: 224, width: 224);

    List<dynamic> results;
    var factor = 0.01;

    results = await interpreter.run(
        localModelName: "gcp",
        inputOutputOptions:
        FirebaseModelInputOutputOptions(
            [
          FirebaseModelIOOption(FirebaseModelDataType.BYTE, [1, 224, 224, 3])
        ], [
          FirebaseModelIOOption(FirebaseModelDataType.BYTE, [1, 6])
        ]),
        inputBytes: imageToByteList(resizedImage));

    factor = 2.55;

    print ("debugging");
    print (results);

    List<ObjectDetectionLabel> currentLabels = [];

    for (var i = 0; i < results[0][0].length; i++) {
      if (results[0][0][i] > 0) {
        currentLabels.add(new ObjectDetectionLabel(
            labels["gcp"][i],
            results[0][0][i] / factor));
      }
    }
    
    var label = currentLabels[0].label;
    var cog = currentLabels[0].confidence;
    
    
    if (label != null){
      setState(() {
        _recognitions = [{'label': label, "confidence" :cog}];
      });
    }else{
      _recognitions = [{"confidence":"0", "index":"0", "label":"null"}];
    }

    print(label);
    print(cog);
  }

  // int model
  Uint8List imageToByteList(img.Image image) {
    var _inputSize = 224;
    var convertedBytes = new Uint8List(1 * _inputSize * _inputSize * 3);
    var buffer = new ByteData.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < _inputSize; i++) {
      for (var j = 0; j < _inputSize; j++) {
        var pixel = image.getPixel(i, j);
        buffer.setUint8(pixelIndex, (pixel >> 16) & 0xFF);
        pixelIndex++;
        buffer.setUint8(pixelIndex, (pixel >> 8) & 0xFF);
        pixelIndex++;
        buffer.setUint8(pixelIndex, (pixel) & 0xFF);
        pixelIndex++;
      }
    }
    return convertedBytes;
  }

  Future imagePrediction(File image) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
//    FirebaseVision.instance.modelManager().setupModel('model', 'assets/models');
//    final VisionEdgeImageLabeler visionEdgeLabeler = FirebaseVision.instance.visionEdgeImageLabeler('models');
//    final List<VisionEdgeImageLabel> visionEdgeLabels = await visionEdgeLabeler.processImage(visionImage);

    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> labels = await labeler.processImage(visionImage);

    //extract labels
    for (ImageLabel label in labels) {
      final String text = label.text;
      final String entityId = label.entityId;
      final double confidence = label.confidence;
    }
    //extract text
    labeler.close();
  }

  Uint8List imageToByteListFloat32(img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3 );
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = ((img.getRed(pixel) - mean) / std).toDouble();
        buffer[pixelIndex++] = ((img.getGreen(pixel) - mean) / std).toDouble();
        buffer[pixelIndex++] = ((img.getBlue(pixel) - mean) / std).toDouble();
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = new Uint8List(1 * inputSize * inputSize * 3);
    var buffer = new ByteData.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer.setUint8(pixelIndex, (pixel >> 16) & 0xFF);
        pixelIndex++;
        buffer.setUint8(pixelIndex, (pixel >> 8) & 0xFF);
        pixelIndex++;
        buffer.setUint8(pixelIndex, (pixel) & 0xFF);
        pixelIndex++;
      }
    }
    print("The input buffer type: ");
    return convertedBytes;
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
                          child: Column(
                            children: _recognitions != null
                            ? _recognitions.map((res) {
                               return Text(
                                 "${res["label"]} : ${res["confidence"].toStringAsFixed(3)}",
                                   style: TextStyle(
                                   color: Colors.black,
                                   fontSize: 20.0,
                                   background: Paint()..color = Colors.white,
                                 ),
                               );
                               }).toList()
                            : [],
                          )
                        )

//                 Container(
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               alignment: Alignment.topCenter,
//                               image: MemoryImage(_recognitions),
//                               fit: BoxFit.fill)),
//                       child: Opacity(opacity: 0.3, child: Image.file(_image))),

//                     : Image.file(_image),
//                 Image(image: AssetImage('assets/images/tap.png')),
                 //          color: Colors.red[400],)
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

class ObjectDetectionLabel {
  String label;
  double confidence;

  ObjectDetectionLabel([this.label, this.confidence]);
}


