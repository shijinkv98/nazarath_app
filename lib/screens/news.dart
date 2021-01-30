import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';

class NewsScreen extends StatefulWidget {
  String title;
  NewsScreen(String title)
  {
    this.title=title;
  }
  @override
  _NewsState createState() => new _NewsState(title: title);
}
class _NewsState extends State<NewsScreen> {
  String title;
  _NewsState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarMain(context),
      backgroundColor: Colors.white,
      body: Center(child: Text(title)),
    );
  }

}