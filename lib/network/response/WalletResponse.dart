class WalletResponse {
  int success;
  String message;
  Currency currency;
  Data data;

  WalletResponse({this.success, this.message, this.currency, this.data});

  WalletResponse.fromJson(Map<String, dynamic> json) {
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
  String balance;
  int pending;
  List<Wallet> history;
  List<Wallet> pendingHistory;

  Data({this.balance, this.pending, this.history, this.pendingHistory});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    pending = json['pending'];
    if (json['history'] != null) {
      history = new List<Wallet>();
      json['history'].forEach((v) {
        history.add(new Wallet.fromJson(v));
      });
    }
    if (json['pending_history'] != null) {
      pendingHistory = new List<Wallet>();
      json['pending_history'].forEach((v) {
        pendingHistory.add(new Wallet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['pending'] = this.pending;
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    if (this.pendingHistory != null) {
      data['pending_history'] =
          this.pendingHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallet {
  String type;
  String invNumber;
  String date;
  String amount;
  int status;

  Wallet({this.type, this.invNumber, this.date, this.amount, this.status});

  Wallet.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    invNumber = json['inv_number'];
    date = json['date'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['inv_number'] = this.invNumber;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}
