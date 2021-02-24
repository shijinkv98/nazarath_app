class ReferalResponse {
  int success;
  String message;
  Details details;
  String referralCode;
  String referralUrl;

  ReferalResponse(
      {this.success,
        this.message,
        this.details,
        this.referralCode,
        this.referralUrl});

  ReferalResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    referralCode = json['referral_code'];
    referralUrl = json['referral_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['referral_code'] = this.referralCode;
    data['referral_url'] = this.referralUrl;
    return data;
  }
}

class Details {
  int id;
  int minAmount;
  String title;
  String description;
  int status;
  String createdAt;
  String updatedAt;

  Details(
      {this.id,
        this.minAmount,
        this.title,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minAmount = json['min_amount'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['min_amount'] = this.minAmount;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
