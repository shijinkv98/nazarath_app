
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/languages.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';

import 'package:nazarath_app/network/response/ProductDetailsResponse.dart';
import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/screens/galleryimageviewer.dart';
import 'package:nazarath_app/screens/searchscreen.dart';

import 'cart.dart';
import 'custom/spinner_product.dart';
import 'custom/wishlist_product.dart';
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
  ProductDetailsResponse _productDetailsResponse;

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
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>SearchScreen(from: "",hint: "Search products",)),
                    );
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
            .execute<ProductDetailsResponse, Null>('${"product/"}$selectLanguage${"/"}$slug', null),
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          _productDetailsResponse=snapshot.data;
        return getProductDetailsValue();
        } else if (snapshot.hasError) {
        return getEmptyContainer(context, Languages.of(context).emptyProduct, "empty_cart");
        } else {
        return progressBar;
        }
        },
        ),
    );
  }
  Widget getProductDetailsValue()
  {
    if(_productDetailsResponse.product==null)
      return getEmptyContainer(context, Languages.of(context).emptyProduct, "empty_cart");
    return  SingleChildScrollView(
      child: Column(
        children: [
          getTopContainer(),
          getProductImageSlider(),
          getProductDetails(_productDetailsResponse.product),
          getSpecifications(_productDetailsResponse.product.sizeChart,_productDetailsResponse.product.options),

          getButtons( _productDetailsResponse.product.storeslug, "1"),
          getProductDescription(_productDetailsResponse.product.description),
          getRecommended(homeResponse.recommendedProducts,widget),
        ],
      ),
    );
  }
  Widget getImageProduct(Images image)
  {
    String url=image.image;
    int index=0;
    List<String> imagesArray=new List<String>();
    for(int i=0;i<_productDetailsResponse.product.images.length;i++)
      {
        if(_productDetailsResponse.product.images[i].id==image.id)
          index=i;
        imagesArray.add(_productDetailsResponse.product.images[i].image);
      }
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GalleryImageViewer(galleryItems: imagesArray,initialIndex: index,)
            ));
      },
      child: Container(
        child: FadeInImage.assetNetwork(
                      imageErrorBuilder: (BuildContext context, Object exception, StackTrace stackTrace)=>Image(
                        image: AssetImage("assets/images/no_image.png"),
                        fit: BoxFit.cover,
                      ),
          placeholder: 'assets/images/no_image.png',
          image: '$productThumbUrl$url',

        ) ,
      ),
    );
  }
  Widget getProductImageSlider() {
    bool autoPlay=false;
    if(_productDetailsResponse.product.images.length>1)
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
        items: _productDetailsResponse.product.images.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return getImageProduct(i);
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

  Widget getProductImage() {
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

  Widget getProductDetails(  ProductDetail product) {
    return Container(
        color: product_bg,
        width: double.infinity,
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
                        child:Text(
                          product.name,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 15, height: 1.3,),
                        )
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
                            child: Text(
                              '${product.ratingcount.toString()}${Languages.of(context).reviews}',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                        child: Text(
                          '${product.symbolLeft}${" "}${product.price}${product.symbolRight}',
                          style: TextStyle(
                              color: colorRed,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        child:  Text(
                          '${product.symbolLeft}${" "}${product.oldprice}${product.symbolRight}',
                          textAlign:TextAlign.end,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough),
                        )
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

  Widget getStock() {
    String text=Languages.of(context).inStock;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Languages.of(context).availability,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              Languages.of(context).inStock,
              style: TextStyle(
                  color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  Widget getSpecifications(String sizeChart,List<Options>specifications)
  {
    if(specifications.length==0)
      return Container(

      );
    double height=50.0*specifications.length;
    return Column(
      children: [
        Container(
            height: height,
            child:Flexible(child:listview(sizeChart,specifications) )
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  listview(String sizeChart, List<Options> specifications)=> ListView.builder(
      itemBuilder: (context, index) =>
          _itemsBuilder(specifications[index],context,widget),
      itemCount: specifications.length);
  Widget getSizeChart(List<ValuesOption> values) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: double.infinity,
        height: 50,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${Languages.of(context).inStock}${" :"}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ), //<< any widgets added
              Expanded(
                  child: ListView.builder(
                    //here your code
                      scrollDirection: Axis.horizontal,
                      itemCount: values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 2, left: 10),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProductDetailsScreen(values[index].slug)),
                              );
                            },
                            child: Container(
                              width: 30,
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(values[index].value),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0)),
                              ),
                            ),
                          ),
                        );
                      })),
            ],
          ),
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
  if(specifications.type=="image")
  {
    return getSizeChart(specifications.values);
  }
  else
  {
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
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductDetailsScreen(specifications.values[index].slug)),
                            );
                          },
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
                        ),
                      );
                    })),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(Languages.of(context).sizeChart, style: TextStyle(color: colorPrimary)))
          ],
        ),
      ),
    );
  }
}

Widget getButtons(String store,String quantity) {
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
                      Languages.of(context).addToCart,
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
                      Languages.of(context).addToWishList,
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

Widget getProductDescription( String description) {
  return Container(
    color: product_bg,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 30, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
          Languages.of(context).productDescription,
            style: TextStyle(color: Colors.grey[900], fontSize: 15),
          ),
          SizedBox(height: 12),
          getHtmlValue(description)

        ],
      ),
    ),
  );
}

Widget getRecommended(List<RecommendedProducts> recoomended,Widget widget) {
  if (recoomended == null)
    return Container(
      child:SizedBox(
        height: 0.01,
      ),
    );
  else if (recoomended.length == 0)  return Container(
    child:SizedBox(
      height: 0.01,
    ),
  );
  return Container(
    child: Container(
      width: double.infinity,
      color: featured_bg,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 5),
            child: Text(Languages.of(context).recommendedProducts,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
            color: Color(0xFFe5eeef),
            height: 200,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recoomended.length,
                itemBuilder: (context, index) {
                  return getRecommendItem(recoomended[index], context, widget);
                }),
          ),
        ],
      ),
    ),
  );
}
Widget getRecommendItem(RecommendedProducts item,BuildContext context,Widget widget)
  {
    return Container(

      child: Container(
          width: 150,
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
                      onTap: (){
                        // if(item.wishlist==0) {
                        //   item.wishlist = 1;
                        //   addtoWishList(item.slug, item.store, context, widget);
                        // }
                        // else {
                        //   item.wishlist = 0;
                        //   removefromWishList(item.slug, item.store, context, widget);
                        // }
                      },
                      child:WishListProductList(item.wishlist,item.slug,item.store,home_wish_size)
                    //getWishListIcon(item.wishlist,home_wish_size)

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
                            height: 60,
                            width: 120,
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



}
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
Future<String>addtoCart(String slug,String store,BuildContext context,Widget widget,String quantity) async {

  Map body = {
    "slug":slug,
    "quantity":quantity,
    "store":store
  };
  CartResponse cartResponse = await ApiCall()
      .execute<CartResponse, Null>("cart/add/"+selectLanguage, body);

  if (cartResponse != null) {
    ApiCall().showToast(cartResponse.message);
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Future<String>addtoWishList(String slug,String store,BuildContext context,Widget widget) async {
  Map body = {
    "slug": slug,
    "quantity": "1",
    "store": store
  };
  WishListResponse Productresponse = await ApiCall()
      .execute<WishListResponse, Null>("wishlist/add/"+selectLanguage, body);

  if (Productresponse != null) {
    ApiCall().showToast(Productresponse.message);
    homeResponse.wishlistcount++;
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => widget));
  }
  return "Success!";
}
