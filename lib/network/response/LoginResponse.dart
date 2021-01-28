import 'package:nazarath_app/model/user.dart';

class LoginResponse {
  UserData customerData;
  int success;
  String message,guest_id;
  LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['customerdata'] != null) {
      customerData = UserData.fromJson(json['customerdata']);
    }
    message = json['message'];
    success = json['success'];
  }
}
