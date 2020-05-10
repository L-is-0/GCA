import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Register extends StatefulWidget{
  static const String id = "/register";

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Register'),
      ),
      body: Center(
        child: Text('Register Page'),
      ),
    );
  }

}

