class StoreResponse {
  int success;
  String message;
  List<Stores> stores;

  StoreResponse({this.success, this.message, this.stores});

  StoreResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['stores'] != null) {
      stores = new List<Stores>();
      json['stores'].forEach((v) {
        stores.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.stores != null) {
      data['stores'] = this.stores.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  int id;
  String name;
  String address;
  String slug;
  String latitude;
  String longtitude;
  String image;
  String phoneNumber;

  Stores(
      {this.id,
        this.name,
        this.address,
        this.slug,
        this.latitude,
        this.longtitude,
        this.image,
        this.phoneNumber});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    slug = json['slug'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    image = json['image'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['slug'] = this.slug;
    data['latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    data['image'] = this.image;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
