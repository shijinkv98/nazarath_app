import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/CouponResponse.dart';
import 'dart:convert';

import 'package:nazarath_app/network/response/WishListResponse.dart';

import 'DashBoard.dart';
import 'cart.dart';
import 'notification.dart';
// void main() {
//   runApp(WishList(
//     items: List<ListItem>.generate(
//       1000,
//           (i) => i % 6 == 0
//           ? HeadingItem("Heading $i")
//           : MessageItem("Sender $i", "Message body $i"),
//     ),
//   ));
// }
class WishListScreen extends StatefulWidget {
  @override
  _WishListState createState() => new _WishListState();
}
class _WishListState extends State<WishListScreen> {
  List data;
  List<Products> products;
  WishListResponse wishlistresponse;
  Future<String> getData() async {

    Map body = {
      // name,email,phone_number,passwor
    };
    wishlistresponse = await ApiCall()
        .execute<WishListResponse, Null>("wishlist/en", body);

    if (wishlistresponse != null) {
      products=wishlistresponse.products;
      ApiCall().showToast(wishlistresponse.message);
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
        appBar:AppBar(
          centerTitle: true,
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
        ),

    body: FutureBuilder<WishListResponse>(
    future: ApiCall()
        .execute<WishListResponse, Null>('wishlist/en', null),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    debugPrint('products size: ${snapshot.data?.products?.length}');
    return getWishListFull(snapshot.data?.products
        ?.where((element) =>
    element != null )
        ?.toList(),context,super.widget);
    } else if (snapshot.hasError) {
    return getEmptyContainerWishlist(context);
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

Widget _listview(List<Products> products,BuildContext context,Widget widget) => ListView.builder(
    padding: EdgeInsets.only(bottom: 70),
    itemBuilder: (context, index) =>
        _itemsBuilder(products[index],context,widget),
    // separatorBuilder: (context, index) => Divider(
    //       color: Colors.grey,
    //       height: 1,
    //     ),
    itemCount: products.length);

Widget _itemsBuilder(Products product,BuildContext context,Widget widget) {
  bool status = false;

  return Container(
    margin: const EdgeInsets.only(bottom: 5.0,left: 10.0,top:5,right:10),
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
                image: '$productThumbUrl${product.image}',
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
                      product.name,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text('${product.symbolLeft}${" "}${product.price}${product.symbolRight}',style: TextStyle(
                            color: colorRed,fontSize: 12,fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${product.symbolLeft}${" "}${product.oldprice}${product.symbolRight}',style: TextStyle(
                            color: Colors.grey,fontSize: 12,decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    Row(
                      children: [
                        BagButton(product.slug, product.store, context, widget),
                        SizedBox(
                          width: 2,
                        ),
                        removeButton(product.slug, product.store, context, widget),
                      ],
                    )
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
  );

}

Future<String>removeFromWishList(String slug,String store,BuildContext context,Widget widget) async {

  Map body = {
    "slug":slug,
    "quantity":"0",
    "store":store
  };
  WishListResponse wishlistresponse = await ApiCall()
      .execute<WishListResponse, Null>("wishlist/add/en", body);

  if (wishlistresponse != null) {
    ApiCall().showToast(wishlistresponse.message);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Future<String> movetoCart(String slug,String store,BuildContext context,Widget widget) async {

  Map body = {
    "slug":slug,
    "quantity":"1",
  "store":store
  };
  WishListResponse wishlistresponse = await ApiCall()
      .execute<WishListResponse, Null>("wishlist/move/en", body);

  if (wishlistresponse != null) {
    ApiCall().showToast(wishlistresponse.message);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
  return "Success!";
}

Container getWishListFull(List<Products> products,BuildContext context,Widget widget)
{
  return Container(
    child: Container(width: double.infinity,
      child: Column(

        children: [
          getTopContainer(),
          Flexible(
            child: _listview(products,context,widget),

          ),
        ],
      ),

    ),
  );
  //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);

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
            "Your WishList",
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
GestureDetector BagButton(String slug,String store,BuildContext context,Widget widget)
{
  return GestureDetector(
      onTap: () {
        movetoCart(slug,store,context,widget);
      },
      child: Container(
        color: colorPrimary,
        child: Row(
          children: [
            Image.asset("assets/icons/bag.png",height: 14,),
            Text(
              "Move to bag",
              style: TextStyle(
                  color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),
            )
          ],
        ),
      )
  );

}
GestureDetector removeButton(String slug,String store,BuildContext context,Widget widget)
{
  return GestureDetector(
      onTap: () {
        removeFromWishList(slug,store,context,widget);
  },
  child: Container(
    decoration: BoxDecoration(
        border: Border.all(width: 2, color:colorPrimary)),
      child: Row(
        children: [
          Image.asset("assets/icons/remove.png",height: 14,),
          Text(
            "Remove",
            style: TextStyle(
                color: colorPrimary,fontSize: 12,fontWeight: FontWeight.bold),
          )
        ],
      ),
  )
  );

}
Container getEmptyContainerWishlist(BuildContext context)
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
                "Your WishList is Empty",
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