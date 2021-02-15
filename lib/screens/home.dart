import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
// import 'package:nazarath_app/screens/sideDrawer.dart';
import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';

import 'ProductDetails.dart';
import 'ProductList.dart';
// import 'package:nazarath_app/network/ApiCall.dart';
void main() => runApp(Home());
HomeResponse homeResponse;
class Home extends StatefulWidget {
  final appTitle = 'Home';

  @override
  HomePage createState() => new HomePage();
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //    // debugShowCheckedModeBanner: false,
  //    // title: appTitle,
  //     //home: HomePage(title: appTitle),
  //   );
  // }
}

class HomePage extends State<Home> {
  //final String title;
  AppLifecycleState _notification;

 // HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:home_bg,
        // drawer: SideDrawer(),
        body: FutureBuilder<HomeResponse>(
          future: ApiCall().execute<HomeResponse, Null>('home/en', null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return getFullView(snapshot.data, context,super.widget);
            } else if (snapshot.hasError) {
              return errorScreen('Error: ${snapshot.error}');
            } else {
              return progressBar;
            }
          },
        ));
  }
}

SingleChildScrollView getFullView(
    HomeResponse homeResponse1, BuildContext context,Widget widget) {
  homeResponse=homeResponse1;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(120.0),
                      bottomLeft: Radius.circular(120.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
                child: Container(
                    height: 180,
                    // width: 320,
                      child: //getBannerSlider(homeResponse.banners,180)
                      getOfferSlider(homeResponse.offers,180),
                    // decoration: new BoxDecoration(
                    //     image: new DecorationImage(
                    //   image: new AssetImage("assets/icons/homebanner.png"),
                    //   fit: BoxFit.fill,
                    // ))
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(child: getCategory(homeResponse.categories)),
        ),
        getFeatured(homeResponse.newarrivals,widget),
        getSlider(homeResponse.slider,190),
        getRecommended(homeResponse.newarrivals,widget),
        getBannerSlider(homeResponse.banners,180)
      ],
    ),
  );
}
Container getBottomSlider() {
  return Container(
      height: 150,
      width: double.infinity,
      child: Carousel(
        dotBgColor: Colors.transparent,
        images: [
          AssetImage('assets/icons/banner2.png'),
          // NetworkImage('imageurl'),
          AssetImage("assets/icons/banner1.png"),
          NetworkImage(
              "https://image.shutterstock.com/image-photo/micro-peacock-feather-hd-imagebest-260nw-1127238584.jpg"),
          AssetImage("assets/image3.jpeg"),
          NetworkImage(
              'https://i.pinimg.com/originals/94/dd/57/94dd573e4b4de604ea7f33548da99fd6.jpg'),
        ],
      ));
}
Container getCategory(List<Categories> categories) {
  if (categories == null)
    return Container(
      child:SizedBox(
        height: 0.01,
      ),
    );
  else if (categories.length == 0) return Container(
    child:SizedBox(
      height: 0.01,
    ),
  );
  return Container(
    child: Container(
      width: double.infinity,
      color: home_bg,
      padding: EdgeInsets.only(top:10),
      child: Column(
        children: [
          Text("Categories",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            color: home_bg,
            height: 120,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductScreen(categories[index].category.slug,"category")),
                        );

                      },
                      child: Container(
                          child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                '$categoryThumbUrl${categories[index].category.image}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              categories[index].category.name,
                              style: TextStyle(fontSize: 11, color: Colors.black),
                            ),
                          ),
                        ],
                      )),
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}

