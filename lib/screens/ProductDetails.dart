import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'cart.dart';
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
              getSizeChart()
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
          padding: const EdgeInsets.only(left: 15,top: 20),
          child: Text('Ray-Ban',style: TextStyle(color: Colors.grey,fontSize: 12),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15,top: 5,right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Square Unisex Optical Frames',style: TextStyle(color: Colors.black,fontSize: 15),),
              Text('AED 259.00',style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
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
                    padding: const EdgeInsets.only(top: 5,left: 5),
                    child: Text('12 reviews',style: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text('AED 259.00',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12,decoration: TextDecoration.lineThrough),
            ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10,left: 15),
          child: getCount(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10,left: 15),
          child: getStock(),
        )

      ],

  ));
}
Container getStarRating() {
  return Container(
    height: 10,
    child:
    RatingBar(
        initialRating: 3,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 15,
        ratingWidget: RatingWidget(
            full: Icon(Icons.star, color:colorPrimary),
            half: Icon(
              Icons.star_half,
              color:colorPrimary,
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

  );}
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
        IconButton(icon: Icon(Icons.remove,size: 15,),
        onPressed:(){}
        ),
        Text('1'),
        IconButton(icon: Icon(Icons.add,size: 15,),
          onPressed:(){}),



      ],
    ),
  );}
Container getStock(){
return Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('Availability',style:TextStyle(color: Colors.grey,fontSize: 12),),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text('Instock',style:TextStyle(color: Colors.green,fontSize: 13,fontWeight: FontWeight.bold),),
      ),
    ],
  ),
);
}
Container getSizeChart(){
  return Container(
    width: double.infinity,
    height: 120,
    color: Colors.red,
    child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Color:', style: TextStyle(color: Colors.black,fontSize: 12),),
          // getColorList()
      ],
      ),
    ),

  );
}
Container getColorList(){
  return Container(
    child:ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context,int index){
          return ListTile(
              );
        }
    ),
  );
}
