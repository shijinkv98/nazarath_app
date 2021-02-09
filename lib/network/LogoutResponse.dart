import 'package:nazarath_app/model/user.dart';

class LogoutResponse {
  UserData customerData;
  int success;
  String message;
  LogoutResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
  }
}
