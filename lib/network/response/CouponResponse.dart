class CouponResponse {
  int success;
  String message;
  List<Coupons> coupons;

  CouponResponse({this.success, this.message, this.coupons});

  CouponResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['coupons'] != null) {
      coupons = new List<Coupons>();
      json['coupons'].forEach((v) {
        coupons.add(new Coupons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.coupons != null) {
      data['coupons'] = this.coupons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupons {
  String usageLimit;
  String minimumTransaction;
  String maximumAmount;
  String amount;
  String type;
  String code;
  String description;
  int id;

  Coupons(
      {this.usageLimit,
        this.minimumTransaction,
        this.maximumAmount,
        this.amount,
        this.type,
        this.code,
        this.description,
        this.id});

  Coupons.fromJson(Map<String, dynamic> json) {
    usageLimit = json['usage_limit'];
    minimumTransaction = json['minimum_transaction'];
    maximumAmount = json['maximum_amount'];
    amount = json['amount'];
    type = json['type'];
    code = json['code'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usage_limit'] = this.usageLimit;
    data['minimum_transaction'] = this.minimumTransaction;
    data['maximum_amount'] = this.maximumAmount;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['code'] = this.code;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}
