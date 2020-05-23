import 'dart:io';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText, recyclableText;
  final File image;
  final List recognitions;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.recyclableText,
    this.recognitions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
    Container(
      padding: EdgeInsets.only(
        top:  Consts.padding + Consts.avatarRadius,
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      margin: EdgeInsets.only(top: Consts.avatarRadius),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
      children: <Widget>[
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.center,
                    image: FileImage(image),
                    fit: BoxFit.fill
                )
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            child:Column(
              children: recognitions != null
                  ? recognitions.map((res) {
                return Text(
                  "${res["label"]} : ${res["confidence"].toStringAsFixed(3)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    background: Paint()..color = Colors.white,
                  ),
                );
              }).toList()
                  : [],
            ),
          ),
        Container(
          child:Text(
                "The garbage is $recyclableText !",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  background: Paint()..color = Colors.white,
                ),
          ),
        ),
          SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop(); // To close the dialog
              },
              child: Text(
                  buttonText,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        ],
      ),
      ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.green,
            radius: Consts.avatarRadius,
          ),
        ),
    ]
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 55.0;
}