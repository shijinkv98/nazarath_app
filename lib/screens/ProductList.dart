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

import 'home.dart';

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
            return getProductViews(snapshot.data?.products?.data
                ?.where((element) =>
            element != null )
                ?.toList(),context,super.widget);
          } else if (snapshot.hasError) {
            return getEmptyContainer(context, "Product List is empty", "empty_cart");
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
Widget getProductViews(List<Data> products,BuildContext context,Widget widget)
{
  if(products.length==0)
    return getEmptyContainer(context, "Product List is empty", "empty_cart");
  else
    return Container(
      child: Column(
        children: [
          getTopContainer(),
          SizedBox(
            height: 5,
          ),
          getButtonContainer(context),
          SizedBox(
            height: 5,
          ),
          Flexible(
            child: _gridView(products,context,widget),

          ),
        ],
      ),
    );

}
Widget getButtonContainer(BuildContext context)
{
 return  Padding(
    padding: const EdgeInsets.only(left: 10,right: 10),
    child: Container(
      height:36,
      width:double.infinity,
      color: product_bg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 36,
            width: MediaQuery.of(context).size.width / 2.2,
            decoration: BoxDecoration(
                border: Border.all(color: colorPrimary)
            ),
            child: Center(child: Text('Sort')),
          ),
          // SizedBox(width: 10,),
          Container(
            height: 36,
            width: MediaQuery.of(context).size.width/ 2.2,
            color: colorPrimary,
            child: Center(child: Text('Filter')),
          )
        ],
      ),

    ),
  );
}

Widget getTopContainer() {
  return Container(
    color: product_bg,
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
                          image: new AssetImage(
                              "assets/icons/inner_banner.png"),
                          fit: BoxFit.fill,
                        ))),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}
Widget _listview(List<Data> products,BuildContext context,Widget widget) => ListView.builder(
    padding: EdgeInsets.only(bottom: 70),
    itemBuilder: (context, index) =>
        _itemsBuilder(products[index],context,widget),
    itemCount: products.length);

Widget _gridView(List<Data> products,BuildContext context,Widget widget)=>GridView.count(
  crossAxisCount: 3,
  shrinkWrap: true,
  scrollDirection: Axis.vertical,
  childAspectRatio: 0.75,
  children: List.generate(products.length, (index) {
    return Center(
      child: _itemsBuilder(products[index],context,widget),
    );
  }),
);
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
      margin: const EdgeInsets.only(bottom: 5.0,left: 2.0,top:5.0,right:2),
      child:Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)),
        ),
        color: Colors.white,
        elevation: 2,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 2, right: 2),
                child: Container(

                  height: 50,
                  child: Image(
                    image: new NetworkImage(
                        '$productThumbUrl${product.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 0, left: 10, right: 6),
                  child: Text(
                    product.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 9),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 25,

                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomLeft: Radius.circular(3))),
                     child: Center(
                       widthFactor: 0.5,
                         child: new Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               new IconButton(
                                   icon: Icon(
                                     Icons.add,
                                     color: Colors.white,
                                     size: 10,

                                   ),
                                 onPressed: (){
                                     addtoCart(product.slug, product.store, context, widget,"1");}
                               ),
                             ]
                         ))
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          alignment: Alignment.topRight,
                          child: getWishListIcon(product.wishlist,product.slug,product.store,context,widget)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5,
                            right: 10,
                            top: 3,
                            bottom: 8
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${product.symbolLeft}${" "}${product.price}${product.symbolRight}',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${product.symbolLeft}${" "}${product.oldprice}${product.symbolRight}',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 8,
                                  decoration: TextDecoration
                                      .lineThrough),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
            ]),
      ) , 
    ),
  );

}
Widget getaddIcon()
{
  return   Center(
    child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        new IconButton(
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 10,
        )),
      ]
  ));
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
InkWell getWishListIcon(int wish,String slug,String store,BuildContext context,Widget widget )
{
  if(wish==1) {
    return InkWell(
// onTap: ,
      child: Padding(
        padding: const EdgeInsets.only(right: 0),
        child: ImageIcon(
          AssetImage('assets/icons/fav_active.png'),
          size: 16,
          color: colorPrimary,
        ),
      ),
      onTap: ()
      {
        addtoWishList(slug, store, context, widget);
      },
    );
  }
  return InkWell(
    onTap: ()
    {
      removefromWishList(slug, store, context, widget);
    },
    child:  Padding(
      padding: const EdgeInsets.only(right: 0),
      child: ImageIcon(
        AssetImage('assets/icons/favourite.png'),
        size: 18,
        color: colorPrimary,
      ),
    ),
  );
}



///