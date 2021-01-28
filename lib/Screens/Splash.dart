import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nazarath_app/Screens/register/register.dart';

import '../helper/constants.dart';
import '../network/ApiCall.dart';
import 'DashBoard.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      ApiCall().getUserToken().then((token) => {
        if (token != null && token.trim().isNotEmpty)
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),)
          }
        else
          {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),)}
      });

      // Navigator.of(context)
      //     .pushReplacementNamed("mapPlacePicker", arguments: null);
    });
    return Scaffold(
      body: Container(
        color: colorPrimary,
        child: Center(
          child: Image.asset(
            'assets/icons/nazarath_logo.png',
            height: 80,
            // cacheHeight: 60,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

}