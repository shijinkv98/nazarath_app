class ProductListResponse {
  int success;
  String message;
  Products products;

  ProductListResponse({this.success, this.message, this.products});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products.toJson();
    }
    return data;
  }
}

class Products {
  int currentPage;
  List<Data> data;
  int from;
  int lastPage;
  String nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  Products(
      {this.currentPage,
        this.data,
        this.from,
        this.lastPage,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Products.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    from = json['from'];
    lastPage = json['last_page'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  String slug;
  int status;
  String storeslug;
  String purchaseReward;
  String rewardPoint;
  String code;
  String name;
  String appDescription;
  String symbolLeft;
  String symbolRight;
  String oldprice;
  String price;
  String discount;
  String rating;
  String image;
  int wishlist;
  int cart;
  String store;
  String manufacturer;

  Data(
      {this.slug,
        this.status,
        this.storeslug,
        this.purchaseReward,
        this.rewardPoint,
        this.code,
        this.name,
        this.appDescription,
        this.symbolLeft,
        this.symbolRight,
        this.oldprice,
        this.price,
        this.discount,
        this.rating,
        this.image,
        this.wishlist,
        this.cart,
        this.store,
        this.manufacturer});

  Data.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    status = json['status'];
    storeslug = json['storeslug'];
    purchaseReward = json['purchase_reward'];
    rewardPoint = json['reward_point'];
    code = json['code'];
    name = json['name'];
    appDescription = json['app_description'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    oldprice = json['oldprice'];
    price = json['price'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['image'];
    wishlist = json['wishlist'];
    cart = json['cart'];
    store = json['store'];
    manufacturer = json['manufacturer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['storeslug'] = this.storeslug;
    data['purchase_reward'] = this.purchaseReward;
    data['reward_point'] = this.rewardPoint;
    data['code'] = this.code;
    data['name'] = this.name;
    data['app_description'] = this.appDescription;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['wishlist'] = this.wishlist;
    data['cart'] = this.cart;
    data['store'] = this.store;
    data['manufacturer'] = this.manufacturer;
    return data;
  }
}
