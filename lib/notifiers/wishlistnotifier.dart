import 'package:flutter/material.dart';
import 'package:nazarath_app/network/response/WishListResponse.dart';

class WishListUpdatedNotifier extends ChangeNotifier {
  WishListResponse _wishListResponse;
   WishListResponse get wishListResponse => _wishListResponse;
  set wishListResponse(WishListResponse response)
  {
    _wishListResponse=response;
    notifyListeners();
  }

  void reset() {
    _wishListResponse=null;
  }
}
