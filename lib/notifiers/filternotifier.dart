import 'package:flutter/material.dart';

import 'package:nazarath_app/network/response/FilterResponse.dart';
class FilterUpdatedNotifier extends ChangeNotifier {
  bool _isAdded = false;
  FilterResponse _filterResponse=null;
  bool get isAdded => _isAdded;
  FilterResponse get filterResponse => _filterResponse;

  set filterResponse(FilterResponse response) {
    _filterResponse=response;
    _isAdded = true;
    notifyListeners();
  }

  void reset() {
    _isAdded = false;
    _filterResponse=null;
  }
}
