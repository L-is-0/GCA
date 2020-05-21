import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:gca_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gca_app/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../data/users.dart';
import '../main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final dbRef = FirebaseDatabase.instance.reference().child("profiles");

class Login extends StatefulWidget{
  static const String id = "/login";
  static const routeName = '/auth';

  @override
  _LoginState createState() => _LoginState();
}

  class _LoginState extends State<Login>{
    bool _signup;
    Duration loginTime = Duration(milliseconds: timeDilation.ceil() * 2250);

    Future<String> _loginUser(LoginData data) async {
      FirebaseUser user;
      String errorMessage;
      AuthResult result = await _auth.signInWithEmailAndPassword(email: data.name, password: data.password).catchError((e){errorMessage=e.message;});
      if(result!=null){
        user = result.user;
        return  Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home()
        ));
//        return user.uid;
      }else{
        return errorMessage;
      }
  }

  Future<String> _signupUser(LoginData data){
    FirebaseUser user;
    String errorMessage;
    return Future.delayed(loginTime).then((_) async {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: data.name, password: data.password).catchError((e){errorMessage=e.message;});
      if(result!=null){
        user = result.user;
       _addUserTodb(user.uid, user.email);
        return  Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()
        ));
      }else{
      return errorMessage;
      }
    });
  }

    Future<String> _addUserTodb(String uid, String email) {
      dbRef.child(uid).set({
        "email": email,
        "points": 0,
        "username" : "null"
      }).then((_) {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Successfully Added')));
      }).catchError((onError) {
        print(onError);
      });
    }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username does not exists';
      }
      //TODO: UPDATE PASSWORD WITH THE USERNAME
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: Constants.appName,
      logo: 'assets/images/ecorp.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
       messages: LoginMessages(
         usernameHint: 'Username',
         passwordHint: 'Password',
         confirmPasswordHint: 'Confirm',
         loginButton: 'LOG IN',
         signupButton: 'REGISTER',
         forgotPasswordButton: 'Forgot your password?',
         recoverPasswordButton: 'RECOVER IT',
         goBackButton: 'GO BACK',
         confirmPasswordError: 'Not match!',
         recoverPasswordIntro: 'Don\'t feel bad. It happens all the time.',
         recoverPasswordDescription: 'Please enter your registed email address to reset your password',
         recoverPasswordSuccess: 'Password rescued successfully',
       ),
      emailValidator: (value) {
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (loginData) {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _signupUser(loginData);
      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: false,
    );
  }
}

