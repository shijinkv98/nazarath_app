import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarath_app/helper/constants.dart';

import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/screens/ordercancellation.dart';
import 'package:nazarath_app/screens/tracking.dart';
import 'package:nazarath_app/screens/wishlist.dart';
import 'package:nazarath_app/screens/writereview.dart';

import 'cart.dart';
import 'notification.dart';


class OrderDetailsScreen extends StatefulWidget {
  Data _orderResponse;
  @override
  _OrderDetailsState createState() =>
      new _OrderDetailsState(orderresponse: _orderResponse);
  OrderDetailsScreen(Data response) {
    this._orderResponse = response;
  }
}

class _OrderDetailsState extends State<OrderDetailsScreen> {
  List data;
  List<Data> products;
  Data orderresponse;
  _OrderDetailsState({this.orderresponse});
  Future<String> getData() async {
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    // this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: product_bg,
        appBar: AppBar(
          centerTitle: true,
          // titleSpacing: 100,
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
                      MaterialPageRoute(builder: (context) => WishListScreen()),
                    );
                  },
                  child: Container(
                    height: appTabIconSize,
                    width: appTabIconSize,
                    child: ImageIcon(
                      AssetImage("assets/icons/favorite.png"),
                    ),
                  ),
                )),
          ],
        ),
        body: getOrderDetails(orderresponse, context, widget)
        // _listview(orderresponse?.itemsNew?.
        //     where((element) =>
        //   element != null )
        //   ?.toList(),context,super.widget),
        //);
        // return new Scaffold(
        //   appBar: new AppBar(
        //     title: new Text("Listviews"),
        //   ),
        //   body: new ListView.builder(
        //     itemCount: products == null ? 0 : products.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return new Text(products[index].name);
        //     },
        //   ),
        // );
        );
  }
}

Widget getOrderDetails(
    Data response, BuildContext context, OrderDetailsScreen widget) {
  return Container(
    width: double.infinity,
    child: Column(
      children: [
        getTopContainerOrder(),
        Flexible(child: customScrollView(context, widget, response)),
      ],
    ),
  );
}
Widget getTopContainerOrder()
{
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
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100.0),bottomLeft: Radius.circular(100.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
                child: Container(
                    height: 100,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/icons/inner_banner.png"),
                          fit: BoxFit.fill,
                        )
                    )
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "My Orders",
            style: TextStyle(
                color: Colors.grey[600],fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );

}

Widget customScrollView(
    BuildContext context, OrderDetailsScreen widget, Data response) {
  final _itemExtent = 220.0;
  return CustomScrollView(
    slivers: <Widget>[
      SliverFixedExtentList(
        itemExtent: _itemExtent, // I'm forcing item heights
        delegate: SliverChildBuilderDelegate(
          (context, index) => _itemsBuilder(
              response.itemsNew[index], context, widget, response),
          childCount: response.itemsNew.length,
        ),
      ),
      SliverToBoxAdapter(child: getAddressPanel(response, context, widget)),
      SliverToBoxAdapter(
          child: getOrderSummaryDetails(context, widget, response)),
    ],
  );
}

// Widget _listview(List<ItemsNew> products,BuildContext context,Widget widget) => ListView.builder(
//     padding: EdgeInsets.only(bottom: 70),
//     itemBuilder: (context, index) =>
//         _itemsBuilder(products[index],context,widget),
//     // separatorBuilder: (context, index) => Divider(
//     //       color: Colors.grey,
//     //       height: 1,
//     //     ),
//     itemCount: products.length);
Widget getDeliveryPanel(ItemsNew item, BuildContext context,
    OrderDetailsScreen widget, int payStatus,Data orderData) {
  return Container(
    child: Column(
      children: [
        Container(
          color: colorPrimary,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            children: [
              Image(
                image: new AssetImage("assets/icons/delivery_icon.png"),
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.statusText,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    item.createdAt,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  )
                ],
              )
            ],
          ),
        ),
        getAllButton(context, widget, item, payStatus,orderData),
        getProductReview(context, widget, item),
      ],
    ),
  );
}

Widget getAddressPanel(
    Data orderData, BuildContext context, OrderDetailsScreen widget) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        getAdress("Delivery Address", orderData.billingAddress,
            orderData.billingName, orderData.billingPhone),
        Container(color: item_text_gray, height: 1, width: double.infinity),
        getAdress("Shipping Address", orderData.shippingAddress,
            orderData.shippingName, orderData.shippingPhone),
        Container(color: item_text_gray, height: 1, width: double.infinity),
      ],
    ),
  );
}

