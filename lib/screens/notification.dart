
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/response/NotificationResponse.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'cart.dart';

class NotificationScreen extends StatefulWidget {
  String title;
  NotificationScreen(String title)
  {
    this.title=title;
  }
  @override
  _NotificationState createState() => new _NotificationState(title: title);
}
class _NotificationState extends State<NotificationScreen> {
  String title;
  _NotificationState({ this.title}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // titleSpacing: 100,
        automaticallyImplyLeading: true,
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
      backgroundColor: Colors.white,
      body: Container(
        child:FutureBuilder<NotificationResponse>(
          future: ApiCall()
              .execute<NotificationResponse, Null>('notifications/en', null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
            //  debugPrint('products size: ${snapshot.data?.notifications?.length}');
              return getNotificationFull(snapshot.data?.notifications
                  ?.where((element) =>
              element != null )
                  ?.toList(),context,super.widget);
            } else if (snapshot.hasError) {
              return getEmptyContainerNotification();
            } else {
              return progressBar;
            }
          },
        ),
      ),
    );
  }

}
Container getNotificationFull(List<Notifications> products,BuildContext context,Widget widget)
{
  if(products==null)
    return getEmptyContainerWishlist(context);
  else if(products.length==0)
    return getEmptyContainerWishlist(context);
    return Container(
        child: Column(
        children: [
          getTopContainer(),
          _listview(products, context, widget)
        ])
    );
}
Container getTopContainer()
{
  return Container(
    child: Column(
      children: [
        Center(
          child: Text(
            "Notification",
            style: TextStyle(
                color: Colors.grey,fontSize: 11),
          ),
        )
      ],
    ),
  );

}
Container getEmptyContainerNotification()
{
  return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Notification is Empty",
              style: TextStyle(
                  color: Colors.grey,fontSize: 15),
            ),
          )
        ],
      ),
  );

}
Widget _listview(List<Notifications> products,BuildContext context,Widget widget) => ListView.builder(
    padding: EdgeInsets.only(bottom: 70),
    itemBuilder: (context, index) =>
        _itemsBuilder(products[index],context,widget),
    // separatorBuilder: (context, index) => Divider(
    //       color: Colors.grey,
    //       height: 1,
    //     ),
    itemCount: products.length);
Widget _itemsBuilder(Notifications notification,BuildContext context,Widget widget) {
  if(notification.notification==null)
     return Container(
    child:SizedBox(
      height: 0.01,
    ),
  );
  else if (notification.notification.languages==null)
     return Container(
    child:SizedBox(
      height: 0.01,
    ),
  );
  else if (notification.notification.languages.length==0)
     return Container(
    child:SizedBox(
      height: 0.01,
    ),
  );
  return Container(
      margin: const EdgeInsets.only(bottom: 8.0,left: 10.0,top:10,right:20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 2.0,
        ),
      ],
    ),
  child: Column(
    children: [
      SizedBox(
        height: 20,
      ),
      Row(

        children: [
          Padding(
            padding:
            EdgeInsets.fromLTRB(20, 0, 0, 20)),
          CircleAvatar(
            radius: 16.0,
            backgroundImage:
            NetworkImage('$productThumbUrl${notification.notification.languages[0].smallImage}'),
            backgroundColor:colorPrimary,
          ),
          Padding(
              padding:
              EdgeInsets.fromLTRB(padding, 0, 0, 2),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      notification.notification.languages[0].title,
                      style: TextStyle(
                          color: Colors.grey[800], fontWeight: FontWeight.w500,fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification.notification.languages[0].smallDescription,
                      style: TextStyle(
                          color: Colors.grey,fontSize: 11),
                    )
                  ]
              ))
        ]
    ),
      SizedBox(
        height: 20,
      )
    ],
  ),

  );
}
