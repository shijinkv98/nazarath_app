import 'package:nazarath_app/model/user.dart';

class LoginResponse {
  UserData customerData;
  int success;
  String message,guest_id;
  LoginResponse()
  {
    message = "";
    guest_id="";
    customerData= new UserData();
  }
  LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['customerdata'] != null) {
      customerData = UserData.fromJson(json['customerdata']);
    }
    guest_id= json['guest_id'];
   // customerData.guest_id=guest_id;
    message = json['message'];
    success = json['success'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['guest_id'] = this.guest_id;

    return data;
  }
}
