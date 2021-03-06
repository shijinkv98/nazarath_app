// import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/gestures.dart';
import 'package:nazarath_app/Constants/dart/constants.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // titleSpacing: 100,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
        title: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50, top: 20),
            child: ImageIcon(
              AssetImage("assets/icons/nazarath_logo.png"),
              size: 100,
            ),
          ),
        ),
        backgroundColor: colorPrimary,
        elevation: 0,

        actions: <Widget>[
          // ImageIcon(AssetImage("assets/icons/nazarath_logo.png"),size: 100,)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 20,
              width: 20,
              child: ImageIcon(AssetImage("assets/icons/search.png"),),

              ),
            ),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 20,
              width: 20,
              child: ImageIcon(AssetImage("assets/icons/notification.png"),),

              ),
            ),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 20,
              width: 20,
              child: ImageIcon(AssetImage("assets/icons/favourite.png"),),

              ),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 20,
              width: 20,
              child: ImageIcon(AssetImage("assets/icons/cart.png"),),


              ),
            ),

        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: colorPrimary,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 30, bottom: 10),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: AssetImage('assets/icons/no_image.png'
                        // NetworkImage(''
                        // profileData.user.getImage()
                        ),
                    // child: _image != null
                    //     ? ClipRRect(
                    //   borderRadius:
                    //   BorderRadius.circular(55),
                    //   child: Image.file(
                    //     _image,
                    //     width: 110,
                    //     height: 110,
                    //     fit: BoxFit.cover,
                    //   ),
                    // )
                    //     : Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.transparent,
                    //       borderRadius:
                    //       BorderRadius.circular(55)),
                    //   width: 115,
                    //   height: 115,
                    //   child: Icon(
                    //     Icons.camera_alt,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 20),
                      child: Text('Muhd. Rafeeque',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text('muhdsalam@gmail.com',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: colorPrimary,
            child: Container(
              // height: double.infinity,
              width: double.infinity,
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 10),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0)),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/edit_profile.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('Edit Profile',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),

                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/my_orders.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('My Orders',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/my_address.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('My Addresses',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/saved_power.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('Saved Power',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/wallet.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('Wallet',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/refer_to_friend.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('Refer to Friend',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/favourite.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('Favourite',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/change_password.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('Change Password',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/privacy_policy.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('Privacy Policy',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/icons/log_out.png'),color: Colors.grey[700],),
                        SizedBox(width: 10),
                        Text('Logout',style:TextStyle(color:Colors.grey[700] ),)
                      ],
                    ), onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
