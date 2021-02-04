import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/ProductListResponse.dart';
import 'dart:convert';

import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/screens/ProductDetails.dart';
import 'package:nazarath_app/screens/cart.dart';
import 'package:nazarath_app/screens/notification.dart';
import 'package:nazarath_app/screens/wishlist.dart';

// void main() {
//   runApp(Product(
//     items: List<ListItem>.generate(
//       1000,
//           (i) => i % 6 == 0
//           ? HeadingItem("Heading $i")
//           : MessageItem("Sender $i", "Message body $i"),
//     ),
//   ));
// }
class ProductScreen extends StatefulWidget {
  @override
  _ProductState createState() => new _ProductState();
}
class _ProductState extends State<ProductScreen> {
  List data;
  List<Data> products;
  ProductListResponse productresponse;
  Future<String> getData() async {

    Map body = {
      // name,email,phone_number,passwor
    };
    productresponse = await ApiCall()
        .execute<ProductListResponse, Null>("products/en", body);

    if (productresponse != null) {
      products=productresponse.products.data;
      ApiCall().showToast(productresponse.message);
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
      appBar: getAppBarMain(context),

      body: FutureBuilder<ProductListResponse>(
        future: ApiCall()
            .execute<ProductListResponse, Null>('products/en', null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('products size: ${snapshot.data?.products?.data?.length}');
            return _listview(snapshot.data?.products?.data
                ?.where((element) =>
            element != null )
                ?.toList(),context,super.widget);
          } else if (snapshot.hasError) {
            return errorScreen('Error: ${snapshot.error}');
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

Widget _listview(List<Data> products,BuildContext context,Widget widget) => ListView.builder(
    padding: EdgeInsets.only(bottom: 70),
    itemBuilder: (context, index) =>
        _itemsBuilder(products[index],context,widget),
    // separatorBuilder: (context, index) => Divider(
    //       color: Colors.grey,
    //       height: 1,
    //     ),
    itemCount: products.length);

Widget _itemsBuilder(Data product,BuildContext context,Widget widget) {
  bool status = false;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductDetailsScreen(product.name)),
      );
    },
    child: Container(
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
                          RaisedButton.icon(icon: ImageIcon(AssetImage('assets/icons/cart.png'),color: Colors.white,size: 12),
                            label: Text('Move to Bag',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: (){
                              addtoWishList(product.slug,product.store,context,widget);
                            },
                            color: colorPrimary,
                            padding: const EdgeInsets.only(bottom: 2, top: 2,left: 4.0,right: 4.0),
                            textColor: Colors.white,

                          ),

                          SizedBox(
                            width: 2,
                          ),
                          RaisedButton.icon(icon: ImageIcon(AssetImage('assets/icons/favorite.png'),color: Colors.white,size: 12,),
                            label: Text('Remove',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: (){
                              removefromWishList(product.slug,product.store,context,widget);
                            },
                            color: colorPrimary,
                            padding: EdgeInsets.all(2),
                            textColor: Colors.white,

                          ),
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
    ),
  );;

}

Future<String>addtoWishList(String slug,String store,BuildContext context,Widget widget) async {
  Map body = {
    "slug": slug,
    "quantity": "1",
    "store": store
  };
  ProductListResponse Productresponse = await ApiCall()
      .execute<ProductListResponse, Null>("wishlist/add/en", body);

  if (Productresponse != null) {
    ApiCall().showToast(Productresponse.message);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Future<String>removefromWishList(String slug,String store,BuildContext context,Widget widget) async {
  Map body = {
    "slug": slug,
    "quantity": "0",
    "store": store
  };
  WishListResponse wishListResponse = await ApiCall()
      .execute<WishListResponse, Null>("wishlist/add/en", body);

  if (wishListResponse != null) {
    ApiCall().showToast(wishListResponse.message);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
  return "Success!";
}
InkWell getWishListIcon(bool condition )
{
  if(condition) {
    return InkWell(
// onTap: ,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ImageIcon(
          AssetImage('assets/icons/favourite.png'),
          size: 16,
          color: colorPrimary,
        ),
      ),
    );
  }
  return InkWell(
// onTap: ,
    child:  Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ImageIcon(
        AssetImage('assets/icons/favourite.png'),
        size: 18,
        color: colorPrimary,
      ),
    ),
  );
}



///