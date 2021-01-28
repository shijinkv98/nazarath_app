import 'dart:convert';
import 'dart:ui';

import 'constants.dart';

class ApiCall{
  static const API_URL = "${BASE_URL}api/";
  ApiCall._privateConstructor();
  static final ApiCall _instance = ApiCall._privateConstructor();
  factory ApiCall() {
    return _instance;
  }
  }