class WishListResponse {
  int success;
  String message;
  List<Products> products;

  WishListResponse({this.success, this.message, this.products});

  WishListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String slug;
  String code;
  String name;
  String description;
  String appDescription;
  String date;
  int storeId;
  String storeslug;
  String store;
  String manufacturer;
  String value;
  String symbolLeft;
  String symbolRight;
  int quantity;
  String oldprice;
  String price;
  String discount;
  String rating;
  String image;
  int wishlist;
  int cart;

  Products(
      {this.id,
        this.slug,
        this.code,
        this.name,
        this.description,
        this.appDescription,
        this.date,
        this.storeId,
        this.storeslug,
        this.store,
        this.manufacturer,
        this.value,
        this.symbolLeft,
        this.symbolRight,
        this.quantity,
        this.oldprice,
        this.price,
        this.discount,
        this.rating,
        this.image,
        this.wishlist,
        this.cart});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    appDescription = json['app_description'];
    date = json['date'];
    storeId = json['store_id'];
    storeslug = json['storeslug'];
    store = json['store'];
    manufacturer = json['manufacturer'];
    value = json['value'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    quantity = json['quantity'];
    oldprice = json['oldprice'];
    price = json['price'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['image'];
    wishlist = json['wishlist'];
    cart = json['cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['app_description'] = this.appDescription;
    data['date'] = this.date;
    data['store_id'] = this.storeId;
    data['storeslug'] = this.storeslug;
    data['store'] = this.store;
    data['manufacturer'] = this.manufacturer;
    data['value'] = this.value;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['quantity'] = this.quantity;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['wishlist'] = this.wishlist;
    data['cart'] = this.cart;
    return data;
  }
}
