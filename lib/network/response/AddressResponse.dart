class AddressResponse {
  int success;
  String message;
  List<Addresses> addresses;
  //List<Zones> zones;

  AddressResponse({this.success, this.message, this.addresses
    // , this.zones
  });

  AddressResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    // if (json['zones'] != null) {
    //   zones = new List<Zones>();
    //   json['zones'].forEach((v) {
    //     zones.add(new Zones.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    // if (this.zones != null) {
    //   data['zones'] = this.zones.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Addresses {
  int id;
  int customerId;
  String name;
  String address;
  String city;
  String state;
  int countryId;
  String zipcode;
  String mobile;
  String addressType;
  String latitude;
  String longtitude;
  String createdAt;
  String updatedAt;
  Null buildingNumber;
  int areaNumber;
  Null streetNumber;
  Null location;
  Country country;

  Addresses(
      {this.id,
        this.customerId,
        this.name,
        this.address,
        this.city,
        this.state,
        this.countryId,
        this.zipcode,
        this.mobile,
        this.addressType,
        this.latitude,
        this.longtitude,
        this.createdAt,
        this.updatedAt,
        this.buildingNumber,
        this.areaNumber,
        this.streetNumber,
        this.location,
        this.country});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    countryId = json['country_id'];
    zipcode = json['zipcode'];
    mobile = json['mobile'];
    addressType = json['address_type'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    buildingNumber = json['building_number'];
    areaNumber = json['area_number'];
    streetNumber = json['street_number'];
    location = json['location'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country_id'] = this.countryId;
    data['zipcode'] = this.zipcode;
    data['mobile'] = this.mobile;
    data['address_type'] = this.addressType;
    data['latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['building_number'] = this.buildingNumber;
    data['area_number'] = this.areaNumber;
    data['street_number'] = this.streetNumber;
    data['location'] = this.location;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class Country {
  int id;
  String name;
  String shortcode;
  int dialCode;
  int deliveryAvailable;
  Null createdAt;
  String updatedAt;

  Country(
      {this.id,
        this.name,
        this.shortcode,
        this.dialCode,
        this.deliveryAvailable,
        this.createdAt,
        this.updatedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortcode = json['shortcode'];
    dialCode = json['dial_code'];
    deliveryAvailable = json['delivery_available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortcode'] = this.shortcode;
    data['dial_code'] = this.dialCode;
    data['delivery_available'] = this.deliveryAvailable;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

// class Zones {
//   int id;
//   String name;
//   String createdAt;
//   String updatedAt;
//   // int isTimeslotAvailable;
//
//   Zones(
//       {this.id,
//         this.name,
//         this.createdAt,
//         this.updatedAt
//         // ,this.isTimeslotAvailable
//       });
//
//   Zones.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     // isTimeslotAvailable = json['is_timeslot_available'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     // data['is_timeslot_available'] = this.isTimeslotAvailable;
//     return data;
//   }
// }
