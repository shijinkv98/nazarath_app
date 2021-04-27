import 'HomeResponse.dart';

class AddAddressResponse {
  int success;
  String message;
  Address address;

  AddAddressResponse({this.success, this.message, this.address});

  AddAddressResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

