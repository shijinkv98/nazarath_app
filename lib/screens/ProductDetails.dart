import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
import 'package:nazarath_app/network/response/ProductDetailsResponse.dart';
import 'package:nazarath_app/screens/wishlist.dart';
import 'package:spinner_input/spinner_input.dart';

import 'ProductList.dart';
import 'cart.dart';
import 'custom/spinner_product.dart';
import 'home.dart';
import 'notification.dart';

class ProductDetailsScreen extends StatefulWidget {
  String title;

  ProductDetailsScreen(String title) {
    this.title = title;
  }
  @override
  _ProductDetailsState createState() => new _ProductDetailsState(slug: title);
}
double spinner = 1;
class _ProductDetailsState extends State<ProductDetailsScreen> {
  String slug;
  _ProductDetailsState({this.slug});


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
        backgroundColor: Colors.white,
        body:FutureBuilder<ProductDetailsResponse>(
        future: ApiCall()
            .execute<ProductDetailsResponse, Null>('${"product/en/"}$slug', null),
        builder: (context, snapshot) {
        if (snapshot.hasData) {
        return getProductDetailsValue(snapshot.data,context,widget,slug);
        } else if (snapshot.hasError) {
        return getEmptyContainer(context, "Product List is empty", "empty_cart");
        } else {
        return progressBar;
        }
        },
        ),
    );
  }
}

Widget getProductDetailsValue(ProductDetailsResponse response,BuildContext context,Widget widget,String slug)
{
 return  SingleChildScrollView(
    child: Column(
      children: [
        getTopContainer(),
        getProductImageSlider(response.product.images),
        getProductDetails(response.product),
        getSizeChart(),
        getSpecifications(response.product.sizeChart,response.product.options, context, widget),
        SizedBox(
          height: 25,
        ),
        getButtons(context, widget, slug, response.product.store, "1"),
        getProductDescription(response.product.description),
        getRecommended(homeResponse.recommendedProducts,widget),
      ],
    ),
  );
}
Widget getImageProduct(String url)
{
  return Container(
    child: FadeInImage.assetNetwork(
      placeholder: 'assets/images/no_image.png',
      image: '$productThumbUrl$url',

    ) ,
  );
}
Widget getProductImageSlider(List<Images> images) {
  bool autoPlay=false;
  if(images.length>1)
    autoPlay=true;
  return
    CarouselSlider(
      options: CarouselOptions(height: 150.0,
        enlargeCenterPage: true,
        autoPlay: autoPlay,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: autoPlay,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1.0,
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return getImageProduct(i.image);
          },
        );
      }).toList(),
    );
  // return Container(
  //     height: 150,
  //     width: double.infinity,
  //     child: Carousel(
  //       dotBgColor: Colors.transparent, // onImageTap: ,
  //       images: [
  //         AssetImage('assets/icons/banner1.png'),
  //         // NetworkImage('imageurl'),
  //         AssetImage("assets/icons/banner2.png"),
  //         NetworkImage(
  //             "https://image.shutterstock.com/image-photo/micro-peacock-feather-hd-imagebest-260nw-1127238584.jpg"),
  //         AssetImage("assets/image3.jpeg"),
  //         NetworkImage(
  //             'https://i.pinimg.com/originals/94/dd/57/94dd573e4b4de604ea7f33548da99fd6.jpg'),
  //       ],
  //     ));
}

Container getTopContainer() {
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
                      image: new AssetImage("assets/icons/inner_banner.png"),
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

Container getProductImage() {
  return Container(
    color: Colors.grey,
    width: double.infinity,
    height: 160,
    child: Image(
      image: new NetworkImage(
          "https://image.shutterstock.com/image-photo/micro-peacock-feather-hd-imagebest-260nw-1127238584.jpg"),
      fit: BoxFit.cover,
    ),
  );
}

Container getProductDetails(Product product) {
  return Container(
      color: product_bg,
      width: double.infinity,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Text(
              product.store,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 240,
                        child:Flexible(child: Text(
                          product.name,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),)
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 240,
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getStarRating(double.parse(product.rating)),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 5),
                                child: Flexible(child:Text(
                                  '${product.ratingcount.toString()}${" reviews"}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ],
                          ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Flexible(child:Text(
                          '${product.symbolLeft}${" "}${product.price}${product.symbolRight}',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),)
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child:  Flexible(child:Text(
                          '${product.symbolLeft}${" "}${product.oldprice}${product.symbolRight}',
                          textAlign:TextAlign.end,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough),
                        ),)
                      )
                    ],
                  )



            ],
          ),


          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: getCount(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: getStock(),
          )
        ],
      ));
}

