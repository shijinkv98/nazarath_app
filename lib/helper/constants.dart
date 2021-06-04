import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nazarath_app/languages.dart';
import 'package:nazarath_app/main.dart';
import 'package:nazarath_app/network/ApiCall.dart';
import 'package:nazarath_app/notifiers/dashboardnotifier.dart';
import 'package:nazarath_app/screens/DashBoard.dart';
import 'package:nazarath_app/screens/cart.dart';
import 'package:nazarath_app/screens/changePassword.dart';
import 'package:nazarath_app/screens/languagescreen.dart';
import 'package:nazarath_app/screens/notification.dart';
import 'package:nazarath_app/screens/order.dart';
import 'package:nazarath_app/screens/searchscreen.dart';
import 'package:nazarath_app/screens/wallet.dart';
import 'package:nazarath_app/screens/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color colorPrimary = Color(0xFF5BC4BF);
const Color bottom_nav_bg = const Color.fromRGBO(68, 204, 192, 1.0);
const Color slider_bg = const Color.fromRGBO(55, 192, 182, 1.0);
const Color button_cart_bg = const Color.fromRGBO(77, 219, 207, 1.0);
const Color colorRed =const Color.fromRGBO(239, 89, 30, 1.0);
const Color product_bg =const Color.fromRGBO(245, 245, 245, 1.0);
const Color tab_bg =const Color.fromRGBO(239, 239, 239, 1.0);
const Color home_bg =const Color.fromRGBO(255, 255, 255, 1.0);
const Color featured_bg =const Color.fromRGBO(228, 238, 239, 1.0);
const Color text_tilte_page =const Color.fromRGBO(108, 108, 108, 1.0);
const Color item_text_gray =const Color.fromRGBO(174, 174, 174, 1.0);
const Color item_text_gray_light =const Color.fromRGBO(201, 201, 201, 1.0);


const Color textColor = Color(0xFF616161);
const Color textColorSecondary = Color(0xFF999999);
// const String BASE_URL = "https://alranna.alisonsdemo.tk/";
const String BASE_URL = "https://nazarath.webdemos.cf/";
 const Color gradientEnd = Color(0xFF5BC4BF);
const Color primaryTextColor = Color(0xFF5BC4BF);
const Color primaryIconColor = Color(0xFF5BC4BF);
String wish_c="0",cart_c="0",noti_c="0";
const String productThumbUrl = '${BASE_URL}images/product/thumbnail/';
const String newsThumbUrl = '${BASE_URL}images/blog/thumbnail/';
const String newsImageUrl = '${BASE_URL}images/blog/';
const String categoryThumbUrl = '${BASE_URL}images/category/thumbnail/';
const String bannerThumbUrl = '${BASE_URL}images/banner/';
const String offerThumbUrl = '${BASE_URL}images/offer/';
const double padding = 10.0;
const contryCode = 971;
const double appTabIconSize=25.0;
const double appTabTop=0;
const double appTabBottom=20;
const double appTabIconPad=5;

const double appTabLeft=0;
const double appTabRight=0;
const double appTabImageSize=75.0;
const double register_icon_size=16.0;
const double font_size_head=16.0;
const double field_text_size=10.0;
const double primary_margin=10.0;
const double space=15.0;
const double space2=30.0;
const double header_text_size=16.0;
const double border_radius=65.0;
const double forms_padding=25.0;
const double header_padding=25.0;
const double normal_space=10.0;
const double register_logo_size=80.0;
const double container_space=40.0;
const double button_text_size=14.0;
String deviceToken = "";
String deviceId = "";
String currency = "AED";
String country_code="+971";
const double home_wish_size=24;
// public static final String PRODUCT_URL = MAIN_URL + "images/product/";
// public static final String BANNER_URL = MAIN_URL + "images/banner/";

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

Widget errorScreen(String errorTitle) => Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        Icons.error_outline,
        color: colorRed,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(errorTitle),
      )
    ],
  ),
);
const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}
String selectLanguage="en";
Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('en', '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  MyApp.setLocale(context, _locale);
}
void setCounts(int wish,int cart, int noti)
{
  // notificationCounterValueNotifer =
  //     ValueNotifier(cart);
  notificationCounterValueNotifer.value=10;
  notificationCounterValueNotifer.notifyListeners();
  cart_c=cart.toString();
  wish_c=wish.toString();
  noti_c=noti.toString();
}
const Color transparent=Color(0x00000000);
BoxDecoration zredBorder=BoxDecoration(
    color: transparent,
    borderRadius:
    BorderRadius.only(bottomRight: Radius.circular(3.0)),
    border: Border.all(
        color: colorPrimary,
        width: 1

    ),
);
BoxDecoration filledBorder=BoxDecoration(
    color: colorPrimary,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(3.0)),
);
void saveCounts(String wish,String cart,String notification)
{
  ApiCall().saveCartCount(cart);
  ApiCall().saveWishListCount(wish);
  ApiCall().saveNotificationCount(notification);
}
Widget progressBar = InkWell(
  child: SafeArea(
    child: Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
        width: 60,
        height: 60,
      ),
    ),
  ),
);
AppBar getAppBarMain(BuildContext context)
{
  AppBar(
    centerTitle: true,
    // titleSpacing: 100,
    leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>SearchScreen(from: "",hint: "Search products",)),
              );
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
  );
}

