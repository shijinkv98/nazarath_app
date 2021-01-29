class FilterResponse {
  int success;
  String message;
  List<Filters> filters;
  Currency currency;

  FilterResponse({this.success, this.message, this.filters, this.currency});

  FilterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['filters'] != null) {
      filters = new List<Filters>();
      json['filters'].forEach((v) {
        filters.add(new Filters.fromJson(v));
      });
    }
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    return data;
  }
}

class Filters {
  String type;
  String text;
  List<Values> values;

  Filters({this.type, this.text, this.values});

  Filters.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['text'] = this.text;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int filterValueId;
  String name;
  int parentId;

  Values({this.filterValueId, this.name, this.parentId});

  Values.fromJson(Map<String, dynamic> json) {
    filterValueId = json['filter_value_id'];
    name = json['name'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_value_id'] = this.filterValueId;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
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
