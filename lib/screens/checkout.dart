import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
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
  CartResponse response;
  CheckoutScreen(CartResponse response)
  {
    this.response=response;
  }

  @override
  _CheckoutState createState() => new _CheckoutState(cartResponse: this.response);
}

class _CheckoutState extends State<CheckoutScreen> {
  List data;
  List<Items> products;
  CheckoutResponse Checkoutresponse;
  CartResponse cartResponse;
  _CheckoutState({this.cartResponse});
  Future<String> getData() async {
    Map body = {
      // name,email,phone_number,passwor
    };
    // Checkoutresponse =
    //     await ApiCall().execute<CheckoutResponse, Null>("Checkout/en", body);

    // if (Checkoutresponse != null) {
    //   products = Checkoutresponse.orderId.items;
    //   ApiCall().showToast(Checkoutresponse.message);
    // }
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
        body:customView(context, widget, cartResponse)

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

        );
  }
}
Widget _itemsBuilder(Products product,BuildContext context,Widget widget) {
  bool status = false;
  return GestureDetector(
    onTap: () {

    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 5.0,left: 10.0,top:5,right:10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,

            )]
      ),
      child: Container(
          child:
          Padding(
              padding:
              EdgeInsets.fromLTRB(padding, padding, 0, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/no_image.png',
                    image: '$productThumbUrl${product.image}',
                    width: 120,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 180,
                        child:Flexible(
                            child: Text(
                              product.name,
                              style: TextStyle(
                                  color: Colors.black,fontSize: 12, fontWeight: FontWeight.w500),
                            )) ,)
                      ,
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text('${product.symbolLeft}${" "}${product.price}${product.symbolRight}',style: TextStyle(
                              color: colorRed,fontSize: 11,fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('${product.symbolLeft}${" "}${product.oldprice}${product.symbolRight}',style: TextStyle(
                              color: Colors.grey,fontSize: 11,decoration: TextDecoration.lineThrough)),
                        ],
                      ),


                    ],
                  )
                ],
              )
          )

      ),
    ),
  );


}

Widget customView(BuildContext context,Widget widget,CartResponse cartResponse)
{
  final _itemExtent = 120.0;
  return CustomScrollView(
    slivers: <Widget>[
      SliverToBoxAdapter(
        child:    getTopContainer(),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverFixedExtentList(
        itemExtent: _itemExtent,  // I'm forcing item heights
        delegate: SliverChildBuilderDelegate(
              (context, index) => _itemsBuilder(cartResponse.products[index],context,widget),
          childCount: cartResponse.products.length,
        ),
      ),

      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
        child:    _tabSection(context,widget,cartResponse),
      ),
      SliverToBoxAdapter(
        child:    Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Divider(
            color: product_bg,
            thickness: 2,
          ),
        ),
      ),
      SliverToBoxAdapter(
        child:   getAdress("Delivery Address")
      ),
      SliverToBoxAdapter(
        child:    Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Divider(
            color: product_bg,
            thickness: 2,
          ),
        ),
      ),
      SliverToBoxAdapter(
          child:   getAdress("Shipping Address")
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
        child:    getPaymentOptions(),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
        child:    getDetails(context, widget, cartResponse)
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
      SliverToBoxAdapter(
          child:    getButtonContinue()
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 10.0),
      ),
    ],
  );
}
Widget getCheckout(BuildContext context,Widget widget,CartResponse cartResponse) {
  return Container(
    child: Column(
      children: [
        getTopContainer(),
       // getProductDetails(context,widget,cartResponse),

        // getTab()
      ],
    ),
  );
}

// Widget getProductDetails(BuildContext context,Widget widget,CartResponse cartResponse) {
//
// }

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

Widget _tabSection(BuildContext context,Widget widget,CartResponse cartResponse) {
  return DefaultTabController(
    length: 2,
    child: Column(
      mainAxisSize: MainAxisSize.min,
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



                    ],
                  ),
                ),
              ),
            ),

            MyStatefulWidget()
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
Widget getPaymentOptions()
{
  return
    Column(
      children: [
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
      ],

    );
}
Widget getShippingAdress()
{

}
Widget getAdress(String title)
{
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 25),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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
  );
}
Widget getButtonContinue()
{
  return Row(
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
  );
}
// Widget getUpload(){
//   return Container
// }

///
