import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nazarath_app/screens/cart.dart';
import 'package:nazarath_app/screens/notification.dart';
import 'package:nazarath_app/screens/wishlist.dart';

const Color colorPrimary = Color(0xFF45ccc1);
const Color colorRed =const Color.fromRGBO(239, 89, 30, 1.0);
const Color product_bg =const Color.fromRGBO(233, 233, 233, 1.0);
const Color text_tilte_page =const Color.fromRGBO(108, 108, 108, 1.0);
const Color item_text_gray =const Color.fromRGBO(174, 174, 174, 1.0);
const Color item_text_gray_light =const Color.fromRGBO(201, 201, 201, 1.0);

const Color textColor = Color(0xFF616161);
const Color textColorSecondary = Color(0xFF999999);
const String BASE_URL = "https://alranna.alisonsdemo.tk/";
const Color gradientEnd = Color(0xFF45ccc1);
const Color primaryTextColor = Color(0xFF45ccc1);
const Color primaryIconColor = Color(0xFF45ccc1);

const String productThumbUrl = '${BASE_URL}images/product/thumbnail/';
const String categoryThumbUrl = '${BASE_URL}images/category/thumbnail/';

const double padding = 10.0;
const contryCode = 971;
const double appTabIconSize=20.0;
const double appTabTop=0;
const double appTabBottom=20;
const double appTabIconPad=3;

const double appTabLeft=0;
const double appTabRight=0;
const double appTabImageSize=90.0;
const double register_icon_size=16.0;
const double font_size_head=16.0;
const double field_text_size=10.0;
const double primary_margin=40.0;
const double space=15.0;
const double space2=30.0;
const double header_text_size=16.0;
const double border_radius=65.0;
const double forms_padding=25.0;
const double header_padding=25.0;
const double normal_space=10.0;
const double register_logo_size=80.0;
const double container_space=40.0;
const double button_text_size=14.0;
String deviceToken = "";
String deviceId = "";
String currency = "AED";

// public static final String PRODUCT_URL = MAIN_URL + "images/product/";
// public static final String BANNER_URL = MAIN_URL + "images/banner/";

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

Widget errorScreen(String errorTitle) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(errorTitle),
      )
    ],
  ),
);
Widget progressBar = InkWell(
  child: SafeArea(
    child: Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
        width: 60,
        height: 60,
      ),
    ),
  ),
);
AppBar getAppBarMain(BuildContext context)
{
  AppBar(
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
                MaterialPageRoute(builder: (context) => NotificationScreen("notification")),
              );
            },
            child: Container(
              height: appTabIconSize,
              width: appTabIconSize,
              child: ImageIcon(AssetImage("assets/icons/notification.png"),),
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
  );
}

AppBar getAppBarNotification(BuildContext context)
{

}

