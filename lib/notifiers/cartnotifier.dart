import 'package:flutter/material.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
class CartUpdatedNotifier extends ChangeNotifier {
  bool _isAdded = false;
  CartResponse cartresponse=null;
  bool get isAdded => _isAdded;
  CartResponse get cartAdded => cartresponse;
  // set Cart( CartResponse response)
  // {
  //   cartresponse=response;
  //   _isAdded=true;
  // }
  set cartAdded(CartResponse response) {
    cartresponse=response;
    _isAdded = true;
    notifyListeners();
  }

  void reset() {
    _isAdded = false;
  }
}
