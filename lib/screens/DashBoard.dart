import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/Screens/login.dart';
import 'package:nazarath_app/helper/common.dart';
import 'package:nazarath_app/helper/constants.dart';
import 'package:nazarath_app/model/user.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/network/LogoutResponse.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
import 'package:nazarath_app/network/response/LoginResponse.dart';
import 'package:nazarath_app/network/response/ProfileResponse.dart';
import 'package:nazarath_app/screens/ProductList.dart';
import 'package:nazarath_app/screens/cart.dart';
import 'package:nazarath_app/screens/checkout.dart';
import 'package:nazarath_app/screens/checkup.dart';
import 'package:nazarath_app/screens/custom/notificationbadge.dart';
import 'package:nazarath_app/screens/checkup.dart';
import 'package:nazarath_app/screens/sideDrawer.dart';
import 'package:nazarath_app/screens/store.dart';
import 'package:nazarath_app/screens/wallet.dart';
import 'package:nazarath_app/screens/wishlist.dart';
import 'package:nazarath_app/custom/namedicon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'changePassword.dart';
import 'home.dart';
import 'news.dart';
import 'notification.dart';
import 'order.dart';
import 'profile.dart';
import 'register/register.dart';
DefaultTabController controller;
TabController _controller;

class DashBoard extends StatefulWidget {
  @override
  _DashBoard createState() => _DashBoard();

}

int tbPosition = 0;
//var homeResponse;


String userName="",userEmail;
final ValueNotifier<int> notificationCounterValueNotifer=ValueNotifier(0);

class _DashBoard extends State<DashBoard> {
  var customer;
  var login_data;
  @override
  void initState() {
    customer=new UserData();
    login_data=new LoginResponse();
    getHomeData(context);
    super.initState();


  }

  Future<void> getHomeData(BuildContext context)
  async {

    ApiCall().context=context;
    customer=await ApiCall().getUser();
    login_data=await ApiCall().getLoginResponse();
    // if(login_data!=null)
    // {
    //   if(login_data.guest_id!="")
    //     {
    //       var response = await ApiCall()
    //           .execute<ProfileResponse, Null>('my-profile/en', null);
    //       if(response!=null)
    //         {
    //           userName=response.name;
    //           userEmail=response.email;
    //         }
    //     }
    // }



    // Map body = {
    //   // name,email,phone_number,passwor
    // };
    // homeResponse = await ApiCall()
    //     .execute<HomeResponse, Null>("home/en", body);
    //
    // if (homeResponse != null) {
    //
    //   ApiCall().showToast(homeResponse.categories.toString());
    // }
  }
  @override
  Widget build(BuildContext context) {
    debugPrint('MJM HomeScreen build()');
    //notificationCounterValueNotifer=ValueNotifier(0);
    controller =getTabController(context);

    return customer!=null?controller:CircularProgressIndicator();
  }
  Widget getSideDrawer()
  {
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
                                              child: Text(customer==null?"GUEST":customer.name!=null&&customer.name!=""?customer.name:"GUEST",
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
                                              child: AutoSizeText(customer==null?"":customer.email!=null&&customer.email!=""?customer.email:"",
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
                          if(login_data.guest_id != null && login_data.guest_id.length>0)
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
                          if(login_data.guest_id != null && login_data.guest_id.length>0)
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
                          if(login_data.guest_id != null && login_data.guest_id.length>0)
                            gotoLogin(context);
                          else
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChangePasswordScreen("",customer)),
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
                          if(login_data.guest_id != null && login_data.guest_id.length>0)
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
  DefaultTabController getTabController(BuildContext contexT)
  {

    return  DefaultTabController(
      length: 5,
      initialIndex: tbPosition,
      child: Scaffold(

        appBar:AppBar(
          centerTitle: true,
          // titleSpacing: 100,
          // leading: SideDrawer(),
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
            // NotificationBadge(notificationCounterValueNotifer),
            Padding(
                padding: const EdgeInsets.only(right: appTabIconPad),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationScreen("notification")),
                    );
                  },
                  child: Container(
                    height: appTabIconSize,
                    width: appTabIconSize,
                    child: ImageIcon(AssetImage("assets/icons/notification.png"),),
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
        drawer: getSideDrawer(),
        // drawer: SideDrawer(),

        bottomNavigationBar:getBottomNav(context) ,
        body:
        TabBarView(
          children: <Widget>[
            Home(),
            CheckUpScreen(),
            //ProductScreen("s"),
            StoreScreen(""),

            Profile(),
            NewsScreen("checkout"),
          ],
        ),

      ),
    );
  }
}

Container getBottomNav(BuildContext context)
{

  return Container(
    color: bottom_nav_bg,
    child: TabBar(
      tabs: [
        _individualTab('assets/icons/home_white.png'),
        _individualTab2('assets/icons/check_up_white.png'),
        _individualTab3('assets/icons/stores_white.png'),
        _individualTab4('assets/icons/profile_white.png'),
        _individualTab5('assets/icons/news_white.png'),
        // Tab(
        //   icon: ImageIcon(AssetImage('assets/icons/bottom_nav/Email.png')),
        // ),
      ],
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.all(0),
      indicatorPadding: EdgeInsets.all(0),
    ),
  );
}

Widget _individualTab(String imagePath) {

  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: bottom_nav_bg, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath),
                size: 20,),
              child: Text(
                "HOME",
                style: TextStyle(fontSize: 12),
              ),
              //text: 'STORES',

            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey,
              width: 0.3,
              height: 50,
            ),
          )
        ],
      ));
}

Widget _individualTab2(String imagePath) {

  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: bottom_nav_bg, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath),
                size: 20,),
              child: Text(
                "CHECKUP",
                style: TextStyle(fontSize: 12),
              ),
              //text: 'STORES',

            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey,
              width: 0.3,
              height: 50,
            ),
          )
        ],
      ));
}

Widget _individualTab3(String imagePath) {
  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: bottom_nav_bg, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath),
              size: 20,),
              child: Text(
                "STORES",
                style: TextStyle(fontSize: 12),
              ),
              //text: 'STORES',

            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey,
              width: 0.3,
              height: 50,
            ),
          )
        ],
      ));
}

Widget _individualTab4(String imagePath) {

  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: bottom_nav_bg, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath),
                size: 20,),
              child: Text(
                "PROFILE",
                style: TextStyle(fontSize: 12),
              ),
              //text: 'STORES',

            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.grey,
              width: 0.3,
              height: 50,
            ),
          )
        ],
      ));

}

Future<void> logout(BuildContext context)
async {
  ApiCall().saveUser("");
  ApiCall().saveLoginResponse("");
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => Login()));
  // LogoutResponse logoutResponse = await ApiCall()
  //     .execute<LogoutResponse, Null>("logout/en", null);
  //   if(logoutResponse!=null)
  //     {
  //       gotoLogin(context);
  //     }

}
Future<void> gotoLogout(BuildContext context)
async {

  await ApiCall().saveUser("");
  await ApiCall().saveLoginResponse("");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => Login()));
}
void gotoLogin(BuildContext context) {

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => Login()));
}
Widget _individualTab5(String imagePath) {
  return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: bottom_nav_bg, width: 0, style: BorderStyle.solid),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Tab(
              icon: ImageIcon(AssetImage(imagePath),
                size: 20,),
              child: Text(
                "NEWS",
                style: TextStyle(fontSize: 12),
              ),
              //text: 'STORES',

            ),
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Container(
          //     color: Colors.grey,
          //     width: 0.5,
          //     height: 50,
          //   ),
          // )
        ],
      ));



}