Widget getAdress(String title, String address, String name, String mobile) {
  return Container(
    color: product_bg,
    padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                VerticalDivider(
                  thickness: 1,
                ),
                Text(
                  mobile,
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
              address,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget getOrderSummaryDetails(
    BuildContext context, OrderDetailsScreen widget, Data orderData) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.only(bottom: 40, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Order Summary",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: text_tilte_page,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        getTextContainer("Sub Total", '${"AED  "}${orderData.orderTotalAmount}',
            "normal", item_text_gray_light, item_text_gray_light, "normal"),
        getTextContainer(
            "Shipping",
            '${"AED "}${orderData.orderShippingCharge}',
            "normal",
            item_text_gray_light,
            item_text_gray_light,
            "normal"),
        getTextContainer("Total", '${"AED "}${orderData.orderNetTotalAmount}',
            "bold", text_tilte_page, colorRed, "title")
      ],
    ),
  );
}

Widget getAllButton(BuildContext context, OrderDetailsScreen widget,
    ItemsNew item, int payStatus,Data data) {
  return Container(
    color: tab_bg,
    // decoration: BoxDecoration(
    //   color: tab_bg,
    //   border: Border.all(color: item_text_gray, width: 1),
    // ),
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              item.returnPeriod != 0
                  ? GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => TrackingScreen(item.id.toString())),
                        // );
                      },
                      child: Row(
                        children: [
                          getButtonDelivery(context, widget, 0, "Return",
                              "assets/icons/return.png", item),
                          // Container(
                          //   width: 1,
                          //   height: 40,
                          //   color: item_text_gray,
                          // ),
                        ],
                      ),
                    )
                  : Container(),
              payStatus == 0
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderCancelScreen(item: item,data: data,),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getButtonDelivery(context, widget, 1, "Cancel",
                              "assets/icons/remove.png", item),
                          // Container(
                          //   width: 1,
                          //   height: 40,
                          //   color: item_text_gray,
                          // ),
                        ],
                      ),
                    )
                  : Container(),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TrackingScreen(item.id.toString())),
                    );
                  },
                  child: getButtonDelivery(context, widget, 2, "Tracking",
                      "assets/icons/location.png", item)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget getProductReview(
    BuildContext context, OrderDetailsScreen widget, ItemsNew item) {
  return GestureDetector(
    onTap: () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => TrackingScreen(item.id.toString())),
      // );
    },
    child: Container(
      decoration: BoxDecoration(
        color: product_bg,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Rate Product",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: text_tilte_page,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    getStarRating(1)
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WriteReviewScreen(item)),
                    );
                  },
                  child: Text(
                    "Tell us more",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: colorPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // getSa,
              ],
            ),
          ),
          // Divider(thickness: 1,)
        ],
      ),
    ),
  );
}

Widget getStarRating(double rating) {
  return Container(
    height: 20,
    child: RatingBar(
        initialRating: rating,
        direction: Axis.horizontal,
        wrapAlignment: WrapAlignment.start,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 18,
        ratingWidget: RatingWidget(
            full: Icon(Icons.star, color: colorPrimary),
            half: Icon(
              Icons.star_half,
              color: colorPrimary,
            ),
            empty: Icon(
              Icons.star_outline,
              color: colorPrimary,
            )),
        onRatingUpdate: (value) {
          // setState(() {
          //   _ratingValue = value;
          // });
        }),
  );
}

Widget getButtonDelivery(BuildContext context, OrderDetailsScreen widget,
    int type, String title, String icon, ItemsNew orderdata) {
  return Container(
    width: MediaQuery.of(context).size.width/3,
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
    decoration:BoxDecoration(
      border: Border.all(color: item_text_gray)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image(
          image: new AssetImage(icon),
          width: 18,
          height: 18,
          color: item_text_gray,
        ),
        SizedBox(width: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: new TextStyle(
              color: text_tilte_page,
              fontSize: 11,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget _itemsBuilder(ItemsNew item, BuildContext context,
    OrderDetailsScreen widget, Data orderData) {
  return GestureDetector(
      onTap: () {},
      child: Container(
        // margin: const EdgeInsets.only(bottom: 5.0,left: 10.0,top:5,right:10),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInImage.assetNetwork(
                      placeholder: 'assets/images/no_image.png',
                      image: '$productThumbUrl${item.image}',
                      height: 80,
                      width: 120),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          orderData.invoiceNumber,
                          style: TextStyle(color: item_text_gray, fontSize: 8),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: Container(
                            width: 200,
                            child: Text(
                              item.productName,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('$currency${" "}${item.amount}',
                                style: TextStyle(
                                    color: colorRed,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800)),
                            SizedBox(
                              width: 5,
                            ),
                            Text('$currency${" "}${item.amount}',
                                style: TextStyle(
                                    color: item_text_gray_light,
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            getDeliveryPanel(item, context, widget, orderData.paymentStatus,orderData),
          ],
        ),
      ));
}

///
