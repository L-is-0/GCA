// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gca_app/pages/login.dart';
import 'package:gca_app/pages/register.dart';
import 'package:gca_app/pages/settings.dart';
import 'package:gca_app/pages/sorting.dart';
import 'package:gca_app/pages/square.dart';
import 'package:gca_app/pages/tips.dart';
import 'package:gca_app/pages/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      routes: {
        Login.id:(context) => Login(),
        Register.id:(context) => Register(),
        Sorting.id:(context) => Sorting(),
        Tips.id:(context) => Tips(),
        Square.id:(context) => Square(),
        Setting.id:(context) => Setting(),
        Profile.id:(context) => Profile()
      },
    );
  }
}
