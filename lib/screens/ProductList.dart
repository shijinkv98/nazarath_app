import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
import 'package:nazarath_app/network/response/ProductListResponse.dart';
import 'dart:convert';

import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/screens/DashBoard.dart';
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
  String slug="";
  String by="category";
  ProductScreen(String slug,String by)
  {
    this.slug=slug;
  }
  @override
  _ProductState createState() => new _ProductState(slug:this.slug,by: this.by);
}
class _ProductState extends State<ProductScreen> {
  List data;
  String slug="";
  String by="category";
  List<Data> products;
  ProductListResponse productresponse;
  _ProductState({ this.slug,this.by}) ;
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
    Map para={
      "by":by,
      "value":slug
    };
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // titleSpacing: 100,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
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
      backgroundColor: product_bg,
      body: FutureBuilder<ProductListResponse>(
        future: ApiCall()
            .execute<ProductListResponse, Null>('products/en', para),
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
            child: customView(products,context,widget),

          ),
          SizedBox(
            height: 5,
          ),
         // getRecommended(homeResponse.newarrivals, widget)
        ],
      ),
    );

}
Widget customView(List<Data> products,BuildContext context,Widget widget)
{
  return CustomScrollView(
    slivers: <Widget>[

      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return _itemsBuilder(products[index],context,widget);
          },
          childCount: products.length,
        ),
      ),
      SliverToBoxAdapter(
        child:  getRecommended(homeResponse.newarrivals, widget),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 30.0),
      )
    ],
  );
}
// Container getRecommended(List<Newarrivals> recommended,Widget widget) {
//   return Container(
//     child: Container(
//       width: double.infinity,
//       color: Color(0xFFe5eeef),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 7),
//             child: Text("Recommended Products",
//                 style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.bold)),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 10),
//             color: Color(0xFFe5eeef),
//             height: 150,
//             width: double.infinity,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: recommended.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 5),
//                     child: Container(
//                       height:140,
//                       width: 140,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 2, right: 2),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(10.0),
//                                 topRight: Radius.circular(10.0),
//                                 topLeft: Radius.circular(10.0),
//                                 bottomLeft: Radius.circular(10.0)),
//                           ),
//                           color: Colors.white,
//                           elevation: 2,
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 5, left: 5, right: 5),
//                                   child: Container(
//                                     height: 70,
//                                     child: Image(
//                                       image: new NetworkImage(
//                                           '$productThumbUrl${recommended[index].image}'),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 0,right: 5,left: 5),
//                                       child: Container(
//
//                                         child: Row(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Container(
//
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(top: 5,right: 3),
//                                                 child: Text(
//                                                   '${recommended[index].symbolLeft}${" "}${recommended[index].price}${recommended[index].symbolRight}',
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 8,
//                                                       fontWeight: FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ),
//
//                                             Container(
//
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(top: 5,right: 10),
//                                                 child: Text(
//                                                   '${recommended[index].symbolLeft}${" "}${recommended[index].oldprice}${recommended[index].symbolRight}',
//                                                   style: TextStyle(
//                                                       color: Colors.grey[700],
//                                                       fontSize: 8,
//                                                       decoration:
//                                                       TextDecoration.lineThrough),
//                                                 ),
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: (){
//                                                 addtoWishList(recommended[index].slug, recommended[index].store, context, widget);
//                                               } ,
//                                               child: ImageIcon(
//                                                 AssetImage(
//                                                     'assets/icons/favourite.png'),
//                                                 size: 14,
//                                                 color: colorPrimary,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                                 Container(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 5, left: 10,right: 5),
//                                     child: Text(
//                                       recommended[index].name,
//                                       textAlign: TextAlign.start,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize:9),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     ),
//   );
// }
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
                border: Border.all(color: colorPrimary),
              color: Colors.white,
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
  childAspectRatio: 0.85,
  children: List.generate(products.length, (index) {
    return Center(
      child: _itemsBuilder(products[index],context,widget),
    );
  }),
);
Widget _itemsBuilder(Data product,BuildContext context,Widget widget) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductDetailsScreen(product.slug)),
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
                    height: 30,
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomLeft: Radius.circular(5))),
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
                          //alignment: Alignment.topRight,
                          child: getWishListIcon(product.wishlist,product.slug,product.store,context,widget)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0,
                            right: 5,
                            top: 3,
                            bottom: 8
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${product.symbolLeft}${" "}${product.price}${product.symbolRight}',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2),
                            Text(
                              '${product.symbolLeft}${" "}${product.oldprice}${product.symbolRight}',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 7,
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
Future<String>addtoWishListNew(String slug,String store,BuildContext context,Widget widget) async {
  Map body = {
    "slug": slug,
    "quantity": "1",
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Widget getWishListIcon(int wish,String slug,String store,BuildContext context,Widget widget )
{

  if(wish==1) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ImageIcon(
          AssetImage('assets/icons/fav_active.png'),
          size: 14,
          color: colorPrimary,
        ),
      ),
      onTap: ()
      {
        removefromWishList(slug, store, context, widget);
      },
    );
  }
  return InkWell(
    onTap: ()
    {
      addtoWishList(slug, store, context, widget);
    },
    child:  Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ImageIcon(
        AssetImage('assets/icons/favourite.png'),
        size: 14,
        color: colorPrimary,
      ),
    ),
  );
}



///