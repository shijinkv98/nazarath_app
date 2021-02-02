import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/sideDrawer.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
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
        // drawer: SideDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  Center(
                   child: Container(
                     height: 160,
                     decoration: BoxDecoration(
                       color: colorPrimary,
                       borderRadius:
                       BorderRadius.only(bottomRight: Radius.circular(120.0),bottomLeft: Radius.circular(120.0)),
                     ),
                   ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 160,
                        width:320,
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage("assets/icons/homebanner.png"),
                              fit: BoxFit.fill,
                            )
                      )
                      ),
                    ),
                  )
                ],
              ),

            ],

          ),

        ));
  }
}
