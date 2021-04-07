import 'package:flutter/material.dart';
import 'package:nazarath_app/network/response/EyePowerResponse.dart';
class RegisterLoadingNotifier extends ChangeNotifier {
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
class CheckBoxNotifier extends ChangeNotifier {
  bool _isChecked = false;
  bool get isChecked => _isChecked;
  set isChecked(bool isChecked) {
    _isChecked = isChecked;
    notifyListeners();
  }
}

class DocsAddedNotifier extends ChangeNotifier {
  bool _isAdded = false;
  bool get isAdded => _isAdded;
  EyePowerResponse _eyePowerResponse;
  EyePowerResponse get eyePowerResponse=>_eyePowerResponse;
  set eyePowerResponse(EyePowerResponse response)
  {
    _eyePowerResponse=response;
        _isAdded = false;
        notifyListeners();
  }
  set isLoading(bool duty) {
    _isAdded = duty;
    notifyListeners();
  }

  void reset() {
    _isAdded = false;
  }
  void docAdded() {
    _isAdded=true;
    notifyListeners();
  }
}

class PhysicalStoreClickNotifier extends ChangeNotifier {
  void radioButtonSelected() {
    notifyListeners();
  }
}