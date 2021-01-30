import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';

class CheckUpScreen extends StatefulWidget {
  String title;
  CheckUpScreen(String title)
  {
    this.title=title;
  }
  @override
  _CheckUpState createState() => new _CheckUpState(title: title);
}
class _CheckUpState extends State<CheckUpScreen> {
  String title;
  _CheckUpState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarMain(context),
      backgroundColor: Colors.white,
      body: Center(child: Text(title)),
    );
  }

}