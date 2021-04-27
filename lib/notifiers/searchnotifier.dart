import 'package:flutter/material.dart';
import 'package:nazarath_app/network/response/SearchResponse.dart';


class SearchUpdateNotifier extends ChangeNotifier {

  SearchResponse _searchResponse=null;
  SearchResponse get searchResponse => _searchResponse;
  set searchResponse(SearchResponse response) {
    _searchResponse=response;

    notifyListeners();
  }

  void reset() {
    _searchResponse=null;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
