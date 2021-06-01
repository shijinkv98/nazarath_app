import 'package:flutter/material.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
class CheckoutUpdatedNotifier extends ChangeNotifier {
  bool _isProgressShown=false;
  bool _isAdded=false;
  bool get isProgressShown => _isProgressShown;
  bool get isAdded => _isAdded;

  set isProgressShown(bool duty)
  {
    _isProgressShown=duty;
    notifyListeners();
  }
  set isAdded(bool duty) {
    _isAdded = duty;
    notifyListeners();
  }
  void update()
  {
    notifyListeners();
  }

  void reset() {
    _isProgressShown=false;
    _isAdded=false;
  }
}
