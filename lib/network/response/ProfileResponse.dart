class ProfileResponse {
  int success;
  String message;
  String phoneNumber;
  String gender;
  String name;
  String email;
  int referralHide;
  int ordersCount;
  int notificationCount;
  int wishlistCount;
  int addressCount;
  int mobileVerified;
  int emailVerified;

  ProfileResponse(
      {this.success,
        this.message,
        this.phoneNumber,
        this.gender,
        this.name,
        this.email,
        this.referralHide,
        this.ordersCount,
        this.notificationCount,
        this.wishlistCount,
        this.addressCount,
        this.mobileVerified,
        this.emailVerified});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    name = json['name'];
    email = json['email'];
    referralHide = json['referral_hide'];
    ordersCount = json['orders_count'];
    notificationCount = json['notification_count'];
    wishlistCount = json['wishlist_count'];
    addressCount = json['address_count'];
    mobileVerified = json['mobile_verified'];
    emailVerified = json['email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['name'] = this.name;
    data['email'] = this.email;
    data['referral_hide'] = this.referralHide;
    data['orders_count'] = this.ordersCount;
    data['notification_count'] = this.notificationCount;
    data['wishlist_count'] = this.wishlistCount;
    data['address_count'] = this.addressCount;
    data['mobile_verified'] = this.mobileVerified;
    data['email_verified'] = this.emailVerified;
    return data;
  }
}
