import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';

class OrderScreen extends StatefulWidget {
  String title;
  OrderScreen(String title)
  {
    this.title=title;
  }
  @override
  _OrderState createState() => new _OrderState(title: title);
}
class _OrderState extends State<OrderScreen> {
  String title;
  _OrderState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarMain(context),
      backgroundColor: Colors.white,
      body: Center(child: Text(title)),
    );
  }

}