import 'package:nazarath_app/model/user.dart';

class SignupResponse {
  UserData customerData;
  int success;
  String message,guest_id;
  SignupResponse.fromJson(Map<String, dynamic> json) {
    if (json['customerdata'] != null) {
      customerData = UserData.fromJson(json['customerdata']);
    }
    message = json['message'];
    guest_id = json['guest_id'];
    success = json['success'];
  }
}
