import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class DBhandler{
//   getUserByUID(String uid){
//    final dbRef = FirebaseDatabase.instance.reference().child("profiles");
//    dbRef.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot) {
//      print('Connected to the database and read ${snapshot.value}');
//        username = snapshot.value[uid]["username"];
//        email = snapshot.value[uid]["email"];
//        point = snapshot.value[uid]["points"];
//
//    });
//  };
//
}