import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
// import 'package:nazarath_app/network/response/CouponResponse.dart';
// import 'dart:convert';

import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/notifiers/wishlistnotifier.dart';
import 'package:nazarath_app/screens/searchscreen.dart';
import 'package:provider/provider.dart';

import '../languages.dart';
import 'DashBoard.dart';
import 'ProductDetails.dart';
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
  WishListUpdatedNotifier _updateNotifier;
  Future<String> getData() async {

    Map body = {
      // name,email,phone_number,passwor
    };
    wishlistresponse = await ApiCall()
        .execute<WishListResponse, Null>("wishlist/"+selectLanguage, body);

    if (wishlistresponse != null) {
      products=wishlistresponse.products;
      ApiCall().showToast(wishlistresponse.message);
    }
    return "Success!";
  }
  @override
  void dispose() {
    _updateNotifier.reset();
    super.dispose();
  }
  @override
  void initState() {
    _updateNotifier =
        Provider.of<WishListUpdatedNotifier>(context, listen: false);
    this.getData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: product_bg,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>SearchScreen(from: "",hint: "Search products",)),
                    );
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
            .execute<WishListResponse, Null>('wishlist/'+selectLanguage, null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ////debugPrint('products size: ${snapshot.data?.products?.length}');
            return getWishListFullView(snapshot.data);
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
  Widget _listview(List<Products> products) => ListView.builder(
      padding: EdgeInsets.only(bottom: 70),
      itemBuilder: (context, index) =>
          _itemsBuilder(products[index]),

      itemCount: products.length);

  Widget _itemsBuilder(Products product) {
    bool status = false;

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductDetailsScreen(product.slug)),
          );
        },
        child:
        Container(
          margin: const EdgeInsets.only(bottom: 5.0,left: 10.0,top:5,right:10),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
                EdgeInsets.fromLTRB(padding, padding, 0, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeInImage.assetNetwork(
                      imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace)=>Image(
                        image: AssetImage("assets/images/no_image.png"),
                        fit: BoxFit.cover,
                      ),
                      placeholder: 'assets/images/no_image.png',
                      image: '$productThumbUrl${product.image}',
                      width: 120,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding:EdgeInsets.only(right:10),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,fontSize: 12, fontWeight: FontWeight.w500,height: 1.3),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text('${product.symbolLeft}${" "}${product.price}${product.symbolRight}',style: TextStyle(
                                  color: colorRed,fontSize: 11,fontWeight: FontWeight.w500)),
                              SizedBox(
                                width: 10,
                              ),
                              Text('${product.symbolLeft}${" "}${product.oldprice}${product.symbolRight}',style: TextStyle(
                                  color: Colors.grey,fontSize: 11,decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              BagButton(product.slug, product.storeslug),
                              SizedBox(
                                width: 5,
                              ),
                              removeButton(product.slug, product.storeslug),
                            ],
                          )
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

  Future<String>removeFromWishList(String slug,String store) async {

    Map body = {
      "slug":slug,
      "quantity":"0",
      "store":store
    };
    WishListResponse wishlistresponse = await ApiCall()
        .execute<WishListResponse, Null>("wishlist/add/"+selectLanguage, body);

    if (wishlistresponse != null) {
      ApiCall().showToast(wishlistresponse.message);
      _updateNotifier.wishListResponse=wishlistresponse;

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => widget));
    }
    return "Success!";
  }
  Future<String> movetoCart(String slug,String store) async {

    Map body = {
      "slug":slug,
      "quantity":"1",
      "store":store
    };
    WishListResponse wishlistresponse = await ApiCall()
        .execute<WishListResponse, Null>("wishlist/move/"+selectLanguage, body);

    if (wishlistresponse != null) {
      ApiCall().showToast(wishlistresponse.message);
      getWishListResponse();
    //  _updateNotifier.wishListResponse=wishlistresponse;
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => widget));
    }
    return "Success!";
  }

  Widget getWishListFullView(WishListResponse response)
  {
    _updateNotifier.wishListResponse=response;
    return Consumer<WishListUpdatedNotifier>(
      builder: (context, value, child) {
        return value.wishListResponse!=null ? getWishListFull(value.wishListResponse.products) : SizedBox();
      },
    );
  }
  Widget getWishListFull(List<Products> products)
  {
    if(products==null)
      return getEmptyContainerWishlist(context);
    else if(products.length==0)
      return getEmptyContainerWishlist(context);
    return Container(
      child: Container(width: double.infinity,
        child: Column(

          children: [
            getTopContainer(),
            Flexible(
              child: _listview(products),

            ),
          ],
        ),

      ),
    );
    //return Container(child: Column(children: [Container(child:_listview(products,context,widget))],),);

  }
  Widget getTopContainer()
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
                  padding: const EdgeInsets.only(top: 0,left: 10,right: 10),
                  child: Container(
                      height: 130,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/icons/inner_banner.png"),
                            fit: BoxFit.fitWidth,
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
            child: Text(Languages.of(context).wishlist,
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
  Widget BagButton(String slug,String store)
  {
    return GestureDetector(
        onTap: () {
          movetoCart(slug,store);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
              color: colorPrimary,
              border: Border.all(width: 0.5, color:Colors.grey[500]),
              borderRadius:  BorderRadius.circular(2)),
          child: Row(
            children: [
              Image.asset("assets/icons/bag.png",height: 18,),
              Text(
                Languages.of(context).moveToBag,
                style: TextStyle(
                    color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
    );

  }
  Widget removeButton(String slug,String store)
  {
    return GestureDetector(
        onTap: () {
          removeFromWishList(slug,store);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color:colorPrimary),
              borderRadius:  BorderRadius.circular(2)),
          child: Row(
            children: [
              Image.asset("assets/icons/remove.png",width: 18,),
              Text(
                Languages.of(context).remove,
                style: TextStyle(
                    color: Colors.grey[500],fontSize: 12,fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
    );

  }
  Widget getEmptyContainerWishlist(BuildContext context)
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
                  Languages.of(context).emptyWishList,
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

                    child: Text(Languages.of(context).continueShopping,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,fontSize: 13,fontWeight: FontWeight.normal)),
                  )
              ),
            ],),
        )
    );



  }

  Future<void> getWishListResponse() async {
    var response = await ApiCall()
        .execute<WishListResponse, Null>("wishlist/"+selectLanguage, null);
    if(response!=null)
    {
      _updateNotifier.wishListResponse=response;

    }
  }
}



///