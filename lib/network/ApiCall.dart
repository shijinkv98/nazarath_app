import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:nazarath_app/model/user.dart';
import 'package:nazarath_app/network/response/AddressResponse.dart';
import 'package:nazarath_app/network/response/CartResponse.dart';
import 'package:nazarath_app/network/response/CategoryResponse.dart';
import 'package:nazarath_app/network/response/ChangePasswordResponse.dart';
import 'package:nazarath_app/network/response/CheckoutResponse.dart';
import 'package:nazarath_app/network/response/CountryResponse.dart';
import 'package:nazarath_app/network/response/CouponResponse.dart';
import 'package:nazarath_app/network/response/EyePowerResponse.dart';
import 'package:nazarath_app/network/response/FilterResponse.dart';
import 'package:nazarath_app/network/response/HomeResponse.dart';
import 'package:nazarath_app/network/response/LoginResponse.dart';
import 'package:nazarath_app/network/response/NewsResponse.dart';
import 'package:nazarath_app/network/response/NotificationResponse.dart';
import 'package:nazarath_app/network/response/OrderCancelesponse.dart';
import 'package:nazarath_app/network/response/OrderResponse.dart';
import 'package:nazarath_app/network/response/ProductDetailsResponse.dart';
import 'package:nazarath_app/network/response/ProductListResponse.dart';
import 'package:nazarath_app/network/response/ProfileResponse.dart';
import 'package:nazarath_app/network/response/RefferalResponse.dart';
import 'package:nazarath_app/network/response/ReviewResponse.dart';
import 'package:nazarath_app/network/response/SearchResponse.dart';
import 'package:nazarath_app/network/response/SignupResponse.dart';
import 'package:nazarath_app/network/response/StoreResponse.dart';
import 'package:nazarath_app/network/response/TrackOrderResponse.dart';
import 'package:nazarath_app/network/response/WalletResponse.dart';
import 'package:nazarath_app/network/response/WishListResponse.dart';
import 'package:nazarath_app/network/response/resetpasswordresponse.dart';
import 'package:nazarath_app/screens/DashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/constants.dart';
import 'LogoutResponse.dart';
import 'response/newsdetailsresponse.dart';

class ApiCall{
  static const API_URL = "${BASE_URL}api/";
  ApiCall._privateConstructor();
  static final ApiCall _instance = ApiCall._privateConstructor();
  factory ApiCall() {
    return _instance;
  }

  BuildContext context;

