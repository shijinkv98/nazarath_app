import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
// import 'package:nazarath_app/screens/sideDrawer.dart';
import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
// import 'package:nazarath_app/network/ApiCall.dart';
void main() => runApp(Home());

class Home extends StatelessWidget {
  final appTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  AppLifecycleState _notification;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // drawer: SideDrawer(),
        body: FutureBuilder<HomeResponse>(
          future: ApiCall().execute<HomeResponse, Null>('home/en', null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return getFullView(snapshot.data, context);
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
    HomeResponse homeResponse, BuildContext context) {
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

                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                      image: new AssetImage("assets/icons/homebanner.png"),
                      fit: BoxFit.fill,
                    ))),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(child: getCategory(homeResponse.categories)),
        ),
        getFeatured(homeResponse.newarrivals),
        getMiddleSlider(),
        getRecommended(),
        getBottomSlider()
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
    return Container();
  else if (categories.length == 0) return Container();
  return Container(
    child: Container(
      width: double.infinity,
      child: Column(
        children: [
          Text("Categories",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Colors.white,
            height: 120,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
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
                  );
                }),
          ),
        ],
      ),
    ),
  );
}

Container getFeatured(List<Newarrivals> featured) {
  if (featured == null)
    return Container();
  else if (featured.length == 0) return Container();
  return Container(
    child: Container(
      width: double.infinity,
      color: Color(0xFFe5eeef),
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
            height: 210,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featured.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 160,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 5, right: 5),
                                child: Container(
                                  height: 70,
                                  child: Image(
                                    image: new AssetImage(
                                        'assets/icons/product1.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 6),
                                  child: Text(
                                    featured[index].name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 35,
                                    alignment: Alignment.bottomLeft,
                                    decoration: BoxDecoration(
                                        color: colorPrimary,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Center(
                                        child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                      onPressed: () {
                                        // Do something
                                      },
                                    )),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            // onTap: ,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: ImageIcon(
                                                AssetImage(
                                                    'assets/icons/favourite.png'),
                                                size: 20,
                                                color: colorPrimary,
                                              ),
                                            ),
                                          )),
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
                                              '${featured[index].symbolLeft}${" "}${featured[index].price}${featured[index].symbolRight}',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              '${featured[index].symbolLeft}${" "}${featured[index].oldprice}${featured[index].symbolRight}',
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => widget));
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

Container getRecommended() {
  return Container(
    child: Container(
      width: double.infinity,
      color: Color(0xFFe5eeef),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Recommended Products",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
            color: Color(0xFFe5eeef),
            height: 210,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 5, right: 5),
                                  child: Container(
                                    height: 70,
                                    child: Image(
                                      image: new AssetImage(
                                          'assets/icons/product1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10,right: 5,left: 5),
                                      child: Container(
                                        height: 25,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 25,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 8,right: 3),
                                                child: Text(
                                                  'AED 259.000',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),

                                            Container(
                                                height: 25,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 10,right: 5),
                                                  child: Text(
                                                    'AED 259.0',
                                                    style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontSize: 8,
                                                        decoration:
                                                            TextDecoration.lineThrough),
                                                  ),
                                                ),
                                              ),
                                            InkWell(
                                              // onTap: ,
                                              child: ImageIcon(
                                                AssetImage(
                                                    'assets/icons/favourite.png'),
                                                size: 20,
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
                                    child: AutoSizeText(
                                      'Zyden Black & silver Rectangular',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ]),
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

Container getMiddleSlider() {
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

