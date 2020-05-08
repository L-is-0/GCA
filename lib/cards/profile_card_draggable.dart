import 'package:flutter/material.dart';

class ProfileCardDraggable extends StatelessWidget {
  final int cardNum;
  ProfileCardDraggable(this.cardNum);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/images/tip$cardNum.jpg', fit: BoxFit.cover),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text('Tip $cardNum of today',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700)),
                  Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Text('Start your recycle journey', textAlign: TextAlign.start),
                ],
              ))
        ],
      ),
    );
  }
}