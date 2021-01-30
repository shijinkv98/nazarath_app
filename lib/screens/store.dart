import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';

class StoreScreen extends StatefulWidget {
  String title;
  StoreScreen(String title)
  {
    this.title=title;
  }
  @override
  _StoreState createState() => new _StoreState(title: title);
}
class _StoreState extends State<StoreScreen> {
  String title;
  _StoreState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarMain(context),
      backgroundColor: Colors.white,
      body: Center(child: Text(title)),
    );
  }

}