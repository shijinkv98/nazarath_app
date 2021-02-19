import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/network/response/WalletResponse.dart';
import 'package:nazarath_app/screens/checkout.dart';
import 'package:nazarath_app/screens/checkup.dart';
import 'package:nazarath_app/screens/news.dart';
import 'package:nazarath_app/screens/personalinformation.dart';
import 'package:nazarath_app/screens/products.dart';
import 'package:nazarath_app/screens/store.dart';
import 'package:nazarath_app/screens/wallet.dart';
import 'package:nazarath_app/screens/wishlist.dart';

import 'DashBoard.dart';
import 'changePassword.dart';
import 'notification.dart';
import 'order.dart';

class SideDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(

    child:Drawer(

      child: Container(
        color: slider_bg,
        height: double.infinity,

        child: SingleChildScrollView(

          child: Container(
            color: slider_bg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [

                Container(
                    child: Container(

                      child:Container(

                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(45.0)),
                            ),
                            height: 150,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 45, top: 30, bottom: 10),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: AssetImage('assets/icons/no_image.png'
                                      // NetworkImage(''
                                      // profileData.user.getImage()
                                    ),

                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 6),
                                          child: Text(customer.name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 180,

                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 6),
                                          child: AutoSizeText(customer.email,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))

                    )),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/edit_profile.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('My Profile',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        tbPosition=3;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => DashBoard()),
                        );
                      },
                      ),
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/my_orders.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('My Orders',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        if(customer.guest_id==null||!customer.guest_id.isEmpty())
                          gotoLogin(context);
                        else
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrderScreen()),
                        );
                      },
                      ),
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/favourite.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('Wishlist',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WishListScreen()),
                        );
                      },
                      ),
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/wallet.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('My Wallet',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        if(customer.guest_id==null||!customer.guest_id.isEmpty())
                          gotoLogin(context);
                        else
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WalletScreen("")),
                          );
                      },
                      ),
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/change_password.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('Change Password',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        if(customer.guest_id==null||!customer.guest_id.isEmpty())
                          gotoLogin(context);
                        else
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePasswordScreen("")),
                        );
                      },
                      ),
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/stores.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('Stores',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        tbPosition=2;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => DashBoard()),
                        );
                      },
                      ),
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/notification.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('Notifications',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationScreen("Notification is empty")),
                        );
                      },
                      ),
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/news_white.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('News',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        tbPosition=4;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => DashBoard()),
                        );

                      },
                      ),
                      FlatButton(
                        color: slider_bg,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ImageIcon(AssetImage('assets/icons/log_out.png'),color: Colors.white,),
                            SizedBox(width: 10),
                            Text('Logout',style:TextStyle(color:Colors.white),)
                          ],
                        ), onPressed: () {
                        if(customer.guest_id==null||!customer.guest_id.isEmpty())
                          gotoLogin(context);
                        else
                        logout(context);
                      },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

}