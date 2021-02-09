import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/notification.dart';
import 'package:nazarath_app/screens/wishlist.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cart.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  String title;
  PrivacyPolicyScreen(String title)
  {
    this.title=title;
  }
  @override
  _PrivacyPolicyState createState() => new _PrivacyPolicyState(title: title);
}
class _PrivacyPolicyState extends State<PrivacyPolicyScreen> {
  String title;
  _PrivacyPolicyState({ this.title}) ;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // titleSpacing: 100,
        automaticallyImplyLeading: true,
        title:  Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white ),
        ),
        backgroundColor: colorPrimary,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body:  getPrivacyPolicy(title),
    );
  }
}

Widget getPrivacyPolicy(String link) {
  return WebView(
    initialUrl: link,
  );
}

