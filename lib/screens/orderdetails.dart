import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'dart:convert';
import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/screens/order.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'notification.dart';
// void main() {
//   runApp(OrderDetails(
//     items: List<ListItem>.generate(
//       1000,
//           (i) => i % 6 == 0
//           ? HeadingItem("Heading $i")
//           : MessageItem("Sender $i", "Message body $i"),
//     ),
//   ));
// }
class OrderDetailsScreen extends StatefulWidget {
  Data _orderResponse;
  @override
  _OrderDetailsState createState() => new _OrderDetailsState(orderresponse: _orderResponse);
  OrderDetailsScreen(Data response)
  {
    this._orderResponse=response;
  }
}
class _OrderDetailsState extends State<OrderDetailsScreen> {
  List data;
  List<Data> products;
  Data orderresponse;
  _OrderDetailsState({ this.orderresponse}) ;
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

        ],
      ),
      body:  getOrderDetails(orderresponse, context, widget)
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
Widget getOrderDetails(Data response,BuildContext context,Widget widget)
{
  return Container(width: double.infinity,
    child: Column(

      children: [
        getTopContainerOrder(),
        Flexible(
            child: customScrollView(context, widget, response)
        ),
      ],
    ),

  );
}

Widget customScrollView(BuildContext context,Widget widget,Data response)
{
  final _itemExtent = 100.0;
  return CustomScrollView(
    slivers: <Widget>[
      SliverFixedExtentList(
        itemExtent: _itemExtent,  // I'm forcing item heights
        delegate: SliverChildBuilderDelegate(
              (context, index) => _itemsBuilder(response.itemsNew[index],context,widget,response),
          childCount: response.itemsNew.length,
        ),
      ),
      SliverToBoxAdapter(
          child: getDeliveryPanel(response,context,widget)
      )
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
Widget getDeliveryPanel(Data orderData,BuildContext context,Widget widget)
{
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Container(
          color: colorPrimary,
          padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
          child: Row(
            children: [
              Image(
                image: new AssetImage("assets/icons/cart.png"),
                width: 20,
                height: 20,
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderData.orderStatus,
                    style: TextStyle(
                        color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    orderData.updatedAt,
                    style: TextStyle(
                        color: Colors.white,fontSize: 10),
                  )

                ],
              )

            ],
          ),
        ),
        getAllButton(context, widget, orderData),
        getAdress("Delivery Address",orderData.billingAddress,orderData.billingName,orderData.billingPhone),
        Divider(thickness: 1,),
        getAdress("Shipping Address",orderData.shippingAddress,orderData.shippingName,orderData.shippingPhone),
        Divider(thickness: 1,),


      ],
    ),
  );
}
Widget getAdress(String title,String address,String name,String mobile)
{
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 20),
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
Widget getAllButton(BuildContext context,Widget widget, Data orderdata)
{
  return Container(

    decoration: BoxDecoration(

        color: product_bg,
        border: Border.all( color: item_text_gray,width: 1),

    ),

    child: Column(
      
      children: [
        Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getButtonDelivery(context, widget, 0, "Return", "assets/icons/cart.png", orderdata),
              Container(
                width: 1,
                height:40,
                color: item_text_gray,
              ),
              getButtonDelivery(context, widget, 1, "Cancel", "assets/icons/remove.png", orderdata),
              Container(
                width: 1,
                height:40,
                color: item_text_gray,
              ),
              getButtonDelivery(context, widget, 2, "Tracking", "assets/icons/location.png", orderdata),
            ],
          ),
        ),
      ],
    ),
  );
}
Widget getButtonDelivery(BuildContext context,Widget widget,int type,String title,String icon,Data orderdata)
{
  return GestureDetector(
    onTap:(){},
    child: Container(
      padding: EdgeInsets.only(top:10,bottom: 10,left: 10,right: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: new AssetImage(icon),
            width: 18,
            height: 18,
            color: item_text_gray,
          ),
          SizedBox(width:5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: text_tilte_page,fontSize: 11,fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
Widget _itemsBuilder(ItemsNew item,BuildContext context,Widget widget,Data orderData) {
  return  GestureDetector(
      onTap: () {
      },
      child:Container(
       // margin: const EdgeInsets.only(bottom: 5.0,left: 10.0,top:5,right:10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
              )]
        ),
        child: Column(
          children: [
            Padding(
              padding:
              EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/no_image.png',
                    image: '$productThumbUrl${item.image}',
                    height:80,
                    width:120
                  ),
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
                          style: TextStyle(
                              color: item_text_gray,fontSize: 8),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(

                          child: Container(
                            width: 200,
                            child: Text(
                              item.productName,
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w500,fontSize: 10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('$currency${" "}${item.amount}',style: TextStyle(
                                color: colorRed,fontSize: 11,fontWeight: FontWeight.w800)),
                            SizedBox(
                              width: 5,
                            ),
                            Text('$currency${" "}${item.amount}',style: TextStyle(
                                color: item_text_gray_light,fontSize: 11,decoration: TextDecoration.lineThrough))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),

                ],

              ),

            ),


          ],
        ),
      )
  );
}




///