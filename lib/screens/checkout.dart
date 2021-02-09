import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'dart:convert';

import 'package:nazarath_app/network/response/CheckoutResponse.dart';
import 'package:nazarath_app/network/response/ProductDetailsResponse.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'cart.dart';
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
    Checkoutresponse =
        await ApiCall().execute<CheckoutResponse, Null>("Checkout/en", body);

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
          automaticallyImplyLeading: true,
          title: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
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
                    child: ImageIcon(
                      AssetImage("assets/icons/search.png"),
                    ),
                  ),
                )),

            Padding(
                padding: const EdgeInsets.only(right: appTabIconPad),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotificationScreen("notification")),
                    );
                  },
                  child: Container(
                    height: appTabIconSize,
                    width: appTabIconSize,
                    child: ImageIcon(
                      AssetImage("assets/icons/notification.png"),
                    ),
                  ),
                )),

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
                  child: ImageIcon(
                    AssetImage("assets/icons/cart.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                getCheckout(),
                _tabSection(context),
              ],
            ),

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
          ),
        ));
  }
}

Widget getCheckout() {
  return Container(
    child: Column(
      children: [
        getTopContainer(),
        getProductDetails(),

        // getTab()
      ],
    ),
  );
}

Widget getProductDetails() {
  return Container(
    height: 150,
    color: Colors.red,
  );
}

Container getTopContainer() {
  return Container(
    child: Column(
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100.0),
                      bottomLeft: Radius.circular(100.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Container(
                    height: 100,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      image: new AssetImage("assets/icons/inner_banner.png"),
                      fit: BoxFit.fill,
                    ))),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Checkout",
            style: TextStyle(
                color: text_tilte_page,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

Widget _tabSection(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child:
              TabBar(labelColor: textColor, indicatorColor: product_bg, tabs: [
            Tab(text: "Upload Prescription"),
            Tab(text: "Eye Power enter manually"),
          ]),
          color: Colors.white,
        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height,
          child: TabBarView(children: [
            Container(
              child: Container(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 25),
                        child: Row(
                          children: [
                            Container(
                              child: SizedBox(
                                width: 140,
                                height: 40,
                                child: RaisedButton(
                                  color: colorPrimary,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('Upload',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'myprescription.pdf',
                                style:
                                    TextStyle(color: textColor, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 40),
                        child: Text(
                          '(upload pdf,jpg,png format)',
                          style: TextStyle(color: textColor, fontSize: 9),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Divider(
                          color: product_bg,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 25),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery Address',
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Muhd.Shafeeque',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    VerticalDivider(
                                      thickness: 1,
                                    ),
                                    Text(
                                      '+9845561223',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Delivery Address Muhd.Shafeeque Muhd.ShafeequeMuhd.Shafeeque Muhd.Shafeeque',
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  child: SizedBox(
                                    height: 40,
                                    child: RaisedButton(
                                      color: colorPrimary,
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Change or Add Address',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white)),
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Divider(
                          color: product_bg,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 25),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Address',
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Muhd.Shafeeque',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    VerticalDivider(
                                      thickness: 1,
                                    ),
                                    Text(
                                      '+9845561223',
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'Delivery Address Muhd.Shafeeque Muhd.ShafeequeMuhd.Shafeeque Muhd.Shafeeque',
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  child: SizedBox(
                                    height: 40,
                                    child: RaisedButton(
                                      color: colorPrimary,
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('Change or Add Address',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white)),
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Divider(
                          color: product_bg,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 25),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Options',
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      MyStatefulWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40, right: 20),
                            child: Container(
                              child: SizedBox(
                                width: 150,
                                height: 40,
                                child: RaisedButton(
                                  color: colorPrimary,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Continue',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white)),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(

              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 15),
                        child: Text('Upload Prescription',style:TextStyle(fontSize: 15,color: textColor,fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Container(

                            child: SizedBox(
                              width: 140,
                              height: 40,
                              child: RaisedButton(
                                color: colorPrimary,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Upload',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white)),
                                ),
                                onPressed: () async {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'myprescription.pdf',
                              style:
                              TextStyle(color: textColor, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,left: 10),
                        child: Text(
                          '(Upload pdf,png,jpg format)',
                          style:
                          TextStyle(color: textColor, fontSize: 10,fontStyle: FontStyle.italic),
                        ),
                      ),

                    ],
                  ),

                ),


              ),


            ),

          ]),
        ),
      ],
    ),
  );
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

enum BestTutorSite { cashondelivery, onlinepayment, debit, paytm }

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  BestTutorSite _site = BestTutorSite.cashondelivery;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            height: 30,
            child: ListTile(
              title: const Text('Cash on Delivery'),
              leading: Radio(
                value: BestTutorSite.cashondelivery,
                activeColor: colorPrimary,
                groupValue: _site,
                onChanged: (BestTutorSite value) {
                  setState(() {
                    _site = value;
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 30,
            child: ListTile(
              title: const Text('Online Payment'),
              leading: Radio(
                activeColor: colorPrimary,
                value: BestTutorSite.onlinepayment,
                groupValue: _site,
                onChanged: (BestTutorSite value) {
                  setState(() {
                    _site = value;
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 30,
            child: ListTile(
              title: const Text('Debit/Credit Card'),
              leading: Radio(
                activeColor: colorPrimary,
                value: BestTutorSite.debit,
                groupValue: _site,
                onChanged: (BestTutorSite value) {
                  setState(() {
                    _site = value;
                  });
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 30,
            child: ListTile(
              title: const Text('Paytm'),
              leading: Radio(
                activeColor: colorPrimary,
                value: BestTutorSite.paytm,
                groupValue: _site,
                onChanged: (BestTutorSite value) {
                  setState(() {
                    _site = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget getUpload(){
//   return Container
// }

///
