import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';

class AddressScreen extends StatefulWidget {
  String title;
  AddressScreen(String title)
  {
    this.title=title;
  }
  @override
  _AddressState createState() => new _AddressState(title: title);
}
class _AddressState extends State<AddressScreen> {
  String title;
  _AddressState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarMain(context),
      backgroundColor: Colors.white,
      body: Center(child: Text('My Page!')),
    );
  }

}