import 'package:flutter/material.dart';
import 'package:nazarath_app/model/user.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
class DashBoardUpdateNotifier extends ChangeNotifier {
  String _cartCount="0";
  String _wishListCount="0";
  String _notificationCount="0";
  UserData _user=null;
  HomeResponse _homeResponse=null;
  HomeResponse get homeResponse=>_homeResponse;
  UserData get user=>_user;
  String get notificationCount=>_notificationCount;
  set notificationCount(String count)
  {
    _notificationCount=count;
    notifyListeners();
  }
  String get wishListCount=>_wishListCount;
  set wishListCount(String count)
  {
    _wishListCount=count;
    notifyListeners();
  }
  void update()
  {
    notifyListeners();
  }
  String get cartCount=>_cartCount;
  set cartCount(String count)
  {
    _cartCount=count;
    notifyListeners();
  }
   set homeResponse(HomeResponse response)
   {
     _homeResponse=response;
     notifyListeners();
   }
  set user(UserData response)
  {
    _user=response;
    notifyListeners();
  }

  void reset() {
     _cartCount="0";
     _wishListCount="0";
     _notificationCount="0";
     _user=null;
    _homeResponse=null;
  }
}
