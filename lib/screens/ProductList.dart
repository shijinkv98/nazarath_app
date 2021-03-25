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
import 'package:nazarath_app/screens/filterScreen.dart';
import 'package:nazarath_app/screens/notification.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'custom/wishlist_product.dart';
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
  String by="name";
  String filter="";
  String sortOrder="desc";
  String query="";
  String sortBy="name";
  ProductScreen(String slug,String by,String sortBy,String sortOrder,String filter,String query) {
    this.slug = slug;
    this.by=by;
    this.filter=filter;
    this.sortOrder=sortOrder;
    this.query=query;
     this.sortBy=sortBy;
  }
  @override
  _ProductState createState() => new _ProductState(slug:this.slug,by: this.by,filter: this.filter,sortOrder: this.sortOrder,query:this.query,sortBy: this.sortBy);
}
class _ProductState extends State<ProductScreen> {
  List data;
  String slug="";
  String by="category";
  String filter="";
  String sortOrder="asc";
  String sortBy="name";
  List<Data> products;
  String query="";
  ProductListResponse productresponse;
  _ProductState({ this.slug,this.by,this.filter,this.sortOrder,this.query,this.sortBy}) ;
  Future<String> getData() async {

    // Map body = {
    //   // name,email,phone_number,passwor
    // };
    // productresponse = await ApiCall()
    //     .execute<ProductListResponse, Null>("products/en", body);
    //
    // if (productresponse != null) {
    //   products=productresponse.products.data;
    //   ApiCall().showToast(productresponse.message);
    // }
    // return "Success!";
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
      "value":slug,
      "sort_order":sortOrder,
      "sort_by":sortBy,
      "query":query,
      "filters":filter
    };
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // titleSpacing: 100,
        automaticallyImplyLeading: true,
       // leading: IconButton(icon: Icon(Icons.arrow_back_ios)),
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
            if(snapshot.data.products==null)
              return getEmptyContainer(context, "Product List is empty", "empty_cart");
            //debugPrint('products size: ${snapshot.data?.products?.data?.length}');
            return getProductViews(snapshot.data?.products?.data
                ?.where((element) =>
            element != null )
                ?.toList(),context,super.widget,by,sortBy,sortOrder,filter,query,slug);
          } else if (snapshot.hasError) {
            return getEmptyContainer(context, "Product List is empty", "empty_cart");
          } else {
            return progressBar;
          }
        },
      ),
      // bottomNavigationBar: get,
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
Widget getProductViews(List<Data> products,BuildContext context,Widget widget,String by,String sortBy,String sortOrder,String filter,String query,String slug)
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
          getButtonContainer(context,by,sortBy,sortOrder,filter,query,slug),
          SizedBox(
            height: 5,
          ),
          Flexible(
            child: customView(products,context,widget),

          ),
          SizedBox(
            height: 5,
          ),
         //getBottomTabPannel(context)

         // getRecommended(homeResponse.newarrivals, widget)
        ],
      ),
    );

}
void displayBottomSheet(BuildContext context,String by ,String sortBy,String sortOrder,String filter,String query,String slug) {
  FontWeight f1=FontWeight.normal;
  FontWeight f2=FontWeight.normal;
  FontWeight f3=FontWeight.normal;
  FontWeight f4=FontWeight.normal;
  FontWeight f5=FontWeight.normal;
  if(sortBy=="name")
  {
    f1=FontWeight.bold;
  }
  else if(sortBy=="price" && sortOrder=="asc")
  {
    f2=FontWeight.bold;
  }
  else if(sortBy=="price")
  {
    f3=FontWeight.bold;
  }
  else if(sortBy=="popularity")
  {
    f4=FontWeight.bold;
  }
  else
  {
    f5=FontWeight.bold;
  }

  showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top:20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left:15,bottom: 10),
                      width:double.infinity,
                      child: Text(
                        "SORT BY",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color:Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(height: 1,color: Colors.black,thickness: 1,)
                  ],
                ),
              ),

              InkWell(

                onTap:(){  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ProductScreen(slug,by,"name","asc",filter,query)),
                );
                },
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15,left:15,right: 15,),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black,fontSize: 12,fontWeight: f1),
                        ),
                      ),
                      // Divider(height: 1,)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap:(){  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ProductScreen(slug, by,"price","desc",filter,query)),
                );
                },
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15,left:15,right: 15,),
                        child: Text(
                          "Price High to Low",
                          style: TextStyle(
                              color: Colors.black,fontSize: 12,fontWeight: f2),
                        ),
                      ),
                      // Divider(height: 1,)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap:(){  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ProductScreen(slug, by,"price","asc",filter,query)),
                );
                },
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15,left:15,right: 15,),
                        child: Text(
                          "Price Low to High",
                          style: TextStyle(
                              color: Colors.black,fontSize: 12,fontWeight: f3),
                        ),
                      ),
                      // Divider(height: 1,)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap:(){  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ProductScreen(slug, by,"popularity","asc",filter,query)),
                );
                },
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15,left:15,right: 15,),
                        child: Text(
                          "Popularity",
                          style: TextStyle(
                              color: Colors.black,fontSize: 12,fontWeight: f4),
                        ),
                      ),
                      // Divider(height: 1,)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap:(){  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ProductScreen(slug, by,"rating","asc",filter,query)),
                );
                },
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,bottom: 15,left:15,right: 15,),
                        child: Text(
                          "Rating",
                          style: TextStyle(
                              color: Colors.black,fontSize: 12,fontWeight: f5),
                        ),
                      ),
                      // Divider(height: 1,)
                    ],
                  ),
                ),
              )

            ],
          ),
          // child: Center(
          //   child: Text("Welcome to AndroidVille!"),
          // ),
        );
      });
}
Widget customView(List<Data> products,BuildContext context,Widget widget)
{
  return CustomScrollView(
    slivers: <Widget>[

      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return _itemsBuilder(products[index],context,widget);
          },
          childCount: products.length,
        ),
      ),
      SliverToBoxAdapter(
        child:  getRecommended(homeResponse.recommendedProducts, widget),
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
//                                                       color: colorRed,
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
Widget getButtonContainer(BuildContext context,String by,String sortBy ,String sortOrder,String filter,String query,String slug)
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
          GestureDetector(
            onTap: ()
            {
              displayBottomSheet(context,by,sortBy,sortOrder,filter,query,slug);
            },
            child: Container(
              height: 36,
              width: MediaQuery.of(context).size.width / 2.2,

              decoration: BoxDecoration(
                  border: Border.all(color: colorPrimary),
                color: Colors.white,
              ),
              child: Center(child: Text('Sort')),
            ),
          ),
          // SizedBox(width: 10,),
          GestureDetector(
            onTap: ()
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterScreeen(by,sortBy,sortOrder,query,slug)),
              );
            },
            child: Container(
              height: 36,
              width: MediaQuery.of(context).size.width/ 2.2,
              color: colorPrimary,
              child: Center(child: Text('Filter')),
            ),
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
                padding: const EdgeInsets.only(left: 10, right: 10),

                child: Container(
                  height: 120,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage(
                              "assets/icons/inner_banner.png"),
                          fit: BoxFit.fitWidth,
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
  childAspectRatio: 0.55,
  children: List.generate(products.length, (index) {
    return Center(
      child: _itemsBuilder(products[index],context,widget),
    );
  }),
);
Widget _itemsBuilder(Data item,BuildContext context,Widget widget) {
  return Container(

    child: Container(

        child: Card(
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5,right: 10),
                child: GestureDetector(
                    // onTap: (){
                    //   if(item.wishlist==0) {
                    //     item.wishlist = 1;
                    //     addtoWishList(item.slug, item.store, context, widget);
                    //   }
                    //   else {
                    //     item.wishlist = 0;
                    //     removefromWishList(item.slug, item.store, context, widget);
                    //   }
                    //
                    // },
                    child:
                    getWishListIcon(item.wishlist,26,item,context,widget)
                ),
              ),
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetailsScreen(item.slug)),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 2, left: 0, right: 0),
                        child: Container(
                          height: 50,
                          child: Image(
                            image: new NetworkImage(
                                '$productThumbUrl${item.image}'),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: Text(
                            item.name,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                                fontSize: 10),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 35,
                              alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(
                                  color: button_cart_bg,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              child: Center(
                                  widthFactor: 0.6,
                                  child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 13,

                                            ),
                                            onPressed: (){
                                              addtoCart(item.slug, item.store, context, widget,"1");}
                                        ),
                                      ]
                                  ))
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 5,
                              top: 3,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${item.symbolLeft}${" "}${item.price}${item.symbolRight}',
                                  style: TextStyle(
                                      color: colorRed,
                                      fontSize:
                                      11,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${item.symbolLeft}${" "}${item.oldprice}${item.symbolRight}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: item_text_gray_light,
                                      fontSize: 9,
                                      decoration: TextDecoration
                                          .lineThrough),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )

              )

            ],

          ),
        )
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
Widget getWishListIcon(int wish,double size ,Data item,BuildContext context,Widget widget)
{
  return WishListProductList(item.wishlist,item.slug,item.store,25);
  //WishListProductList(item);
  // if(wish==1) {
  //   return InkWell(
  //     onTap: ()
  //     {
  //       addtoWishList(item.slug, item.store, context, widget);
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(right: 10),
  //       child: ImageIcon(
  //         AssetImage('assets/icons/fav_active.png'),
  //         size: 18,
  //         color: colorPrimary,
  //       ),
  //     ),
  //
  //   );
  // }
  // return InkWell(
  //   onTap: ()
  //   {
  //     removefromWishList(item.slug, item.store, context, widget);
  //   },
  //   child:  Padding(
  //     padding: const EdgeInsets.only(right: 10),
  //     child: ImageIcon(
  //       AssetImage('assets/icons/favourite.png'),
  //       size: 18,
  //
  //       color: colorPrimary,
  //     ),
  //   ),
  // );
}



///