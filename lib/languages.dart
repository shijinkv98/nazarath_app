import 'package:flutter/cupertino.dart';

abstract class Languages {









  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }
  String get editProfile;
  String get appName;

  String get labelWelcome;
  String get labelInfo;

  String get labelSelectLanguage;
  String get profile;
  String get myOrders;
  String get wishlist;
  String get changePassword;
  String get myWallet;
  String get stores;
  String get guest ;
  String get aboutUs;
  String get dontHaveAccount;
  String get orderHistory;
  String get contactUs;
  String get contest;
  String get termsOfUse;
  String get favorites;
  String get logout;
  String get viewAll;
  String get notification;
  String get news;
  String get home;
  String get checkup;

  String get featuredProducts;
  String get recommendedProducts;
  String get newArrivals;
  String get categories;

  String get newOffers;
  String get weeklyOffers;
  String get by;
  String get userName;
  String get userNameCaps;
  String get email;
  String get emailCaps;
  String get phoneNumber;
  String get phoneNumberCaps;
  String get thisFieldRequired;

  String get myAddress;
  String get savedPower;
  String get referToFriend;
  String get privacyPolicy ;
  String get invalidEmail;
  String get enterValidNumber;
  String get minEightCharecterRequired;
  String get passWord;
  String get passWordCaps;
  String get confirmPassWord;
  String get confirmPassWordCaps;
  String get  register;
  String get login;
  String get signIn;
  String get createAccount;
  String get forgotPassword;
  String get wantToQuit;
  String get ok;
  String get cancel;

  String get otpVerification;
  String get enterTheCodeSendToYou;
  String get confirm;
  String get dontRecieveOtp;
  String get filter;
  String get sort;
  String get resendOtp;
  String get editAddress;
  String get addAddress;
  String get update;
  String get discountCode;
  String get subTotal;
  String get shipping;
  String get total;
  String get deliveryAddress;
  String get shippingAddress;
  String get eyePowerEnterManually;
  String get rxODLeft;
  String get rxODRight;
  String get axisLeft;
  String get axisRight;
  String get cyl;
  String get cylRight;
  String get cylLeft;



}