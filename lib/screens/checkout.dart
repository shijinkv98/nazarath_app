import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'dart:convert';

import 'package:nazarath_app/network/response/CheckoutResponse.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'notification.dart';
// void main() {
//   runApp(Checkout(
//     items: List<ListItem>.generate(
//       1000,
//           (i) => i % 6 == 0
//           ? HeadingItem("Heading $i")
//           : MessageItem("Sender $i", "Message body $i"),
//     ),
//   ));
// }
class CheckoutScreen extends StatefulWidget {
  CheckoutScreen(String s);

  @override
  _CheckoutState createState() => new _CheckoutState();
}
class _CheckoutState extends State<CheckoutScreen> {
  List data;
  List<Items> products;
  CheckoutResponse Checkoutresponse;

  Future<String> getData() async {
    Map body = {
      // name,email,phone_number,passwor
    };
    Checkoutresponse = await ApiCall()
        .execute<CheckoutResponse, Null>("Checkout/en", body);

    if (Checkoutresponse != null) {
      products = Checkoutresponse.orderId.items;
      ApiCall().showToast(Checkoutresponse.message);
    }
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // titleSpacing: 100,
          automaticallyImplyLeading: true,
          title: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: appTabBottom, top: appTabTop),
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
                      MaterialPageRoute(builder: (context) =>
                          NotificationScreen("notification")),
                    );
                  },
                  child: Container(
                    height: appTabIconSize,
                    width: appTabIconSize,
                    child: ImageIcon(
                      AssetImage("assets/icons/notification.png"),),
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

          ],
        ),
        body: Container(
            child: getCheckout()
          // FutureBuilder<CheckoutResponse>(
          //   future: ApiCall()
          //       .execute<CheckoutResponse, Null>('Checkout/en', null),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       debugPrint('products size: ${snapshot.data?.orderId?.items?.length}');
          //       return _listview(snapshot.data?.orderId?.items
          //           ?.where((element) =>
          //       element != null )
          //           ?.toList(),context,super.widget);
          //     } else if (snapshot.hasError) {
          //       return errorScreen('Error: ${snapshot.error}');
          //     } else {
          //       return progressBar;
          //     }
          //   },
          // ),
        )
    );
  }
}
Widget getCheckout(){
  return Container(
    child: Column(
      children: [
        getProductDetails()

      ],
    ),
  );
}
Widget getProductDetails(){
  return Container(

  );
}


///