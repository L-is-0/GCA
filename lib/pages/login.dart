import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  static const String id = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Login'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}

