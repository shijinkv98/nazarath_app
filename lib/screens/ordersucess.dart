import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/response/CheckoutResponse.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import 'DashBoard.dart';

// ignore: must_be_immutable
class orderSucessScreen extends StatefulWidget {
  CheckoutResponse response;
  orderSucessScreen(CheckoutResponse response)
  {
    this.response=response;
  }
  @override
  _OrderSucessState createState() => new _OrderSucessState(response: response);
}
class _OrderSucessState extends State<orderSucessScreen> {
  CheckoutResponse response;
  _OrderSucessState({ this.response}) ;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  getOrderSucess(response,context),
    );
  }
}

Widget getOrderSucess(CheckoutResponse response,BuildContext context) {
  return Container(
      height: double.infinity,
      child: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                "assets/icons/empty_cart.png",height: 50,),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'SUCCESS',
                style: TextStyle(
                    color: Colors.grey[500],fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  '${"Your Order Number is "}${response.orderId!=null?response.orderId.id:""}',
                  style: TextStyle(
                      color: Colors.grey[500],fontSize: 16,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
                elevation: 0.0,
                borderRadius: BorderRadius.circular(5.0),
                color: colorPrimary,
                child: MaterialButton(
                  minWidth: 100,
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),);
                  },

                  child: Text("Continue Shopping",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,fontSize: 13,fontWeight: FontWeight.normal)),
                )
            ),
          ],),
      )
  );

}

