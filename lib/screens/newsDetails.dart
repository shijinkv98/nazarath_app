import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/newsdetailsresponse.dart';
import 'package:nazarath_app/screens/home.dart';
import 'package:nazarath_app/screens/news.dart';
import 'package:nazarath_app/screens/order.dart';

import 'cart.dart';
import 'notification.dart';

// ignore: must_be_immutable
class NewsDetailsScreen extends StatefulWidget {
  String title;
  NewsDetailsScreen(String title)
  {
    this.title=title;
  }
  @override
  _NewsDetailsScreenState createState() => new _NewsDetailsScreenState(slug: title);
}
class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  String slug;
  _NewsDetailsScreenState({ this.slug}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Home('');
          //
          //   },
          // ),

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
        ),      backgroundColor: Colors.white,
      body:
      FutureBuilder<NewsDetailsResponse>(
        future: ApiCall()
            .execute<NewsDetailsResponse, Null>('${"news/show/"}$slug${"/en"}', null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getNewsScreen(snapshot.data,context,super.widget);
          } else if (snapshot.hasError) {
            return  getEmptyContainerNews(context);return errorScreen('Error: ${snapshot.error}');
           // return getEmptyContainerOrder(context);
          } else {
            return progressBar;
          }
        },
      )
     // getNewsScreen(item,context,widget)


    );
  }

}
Container getEmptyContainerNews(BuildContext context)
{
  return Container(
      height: double.infinity,
      child: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                "assets/icons/news.png",height: 50,),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "No Details Available",
                style: TextStyle(
                    color: Colors.grey[500],fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),

          ],),
      )
  );



}
Container getNewsScreen(NewsDetailsResponse response,BuildContext context,Widget widget){

  return Container(
    child: Column(
      children: [
        getTopContainer(),
        getNews(),
        getNewsDetails(response.news, context, widget),


      ],
    ),
  );
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
Container getNewsDetails(News item,BuildContext context,Widget widget){
  return Container(
    child: Column(
      children: [
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 25,left: 20),
            child: Text(item.createdAt!=null?item.createdAt:"",style: TextStyle(color: textColor,fontSize: 12,),textAlign: TextAlign.start,),
          ),
        ),
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 5,left: 20),
            child: Text(item.title!=null?item.title:"",style: TextStyle(color: textColor,fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
          ),
        ),
        Padding(
          padding:const EdgeInsets.only(top: 5,left: 20,right: 20),
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: 200,
            child: Center(
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/no_image.png',
                  image: '$newsImageUrl${item.image}',
                  width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Padding(
          padding:const EdgeInsets.only(top: 5,left: 20,right: 20),
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Text(item.details!=null?item.details:"",
            style: TextStyle(color: textColor,fontSize: 12),
            ),
          ),
        ),
        Padding(
          padding:const EdgeInsets.only(top: 15,left: 20,right: 20),
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Text(item.name!=null?item.name:"" ,style: TextStyle(color: textColor,fontSize: 12,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding:const EdgeInsets.only(top: 8,left: 20,right: 20),
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Text(item.description!=null?item.description:"",
              style: TextStyle(color: textColor,fontSize: 12),
            ),
          ),
        ),

      ],
    ),
  );}
// Text(item.createdAt,style: TextStyle(color: textColor,fontSize: 12,),textAlign: TextAlign.start,),