import 'package:flutter/material.dart';
class LoginLoadingNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool duty) {
    _isLoading = duty;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
  }
}