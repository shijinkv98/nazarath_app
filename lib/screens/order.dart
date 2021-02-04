import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'dart:convert';

import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/screens/orderdetails.dart';
import 'package:nazarath_app/screens/wishlist.dart';
import 'package:nazarath_app/screens/DashBoard.dart';
import 'notification.dart';
// void main() {
//   runApp(Order(
//     items: List<ListItem>.generate(
//       1000,
//           (i) => i % 6 == 0
//           ? HeadingItem("Heading $i")
//           : MessageItem("Sender $i", "Message body $i"),
//     ),
//   ));
// }
class OrderScreen extends StatefulWidget {
  @override
  _OrderState createState() => new _OrderState();
}
class _OrderState extends State<OrderScreen> {
  List data;
  List<Data> products;
  OrderResponse Orderresponse;
  Future<String> getData() async {
    //
    // Map body = {
    //   // name,email,phone_number,passwor
    // };
    // Orderresponse = await ApiCall()
    //     .execute<OrderResponse, Null>("my-orders/en", body);
    //
    // if (Orderresponse != null) {
    //   products=Orderresponse.result.data;
    //   ApiCall().showToast(Orderresponse.message);
    // }
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    //this.getData();
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
      body: FutureBuilder<OrderResponse>(
        future: ApiCall()
            .execute<OrderResponse, Null>('my-orders/en', null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('products size: ${snapshot.data?.result.data?.length}');
            return getOrderScreen(snapshot.data?.result?.data
                ?.where((element) =>
            element != null )
                ?.toList(),context,super.widget);
          } else if (snapshot.hasError) {
            return getEmptyContainerOrder(context);
          } else {
            return progressBar;
          }
        },
      ),
    );
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
  }
}
List<Data> allOrders;
Widget getOrderScreen(List<Data> orders,BuildContext context,Widget widget)
{
  allOrders=new List<Data>();
  if(orders==null)
    return getEmptyContainerOrder(context);
  else if(orders.length==0)
    return getEmptyContainerOrder(context);
  allOrders=orders;
  return getFullOrderScreen(orders,context,widget);
}
Data getOrderDetails(ItemsNew item)
{
  for(int i=0;i<allOrders.length;i++)
  {
    for(int j=0;j<allOrders[i].itemsNew.length;j++)
    {
      ItemsNew itemsNew=allOrders[i].itemsNew[j];
      if(item.orderId==itemsNew.orderId)
        return  allOrders[i];
    }
  }
  return new Data();
}
Widget getFullOrderScreen(List<Data> orders,BuildContext context,Widget widget)
{
  List<ItemsNew> items=new List<ItemsNew>();
  for(int i=0;i<orders.length;i++)
    {
      for(int j=0;j<orders[i].itemsNew.length;j++)
        {
          items.add(orders[i].itemsNew[j]);
        }
    }
  return Container(
    child: Container(width: double.infinity,
      child: Column(

        children: [
          getTopContainer(),
          Flexible(
            child: _listview(items,context,widget),

          ),
        ],
      ),

    ),
  );
}
Widget _listview(List<ItemsNew> items,BuildContext context,Widget widget) => ListView.builder(
    padding: EdgeInsets.only(bottom: 70),
    itemBuilder: (context, index) =>
        _itemsBuilder(items[index],context,widget),
    // separatorBuilder: (context, index) => Divider(
    //       color: Colors.grey,
    //       height: 1,
    //     ),
    itemCount: items.length);

Widget _itemsBuilder(ItemsNew item,BuildContext context,Widget widget) {
  bool status = false;
  Data orderData=getOrderDetails(item);
  return  GestureDetector(
      onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderData)),
    );
  },
  child:Container(
    margin: const EdgeInsets.only(bottom: 8.0,left: 10.0,top:10,right:20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3.0,
        ),
      ],
    ),
    child: Column(
      children: [
        Padding(
          padding:
          EdgeInsets.fromLTRB(padding, padding, 0, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/no_image.png',
                image: '$productThumbUrl${item.image}',
                width: 100,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      orderData.invoiceNumber,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500,fontSize: 11),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      item.productName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('${item.amount}}',style: TextStyle(
                            color: colorRed,fontSize: 12,fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),

                  ],
                ),
              ),

            ],

          ),

        ),


        Divider(
          height: 2,
          color: Colors.grey,
        ),

      ],
    ),
  )
  );
}
Container getTopContainer()
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
Container getEmptyContainerOrder(BuildContext context)
{
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
                "Your Order is Empty",
                style: TextStyle(
                    color: Colors.grey[500],fontSize: 16,fontWeight: FontWeight.bold),
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


///