Container getStarRating(double rating) {
  return Container(
    height: 10,
    child: RatingBar(
        initialRating: rating,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 15,
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

  Widget  getCount() {
    return SpinnerProduct();
  // return Container(
  //   width: 110,
  //   height: 45,
  //   decoration: BoxDecoration(
  //     color: Colors.white,
  //     border: Border.all(color: Colors.grey[300]),
  //     borderRadius: BorderRadius.only(
  //         bottomRight: Radius.circular(2.0),
  //         topRight: Radius.circular(2.0),
  //         topLeft: Radius.circular(2.0),
  //         bottomLeft: Radius.circular(2.0)),
  //   ),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       IconButton(
  //           icon: Icon(
  //             Icons.remove,
  //             size: 15,
  //           ),
  //           onPressed: () {}),
  //       Text('1'),
  //       IconButton(
  //           icon: Icon(
  //             Icons.add,
  //             size: 15,
  //           ),
  //           onPressed: () {}),
  //     ],
  //   ),
  // );
}

Container getStock() {
  String text="Instock";
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            'Instock',
            style: TextStyle(
                color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
Widget getSpecifications(String sizeChart,List<Options>specifications,BuildContext context,Widget widget)
{
  if(specifications.length==0)
    return Container(
      child: SizedBox(
        height: 0.01,
      ),
    );
  return Container(
      height: 50,
      child:Flexible(child:listview(sizeChart,specifications,context,widget) )
      );
}

listview(String sizeChart, List<Options> specifications, BuildContext context, Widget widget)=> ListView.builder(
    itemBuilder: (context, index) =>
        _itemsBuilder(specifications[index],context,widget),
    itemCount: specifications.length);
Container getSizeChart() {
  return Container(
    width: double.infinity,
    height: 50,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Color:',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ), //<< any widgets added
          Expanded(
              child: ListView.builder(
                  //here your code
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2, left: 10),
                      child: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0)),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    ),
  );
}
Widget getHtmlValue(String text)
{
  return Center(
      child: SingleChildScrollView(
      child: Html(
        data: text,
      )
  ));

}
Widget _itemsBuilder(Options specifications, BuildContext context, Widget widget) {
  return Container(
    width: double.infinity,
    height: 50,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(left: 22, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            specifications.name,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ), //<< any widgets added
          Expanded(
              child: ListView.builder(
                  //here your code
                  scrollDirection: Axis.horizontal,
                  itemCount: specifications.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Container(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                        child: Center(
                            child: Text(
                         specifications.values[index].value,
                          style: TextStyle(fontSize: 11),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    );
                  })),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text('Size Chart', style: TextStyle(color: colorPrimary)))
        ],
      ),
    ),
  );
}

Container getButtons(BuildContext context,Widget widget,String slug,String store,String quantity) {
  return Container(
      color: product_bg,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: GestureDetector(
              onTap: () {
                addtoCart(slug, store, context, widget, spinner_product.toString());
              },
              child: Container(
                width: 140,
                height: 40,
                decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(3)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: GestureDetector(
              onTap: () {
               addtoWishList(slug, store, context, widget);
              },
              child: Container(
                width: 140,
                height: 40,
                decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(3)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add to Wishlist",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ));
}

Container getProductDescription( String description) {
  return Container(
    color: product_bg,
    width: double.infinity,
    height: 400,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 30, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Product Description',
            style: TextStyle(color: Colors.grey[900], fontSize: 15),
          ),
          SizedBox(height: 12),
          getHtmlValue(description)
          // Text(
          //   description,
          //   style: TextStyle(color: Colors.grey[700], fontSize: 13),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Expanded(
          //   child: ListView.builder(
          //       physics: NeverScrollableScrollPhysics(),
          //       itemCount: 8,
          //       itemBuilder: (BuildContext context, int index) {
          //         return Row(
          //           children: [
          //             Container(
          //               width: MediaQuery.of(context).size.width / 3,
          //               height: 35,
          //               decoration: BoxDecoration(
          //                 border: Border(
          //                   top: BorderSide(color: Colors.grey[300]),
          //                   left: BorderSide(color: Colors.grey[300]),
          //                 ),
          //               ),
          //               child: Center(
          //                   child: Text(
          //                 'Gender',
          //                 style: TextStyle(fontSize: 14),
          //                 textAlign: TextAlign.center,
          //               )),
          //             ),
          //             Container(
          //               width: MediaQuery.of(context).size.width / 1.72,
          //               height: 35,
          //               decoration: BoxDecoration(
          //                 border: Border(
          //                   top: BorderSide(color: Colors.grey[300]),
          //                   left: BorderSide(color: Colors.grey[300]),
          //                   right: BorderSide(color: Colors.grey[300]),
          //                 ),
          //               ),
          //               child: Center(
          //                   child: Text(
          //                 'Male',
          //                 style: TextStyle(fontSize: 14),
          //                 textAlign: TextAlign.center,
          //               )),
          //             ),
          //             Divider(
          //               color: Colors.grey[300],
          //             )
          //           ],
          //         );
          //       }),
          //)
        ],
      ),
    ),
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
//             padding: const EdgeInsets.only(top: 10),
//             child: Text("Recommended Products",
//                 style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.bold)),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
//             color: Color(0xFFe5eeef),
//             height: 200,
//             width: double.infinity,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: recommended.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Container(
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
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 10,right: 5,left: 10),
//                                       child: Container(
//                                         height: 25,
//                                         child: Row(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Container(
//                                               height: 25,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(top: 8,right: 3),
//                                                 child: Text(
//                                                   '${recommended[index].symbolLeft}${" "}${recommended[index].price}${recommended[index].symbolRight}',
//                                                   style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontSize: 9  ,
//                                                       fontWeight: FontWeight.bold),
//                                                 ),
//                                               ),
//                                             ),
//
//                                             Container(
//                                               height: 25,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(top: 10,right: 5),
//                                                 child: Text(
//                                                   '${recommended[index].symbolLeft}${" "}${recommended[index].oldprice}${recommended[index].symbolRight}',
//                                                   textAlign: TextAlign.start,
//                                                   style: TextStyle(
//                                                       color: Colors.grey[700],
//                                                       fontSize: 6,
//                                                       decoration:
//                                                       TextDecoration.lineThrough),
//                                                 ),
//                                               ),
//                                             ),
//
//                                             InkWell(
//                                               onTap: (){
//                                               //  addtoWishList(recommended[index].slug, recommended[index].store, context, widget);
//                                               } ,
//                                               child: ImageIcon(
//                                                 AssetImage(
//                                                     'assets/icons/favourite.png'),
//                                                 size: 20,
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
//                                     child: AutoSizeText(
//                                       recommended[index].name,
//                                       textAlign: TextAlign.start,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 8),
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