Container getTopContainer(String title)
{
  return Container(
    child: Column(
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100.0),bottomLeft: Radius.circular(100.0)),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
                child: Container(
                    height: 100,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/icons/inner_banner.png"),
                          fit: BoxFit.fill,
                        )
                    )
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            title,
            style: TextStyle(
                color: text_tilte_page,fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );

}
Container getEmptyContainer(BuildContext context,String emptyText,String imagename)
{
  return Container(
      height: double.infinity,
      child: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                '${"assets/icons/"}$imagename${".png"}',height: 50,),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                emptyText,
                style: TextStyle(
                    color: Colors.grey[500],fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
                elevation: 0.0,
                borderRadius: BorderRadius.circular(5.0),
                color: colorPrimary,
                child: MaterialButton(
                  minWidth: 100,
                  padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),);
                  },

                  child: Text(Languages.of(context).continueShopping,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,fontSize: 13,fontWeight: FontWeight.normal)),
                )
            ),
           // getBottomTabPannel(context)
          ],),
      )
  );



}

Widget getBottomTabPannel(BuildContext context )
{
  return Container(
    color: colorPrimary,
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          child: getIndividualTab('assets/icons/home_white.png', "HOME"),
          onTap: (){
            tbPosition=0;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          },
        ),
        GestureDetector(
          child: getIndividualTab('assets/icons/check_up_white.png', "CHECKUP"),
          onTap: (){
            tbPosition=1;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          },
        ),
        GestureDetector(
          child: getIndividualTab('assets/icons/stores_white.png', "STORES"),
          onTap: (){
            tbPosition=2;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          },
        ),
        GestureDetector(
          child: getIndividualTab('assets/icons/profile_white.png', "PROFILE"),
          onTap: (){
            tbPosition=3;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          },
        ),
        GestureDetector(
          child: getIndividualTab('assets/icons/news_white.png', "NEWS"),
          onTap: (){
            tbPosition=4;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          },
        )
      ],
    ),
  );
}
var customerData;
var loginData;
Widget getSideDrawerHome(BuildContext context)
{
 var customer=customerData;
 var login_data=loginData;
    return Container(
      color: Colors.white,
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
                              Text(Languages.of(context).profile,style:TextStyle(color:Colors.white),)
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
                              Text(Languages.of(context).myOrders,style:TextStyle(color:Colors.white),)
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
                              Text(Languages.of(context).wishlist,style:TextStyle(color:Colors.white),)
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
                              Text(Languages.of(context).myWallet,style:TextStyle(color:Colors.white),)
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
                              Text(Languages.of(context).changePassword,style:TextStyle(color:Colors.white),)
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
                              Text(Languages.of(context).stores,style:TextStyle(color:Colors.white),)
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
                              Text(Languages.of(context).notification,style:TextStyle(color:Colors.white),)
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
                              ImageIcon(AssetImage('assets/icons/language_icon.png'),color: Colors.white,),
                              SizedBox(width: 10),
                              Text(Languages
                                  .of(context)
                                  .labelSelectLanguage,style:TextStyle(color:Colors.white),)
                            ],
                          ), onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => languageScreen("")),
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
                              Text(Languages.of(context).news,style:TextStyle(color:Colors.white),)
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
                              Text(Languages.of(context).logout,style:TextStyle(color:Colors.white),)
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
Widget homeAppbar(BuildContext context,DashBoardUpdateNotifier notifier)
{
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    // titleSpacing: 100,
    // leading: SideDrawer(),
    title: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: appTabBottom, top: appTabTop),
        child: ImageIcon(
          AssetImage("assets/icons/nazarath_logo.png"),
          size: appTabImageSize,
          color: Colors.white,
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
              child: ImageIcon(AssetImage("assets/icons/search.png"), color: Colors.white,),
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
              child: Stack(
                  children:[ Align(
                      alignment: Alignment.center,
                      child: ImageIcon(AssetImage("assets/icons/notification.png"),color: Colors.white,)),
                    Consumer<DashBoardUpdateNotifier>(
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Align(
                              alignment: Alignment.topRight,
                              child:notifier.notificationCount!=null?notifier.notificationCount!="0"?CircleAvatar(
                                  radius:7,
                                  backgroundColor: Colors.white,
                                  child: Text( notifier.notificationCount,style: TextStyle(color: colorPrimary,fontSize: 10),)):SizedBox():SizedBox()),
                        );
                      },
                    )
                  ]),
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
                child: Stack(
                    children:[ Align(
                        alignment:Alignment.center,
                        child: ImageIcon(AssetImage("assets/icons/favorite.png"), color: Colors.white,)),
                      Consumer<DashBoardUpdateNotifier>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Align(
                                alignment: Alignment.topRight,
                                child:notifier.wishListCount!=null?notifier.wishListCount!="0"?CircleAvatar(
                                    radius:7,
                                    backgroundColor: Colors.white,
                                    child: Text( notifier.wishListCount,style: TextStyle(color: colorPrimary,fontSize: 10),)):SizedBox():SizedBox()),
                          );
                        },
                      )
                    ]
                )

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
            child: Stack(
                children:[ Align(
                    alignment: Alignment.center,

                    child: ImageIcon(AssetImage("assets/icons/cart.png"), color: Colors.white,)),
                  Consumer<DashBoardUpdateNotifier>(
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Align(
                            alignment: Alignment.topRight,
                            child:notifier.cartCount!=null?notifier.cartCount!="0"?CircleAvatar(
                                radius:7,
                                backgroundColor: Colors.white,
                                child: Text( notifier.cartCount,style: TextStyle(color: colorPrimary,fontSize: 10),)):SizedBox():SizedBox()),
                      );
                    },
                  )


                ]),
          ),
        ),
      ),


    ],
  );
}
DashBoardUpdateNotifier dashBoardUpdateNotifier;
Widget notificationAppbar()
{

}
Widget wishlistAppbar()
{

}
Widget cartAppbar()
{

}
Widget getIndividualTab(String imagePath,String title)
{
  return
    Container(
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
                  title,
                  style: TextStyle(fontSize: 12),
                ),
                //text: 'STORES',

              ),
            ),

          ],
        ));
}