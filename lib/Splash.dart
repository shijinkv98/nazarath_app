import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nazarath_app/Constants/dart/constants.dart';
import 'package:nazarath_app/DashBoard.dart';


void main() {
  runApp(MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/DashBoard': (BuildContext context) => new DashBoard()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/DashBoard');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: colorPrimary,
      body: new Center(
        child: Container(
          width: 200,
            height: 80,
            child: new Image.asset('assets/icons/nazarath_logo.png')),
      ),
    );
  }
}