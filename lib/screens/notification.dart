
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'cart.dart';

class NotificationScreen extends StatefulWidget {
  String title;
  NotificationScreen(String title)
  {
    this.title=title;
  }
  @override
  _NotificationState createState() => new _NotificationState(title: title);
}
class _NotificationState extends State<NotificationScreen> {
  String title;
  _NotificationState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // titleSpacing: 100,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
        title: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
            child: ImageIcon(
              AssetImage("assets/icons/nazarath_logo.png"),
              size: appTabImageSize,
            ),
          ),
        ),
        backgroundColor: colorPrimary,
        elevation: 0,

        actions: <Widget>[
          // ImageIcon(AssetImage("assets/icons/nazarath_logo.png"),size: 100,)
          Padding(
              padding: const EdgeInsets.only(right: appTabIconPad),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Search(product.name)),
                  // );
                },
                child: Container(
                  height: appTabIconSize,
                  width: appTabIconSize,
                  child: ImageIcon(AssetImage("assets/icons/search.png"),),
                ),
              )
          ),

          Padding(
              padding: const EdgeInsets.only(right: appTabIconPad),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WishListScreen()),
                  );
                },
                child: Container(
                  height: appTabIconSize,
                  width: appTabIconSize,
                  child: ImageIcon(AssetImage("assets/icons/favorite.png"),),
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(right: appTabIconPad),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Container(
                height: appTabIconSize,
                width: appTabIconSize,
                child: ImageIcon(AssetImage("assets/icons/cart.png"),),
              ),
            ),
          ),

        ],
      ),
      backgroundColor: Colors.white,
      body: Center(child: Text('My Page!')),
    );
  }

}