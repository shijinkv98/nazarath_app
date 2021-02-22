class UserData {
  String id, mobile, name, email, locationDetails, token,guest_id="";
  int status,otpVerificationStatus,emailVerificationStatus;
  String otp,referral_code;
  UserData()
  {
    id = "";
    mobile ="";
    name = "";
    email ="";
    status =0;
    token = "";
    referral_code = "";
    guest_id="";
    otpVerificationStatus = 0;
    emailVerificationStatus = 0;
  }
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    token = json['token'];
    referral_code = json['token'];
    otpVerificationStatus=status;
    emailVerificationStatus=status;
    //guest_id= json['guest_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['status'] = this.status;
    data['token'] = this.token;
    data['email'] = this.email;

        return data;
  }
}