  http.MultipartRequest getMultipartRequest(String url) {
    if (!url.startsWith("http")) {
      url = "$API_URL$url";
    }
    return http.MultipartRequest('POST', Uri.parse(url));
  }
  Future<T> execute<T, K>(String url, Map params,
      {
        bool isGet = false, http.MultipartRequest multipartRequest}) async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        isConnected = true;
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
      isConnected = false;
    }

    if (!isConnected) {
      return Future.error(Exception('No Connection'));
    }

    if (!url.startsWith("http")) {
      url = "$API_URL$url";
    }
    debugPrint("URL: " + url);
    if (params == null) {
      params = Map();
    }

    var user = await ApiCall().getUser();
    if (user != null) {
      if (user.token != null && user.token.trim().isNotEmpty) {
        params.addAll({'token': user.token.trim()});
        if (multipartRequest != null)
          multipartRequest?.fields['token'] = user.token.trim();
      }
      if (user.id != null && user.id.trim().isNotEmpty) {
        params.addAll({'id': user.id.toString()});
        if (multipartRequest != null)
          multipartRequest?.fields['id'] = user.id.toString();
      }
    }

    http.Response response;
    if (multipartRequest != null) {
      debugPrint("params mulipart: " + multipartRequest.fields.toString());
      if (multipartRequest.files != null && multipartRequest.files.isNotEmpty) {
        multipartRequest.files.forEach((element) {
          debugPrint(
              "params mulipart file: ${element.field} : ${element?.filename} contentType: ${element.contentType}");
        });
      }

      var streamedResponse = await multipartRequest.send();
      response = await http.Response.fromStream(streamedResponse);
      if (T == Null) {
        return null;
      }
    } else {
      debugPrint("params: " + params.toString());
      response =
      isGet ? await http.get(url) : await http.post(url, body: params);
    }

    String responsStr = response.body != null && response.body.trim().isNotEmpty
        ? response.body
        : '{}';
    debugPrint("response: " + response.body);

    var jsonResponse = json.decode(responsStr);

    // int success = jsonResponse.containsKey('succes') ? jsonResponse['success'] : 1;
    String success = jsonResponse['success']?.toString() ?? '1';

    showAlert(jsonResponse['alert_message']);

    if (success == '1') {
      showToast(jsonResponse['message']);

      print(jsonResponse.toString());
      return fromJson<T, K>(jsonResponse);
    } else {
     // showToast(jsonResponse['message'] ?? "Something went wrong!");
      if (success == '2' && context != null) {
        showToast(jsonResponse['message'] ?? "Something went wrong!");
        //await saveUser("");

        gotoLogout(context);
        //Navigator.of(context).pushReplacementNamed('/login');
      }

      else if (success == '3') {
        showToast(jsonResponse['message'] ?? "Something went wrong!");
       // await saveUser("");
        gotoLogin(context);
        // Provider.of<DutyChangeNotifier>(context, listen: false).isDutyOn =
        //     false;
        return fromJson<T, K>(jsonResponse);
      }
      else if (success == '0') {
        showToast(jsonResponse['message'] ?? "Something went wrong!");
        // await saveUser("");

        // Provider.of<DutyChangeNotifier>(context, listen: false).isDutyOn =
        //     false;

      }
      return Future.error(Exception('Failed to load post'));
    }
  }

  Future saveUser(String userResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('save user resp: $userResponse');
    bool success = await prefs.setString('user', userResponse);
    return success;
  }
  Future saveLoginResponse(String userResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('save user resp: $userResponse');
    bool success = await prefs.setString('login_response', userResponse);
    return success;
  }
  Future saveHome(String userResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('save user resp: $userResponse');
    bool success = await prefs.setString('user', userResponse);
    return success;
  }

  Future saveAdminPhone(String adminNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint('save admin phone NO: $adminNo');
    bool success = await prefs.setString('admin_phone_no', adminNo);
    return success;
  }

  Future<String> getAdminPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('admin_phone_no');
  }
  Future<LoginResponse> getLoginResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user =
    prefs.getString('login_response') == null ? "" : prefs.getString('login_response');
    if (user == null || user.trim().isEmpty) {
      return null;
    }
    return LoginResponse.fromJson(json.decode(user == null ? "" : user));
  }
  Future<UserData> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user =
    prefs.getString('user') == null ? "" : prefs.getString('user');
    if (user == null || user.trim().isEmpty) {
      return null;
    }
    return UserData.fromJson(json.decode(user == null ? "" : user));
  }

  Future<String> getUserToken() async {
    String token;
    var user = await ApiCall().getUser();
    if (user != null && user.token != null && user.token.trim().isNotEmpty) {
      token = user.token;
    }
    return token;
  }

  /// If T is a List, K is the subtype of the list.
  T fromJson<T, K>(dynamic json) {
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    } else if (T == SignupResponse) {
      return SignupResponse.fromJson(json) as T;
    } else if (T == LoginResponse) {
      return LoginResponse.fromJson(json) as T;
    } else if (T == CategoryResponse) {
      return CategoryResponse.fromJson(json) as T;
      } else if (T == ProductListResponse) {
        return ProductListResponse.fromJson(json) as T;
    } else if (T == ProductDetailsResponse) {
      return ProductDetailsResponse.fromJson(json) as T;
    } else if (T == CartResponse) {
        return CartResponse.fromJson(json) as T;
    } else if (T == WishListResponse) {
      return WishListResponse.fromJson(json) as T;
    } else if (T == HomeResponse) {
      return HomeResponse.fromJson(json) as T;
    } else if (T == FilterResponse) {
      return FilterResponse.fromJson(json) as T;
    } else if (T == ProfileResponse) {
      return ProfileResponse.fromJson(json) as T;
    } else if (T == SearchResponse) {
      return SearchResponse.fromJson(json) as T;
    } else if (T == TrackOrderResponse) {
      return TrackOrderResponse.fromJson(json) as T;
    } else if (T == WalletResponse) {
      return WalletResponse.fromJson(json) as T;
    } else if (T == ReferalResponse) {
      return ReferalResponse.fromJson(json) as T;
    } else if (T == OrderResponse) {
      return OrderResponse.fromJson(json) as T;
    } else if (T == OrderCancelResponse) {
      return OrderCancelResponse.fromJson(json) as T;
    } else if (T == NotificationResponse) {
      return NotificationResponse.fromJson(json) as T;
    } else if (T == CouponResponse) {
      return CouponResponse.fromJson(json) as T;
    } else if (T == AddressResponse) {
      return AddressResponse.fromJson(json) as T;
    } else if (T == ReviewResponse) {
      return ReviewResponse.fromJson(json) as T;
    } else if (T == LogoutResponse) {
      return LogoutResponse.fromJson(json) as T;
    } else if (T == NewsResponse) {
      return NewsResponse.fromJson(json) as T;
    } else if (T == StoreResponse) {
      return StoreResponse.fromJson(json) as T;
    } else if (T == EyePowerResponse) {
      return EyePowerResponse.fromJson(json) as T;
    } else if (T == ChangePasswordResponse) {
      return ChangePasswordResponse.fromJson(json) as T;
    } else if (T == NewsDetailsResponse) {
      return NewsDetailsResponse.fromJson(json) as T;
    } else if (T == CheckoutResponse) {
      return CheckoutResponse.fromJson(json) as T;
    } else if (T == CountryResponse) {
      return CountryResponse.fromJson(json) as T;
    } else if (T == ResetPasswordResponse) {
      return ResetPasswordResponse.fromJson(json) as T;
    } else if (T == String) {
      return json.toString() as T;
    }

    else {
      showToast("Something went wrong!");
      throw Exception("Unknown class");
      // Future.error(Exception('Unknown class'));
    }
  }

  void showToast(String message) {
    if (message == null ||
        message.trim().isEmpty ||
        message.trim().toLowerCase() == "success") {
      return;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showAlert(String message) {
    if (message == null ||
        message.trim().isEmpty ||
        message.trim().toLowerCase() == "success") {
      return;
    }
    try {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (e) {}
  }

  List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<K> output = List();

    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }

    return output;
  }
  }