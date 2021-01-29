import 'dart:ui';

import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xFF45ccc1);
const Color textColor = Color(0xFF616161);
const Color textColorSecondary = Color(0xFF999999);
const String BASE_URL = "https://alranna.alisonsdemo.tk/";
const Color gradientEnd = Color(0xFF45ccc1);
const Color primaryTextColor = Color(0xFF45ccc1);
const Color primaryIconColor = Color(0xFF45ccc1);

const String productThumbUrl = '${BASE_URL}images/product/thumbnail/';
const double padding = 10.0;
const contryCode = 971;
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
String currency = "";

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