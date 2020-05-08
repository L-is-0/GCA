import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:gca_app/constants.dart';
import 'package:gca_app/main.dart';
import 'package:gca_app/users.dart';
import '../main.dart';

class Login extends StatefulWidget{
  static const String id = "/login";
  static const routeName = '/auth';

  @override
  _LoginState createState() => _LoginState();
}

  class _LoginState extends State<Login>{

   Duration loginTime = Duration(milliseconds: timeDilation.ceil() * 2250);
    Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return  Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHome()));
    });
  }

  Future<String> _signupUser(LoginData data){
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }

      // TODO: NEED TO ADD THE USER TO LIST
      return null;
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
        return _loginUser(loginData);
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

