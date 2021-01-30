import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'cart.dart';
import 'notification.dart';

class ProductDetailsScreen extends StatefulWidget {
  String title;
  ProductDetailsScreen(String title)
  {
    this.title=title;
  }
  @override
  _ProductDetailsState createState() => new _ProductDetailsState(title: title);
}
class _ProductDetailsState extends State<ProductDetailsScreen> {
  String title;
  _ProductDetailsState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:getAppBarMain(context),
      backgroundColor: Colors.white,
      body: Center(child: Text(title)),
    );
  }

}