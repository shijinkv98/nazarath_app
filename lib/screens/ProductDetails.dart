import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'ProductList.dart';
import 'cart.dart';
import 'home.dart';
import 'notification.dart';

class ProductDetailsScreen extends StatefulWidget {
  String title;

  ProductDetailsScreen(String title) {
    this.title = title;
  }
  @override
  _ProductDetailsState createState() => new _ProductDetailsState(title: title);
}

class _ProductDetailsState extends State<ProductDetailsScreen> {
  String title;
  _ProductDetailsState({this.title});
  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              getTopContainer(),
              getMiddleSlider(),
              getProductDetails(),
              getSizeChart(),
              getSize(),
              SizedBox(
                height: 25,
              ),
              getTools(),
              getProductDescription(),
              getRecommended(homeResponse.newarrivals,widget),
            ],
          ),
        ));
  }
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

Container getProductDetails() {
  return Container(
      color: product_bg,
      width: double.infinity,
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Text(
              'Ray-Ban',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Square Unisex Optical Frames',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  'AED 259.00',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getStarRating(),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
                      child: Text(
                        '12 reviews',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  'AED 259.00',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough),
                ),
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

Container getStarRating() {
  return Container(
    height: 10,
    child: RatingBar(
        initialRating: 3,
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

Container getCount() {
  return Container(
    width: 110,
    height: 45,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey[300]),
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(2.0),
          topRight: Radius.circular(2.0),
          topLeft: Radius.circular(2.0),
          bottomLeft: Radius.circular(2.0)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(
              Icons.remove,
              size: 15,
            ),
            onPressed: () {}),
        Text('1'),
        IconButton(
            icon: Icon(
              Icons.add,
              size: 15,
            ),
            onPressed: () {}),
      ],
    ),
  );
}

Container getStock() {
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

Container getSize() {
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
            'Size:',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ), //<< any widgets added
          Expanded(
              child: ListView.builder(
                  //here your code
                  scrollDirection: Axis.horizontal,
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2, left: 10),
                      child: Container(
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                        child: Center(
                            child: Text(
                          'xs',
                          style: TextStyle(fontSize: 16),
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

Container getTools() {
  return Container(
      color: product_bg,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child: GestureDetector(
              onTap: () {},
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
              onTap: () {},
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

Container getProductDescription() {
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
          Text(
            'List of scrollable items can be displayed in Android using ListView. It helps you to displaying the data in the form of a scrollable list. Users can then select any list item by clicking on it',
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                //here your code
                scrollDirection: Axis.vertical,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey[300]),
                            left: BorderSide(color: Colors.grey[300]),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Gender',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.72,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey[300]),
                            left: BorderSide(color: Colors.grey[300]),
                            right: BorderSide(color: Colors.grey[300]),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Male',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      Divider(
                        color: Colors.grey[300],
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    ),
  );
}
Container getRecommended(List<Newarrivals> recommended,Widget widget) {
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
            height: 200,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommended.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      width: 140,
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
                                    height: 70,
                                    child: Image(
                                      image: new NetworkImage(
                                          '$productThumbUrl${recommended[index].image}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10,right: 5,left: 10),
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
                                                  '${recommended[index].symbolLeft}${" "}${recommended[index].price}${recommended[index].symbolRight}',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 9  ,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              height: 25,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 10,right: 5),
                                                child: Text(
                                                  '${recommended[index].symbolLeft}${" "}${recommended[index].oldprice}${recommended[index].symbolRight}',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 6,
                                                      decoration:
                                                      TextDecoration.lineThrough),
                                                ),
                                              ),
                                            ),

                                            InkWell(
                                              onTap: (){
                                              //  addtoWishList(recommended[index].slug, recommended[index].store, context, widget);
                                              } ,
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
                                      recommended[index].name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8),
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
