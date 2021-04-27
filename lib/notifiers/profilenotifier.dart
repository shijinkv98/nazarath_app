import 'package:flutter/material.dart';
class ProfileUpdateNotifier extends ChangeNotifier {
  bool _isProgressShown=false;
  bool get isProgressShown => _isProgressShown;
  set isProgressShown(bool duty)
  {
    _isProgressShown=duty;
    notifyListeners();
  }
}