Container getFeatured(List<Newarrivals> featured,Widget widget) {
  if (featured == null)
     return Container(
    child:SizedBox(
      height: 0.01,
    ),
  );
  else if (featured.length == 0)  return Container(
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
            padding: const EdgeInsets.only(top: 10),
            child: Text("Featured Products",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
            color: Color(0xFFe5eeef),
            height: 170,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featured.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProductDetailsScreen(featured[index].slug)),
                        );
                      },
                      child: Container(
                        width: 130,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 2, right: 2),
                                  child: Container(

                                    height: 50,
                                    child: Image(
                                      image: new NetworkImage(
                                          '$productThumbUrl${featured[index].image}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, left: 10, right: 6),
                                    child: Text(
                                      featured[index].name,
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
                                            color: button_cart_bg,
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
                                                        addtoCart(featured[index].slug, featured[index].store, context, widget,"1");}
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
                                            child: getWishListIcon(false)),
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
                                                '${featured[index].symbolLeft}${" "}${featured[index].price}${featured[index].symbolRight}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 7,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                '${featured[index].symbolLeft}${" "}${featured[index].oldprice}${featured[index].symbolRight}',
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
                        )
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
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
Future<String>addtoCartReferesh(String slug,String store,BuildContext context,Widget widget,String quantity) async {

  Map body = {
    "slug":slug,
    "quantity":quantity,
    "store":store
  };
  CartResponse cartResponse = await ApiCall()
      .execute<CartResponse, Null>("cart/add/en", body);

  if (cartResponse != null) {
   // ApiCall().showToast(cartResponse.message);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Future<String>addtoCart(String slug,String store,BuildContext context,Widget widget,String quantity) async {

  Map body = {
    "slug":slug,
    "quantity":quantity,
    "store":store
  };
  CartResponse cartResponse = await ApiCall()
      .execute<CartResponse, Null>("cart/add/en", body);

  if (cartResponse != null) {
    ApiCall().showToast(cartResponse.message);
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Future<String>removeFromCart(String slug,String store,BuildContext context,Widget widget) async {

  Map body = {
    "slug":slug,
    "quantity":"0",
    "store":store
  };
  CartResponse cartResponse = await ApiCall()
      .execute<CartResponse, Null>("cart/add/en", body);

  if (cartResponse != null) {
    ApiCall().showToast(cartResponse.message);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
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
      .execute<WishListResponse, Null>("wishlist/add/en", body);

  if (Productresponse != null) {
    ApiCall().showToast(Productresponse.message);
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => widget));
  }
  return "Success!";
}
Container getMiddleBanner() {
  return Container(
    height: 130,
    width: double.infinity,
    child: Image(
      image: new AssetImage('assets/icons/banner1.png'),
      fit: BoxFit.cover,
    ),
  );
}

Container getRecommended(List<Newarrivals> recommended,Widget widget) {
  return Container(
    child: Container(
      width: double.infinity,
      color: featured_bg,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text("Recommended Products",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 10),
            color: Color(0xFFe5eeef),
            height: 150,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommended.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductDetailsScreen(recommended[index].slug)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height:190,
                        width: 160,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          child: Card(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 5, right: 5),
                                    child: Container(

                                      height: 80,
                                      child: Image(
                                        image: new NetworkImage(
                                            '$productThumbUrl${recommended[index].image}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 0,right: 5,left: 5),
                                        child: Container(

                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(

                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 5,right: 3),
                                                  child: Text(
                                                    '${recommended[index].symbolLeft}${" "}${recommended[index].price}${recommended[index].symbolRight}',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 8,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),

                                              Container(

                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 5,right: 10),
                                                  child: Text(
                                                    '${recommended[index].symbolLeft}${" "}${recommended[index].oldprice}${recommended[index].symbolRight}',
                                                    style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontSize: 8,
                                                        decoration:
                                                        TextDecoration.lineThrough),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  addtoWishList(recommended[index].slug, recommended[index].store, context, widget);
                                                } ,
                                                child: ImageIcon(
                                                  AssetImage(
                                                      'assets/icons/favourite.png'),
                                                  size: 14,
                                                  color: colorPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10,right: 5),
                                      child: Text(
                                        recommended[index].name,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:9),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ),
  );
}

Container getMainSlider(List<Banners> banners) {
  return Container(
      height: 150,
      width: double.infinity,
      child: Carousel(
        dotBgColor: Colors.transparent, // onImageTap: ,
        images: [
          AssetImage('assets/icons/banner1.png'),
          // NetworkImage('imageurl'),
          AssetImage("assets/icons/banner2.png"),
          NetworkImage(
              "https://image.shutterstock.com/image-photo/micro-peacock-feather-hd-imagebest-260nw-1127238584.jpg"),
          AssetImage("assets/image3.jpeg"),
          NetworkImage(
              'https://i.pinimg.com/originals/94/dd/57/94dd573e4b4de604ea7f33548da99fd6.jpg'),
        ],
      ));
}
Widget getMiddleSlider(List<Banners> banners) {
  return
    CarouselSlider(
      options: CarouselOptions(
        // height: 150.0,
        // enlargeCenterPage: true,
        disableCenter: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1.0,),
      items: banners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return getImage(i.image);
          },
        );
      }).toList(),
    );

}

Widget getBannerSlider(List<Banners> banners,double height) {
  return
    CarouselSlider(
      options: CarouselOptions(
        // height: 160.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1.0,
      ),

      items: banners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return getImageBanner(i.image);
          },
        );
      }).toList(),
    );

}

Widget getSlider(List<HomeSlider> sliders,double height) {
  return
    CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1.0,),
      items: sliders.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return getImage(i.image);
          },
        );
      }).toList(),
    );

}
Widget getOfferSlider(List<Offers> offers,double height) {
  return
    CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,

        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1.0,),
      items: offers.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return getImageOffer(i.image);
          },
        );
      }).toList(),
    );

}


Widget getImage(String url)
{
  return Container(
    color: Color(0xFFe5eeef),
    child: FadeInImage.assetNetwork(
      placeholder: 'assets/images/no_image.png',
      image: '$bannerThumbUrl$url',


    ) ,
  );
}
Widget getImageBanner(String url)
{
  return Container(
    color: Color(0xFFe5eeef),
    child: FadeInImage.assetNetwork(
      placeholder: 'assets/images/no_image.png',
      image: '$bannerThumbUrl$url',

    ) ,
  );
}
Widget getImageOffer(String url)
{
  return Container(

    child: FadeInImage.assetNetwork(
      placeholder: 'assets/images/no_image.png',
      image: '$offerThumbUrl$url',
      fit: BoxFit.fitWidth,

    ) ,
  );
}
// Widget getImagesSliders(List<Banners> banners) => ListView.builder(
//     itemBuilder: (context, index) =>
//         getImage(banners[index].image),
//     itemCount: banners.length);
// Widget getImagesOffers(List<Banners> banners) => ListView.builder(
//     itemBuilder: (context, index) =>
//         getImage(banners[index].image),
//     itemCount: banners.length);
// Widget getImagesBanners(List<Banners> banners) => ListView.builder(
//     itemBuilder: (context, index) =>
//         getImage(banners[index].image),
//     itemCount: banners.length);
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
Container getBottomBanner() {
  return Container(
      height: 150,
      width: double.infinity,
      child: Carousel(
        dotBgColor: Colors.transparent, // onImageTap: ,
        images: [
          AssetImage('assets/icons/banner1.png'),
          // NetworkImage('imageurl'),
          AssetImage("assets/icons/banner2.png"),
          NetworkImage(
              "https://image.shutterstock.com/image-photo/micro-peacock-feather-hd-imagebest-260nw-1127238584.jpg"),
          AssetImage("assets/image3.jpeg"),
          NetworkImage(
              'https://i.pinimg.com/originals/94/dd/57/94dd573e4b4de604ea7f33548da99fd6.jpg'),
        ],
      ));
}

