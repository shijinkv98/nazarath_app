import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';

void main() => runApp(Home());

class Home extends StatelessWidget  {
  final appTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  AppLifecycleState _notification;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: Text('My Page!')),
        );
  }


}
