class ReferalResponse {
  int success;
  String message;
  Currency currency;
  Data data;

  ReferalResponse({this.success, this.message, this.currency, this.data});

  ReferalResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Currency {
  String name;
  String code;
  String symbolLeft;
  String symbolRight;
  String value;
  int status;

  Currency(
      {this.name,
        this.code,
        this.symbolLeft,
        this.symbolRight,
        this.value,
        this.status});

  Currency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['value'] = this.value;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int balance;
  List<ReferralHistory> referralHistory;
  List<UsageHistory> usageHistory;
  Content content;
  String bank;

  Data(
      {this.balance,
        this.referralHistory,
        this.usageHistory,
        this.content,
        this.bank});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    if (json['referral_history'] != null) {
      referralHistory = new List<ReferralHistory>();
      json['referral_history'].forEach((v) {
        referralHistory.add(new ReferralHistory.fromJson(v));
      });
    }
    if (json['usage_history'] != null) {
      usageHistory = new List<UsageHistory>();
      json['usage_history'].forEach((v) {
        usageHistory.add(new UsageHistory.fromJson(v));
      });
    }
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    if (this.referralHistory != null) {
      data['referral_history'] =
          this.referralHistory.map((v) => v.toJson()).toList();
    }
    if (this.usageHistory != null) {
      data['usage_history'] = this.usageHistory.map((v) => v.toJson()).toList();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['bank'] = this.bank;
    return data;
  }
}

class ReferralHistory {
  String referralCode;
  String email;
  String date;
  String amount;
  String mobile;

  ReferralHistory(
      {this.referralCode, this.email, this.date, this.amount, this.mobile});

  ReferralHistory.fromJson(Map<String, dynamic> json) {
    referralCode = json['referral_code'];
    email = json['email'];
    date = json['date'];
    amount = json['amount'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referral_code'] = this.referralCode;
    data['email'] = this.email;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['mobile'] = this.mobile;
    return data;
  }
}

class UsageHistory {
  String type;
  String date;
  String amount;

  UsageHistory({this.type, this.date, this.amount});

  UsageHistory.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['date'] = this.date;
    data['amount'] = this.amount;
    return data;
  }
}

class Content {
  int id;
  int minAmount;
  String title;
  String description;
  int status;
  String createdAt;
  String updatedAt;

  Content(
      {this.id,
        this.minAmount,
        this.title,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  Content.fromJson(Map<String, dynamic> json) {
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
