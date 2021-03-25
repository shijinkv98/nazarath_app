class ProductDetailsResponse {
  int success;
  String message;
  ProductDetail product;
  bool enableGuestReview;

  ProductDetailsResponse(
      {this.success, this.message, this.product, this.enableGuestReview});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    product =
    json['product'] != null ? new   ProductDetail.fromJson(json['product']) : null;
    enableGuestReview = json['enable_guest_review'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['enable_guest_review'] = this.enableGuestReview;
    return data;
  }

}

class ProductDetail {
  String slug;
  String code;
  String sizeChart;
  String metaTitle;
  String metaDescription;
  String metaKeywords;
  int parentId;
  String name;
  String description;
  String appDescription;
  String storeslug;
  String store;
  String manufacturer;
  String symbolLeft;
  String symbolRight;
  String purchaseReward;
  String rewardPoint;
  String oldprice;
  String price;
  String discount;
  String rating;
  String image;
  int wishlist;
  int cart;
  int reviewscount;
  int ratingcount;
  String sellerrating;
  List<Options> options;
  List<Images> images;
  List<Stores> stores;
  List<Reviews> reviews;
  List<Specifications> specifications;
  List<POptions> pOptions;
  List<RelatedOptions> relatedOptions;
  List<RelatedProducts> relatedProducts;

  ProductDetail(
      {this.slug,
        this.code,
        this.sizeChart,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.parentId,
        this.name,
        this.description,
        this.appDescription,
        this.storeslug,
        this.store,
        this.manufacturer,
        this.symbolLeft,
        this.symbolRight,
        this.purchaseReward,
        this.rewardPoint,
        this.oldprice,
        this.price,
        this.discount,
        this.rating,
        this.image,
        this.wishlist,
        this.cart,
        this.reviewscount,
        this.ratingcount,
        this.sellerrating,
        this.options,
        this.images,
        this.stores,
        this.reviews,
        this.specifications,
        this.pOptions,
        this.relatedOptions,
        this.relatedProducts});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    code = json['code'];
    sizeChart = json['size_chart'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    parentId = json['parent_id'];
    name = json['name'];
    description = json['description'];
    appDescription = json['app_description'];
    storeslug = json['storeslug'];
    store = json['store'];
    manufacturer = json['manufacturer'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    purchaseReward = json['purchase_reward'];
    rewardPoint = json['reward_point'];
    oldprice = json['oldprice'];
    price = json['price'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['image'];
    wishlist = json['wishlist'];
    cart = json['cart'];
    reviewscount = json['reviewscount'];
    ratingcount = json['ratingcount'];
    sellerrating = json['sellerrating'];
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = new List<Stores>();
      json['stores'].forEach((v) {
        stores.add(new Stores.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    if (json['specifications'] != null) {
      specifications = new List<Specifications>();
      json['specifications'].forEach((v) {
        specifications.add(new Specifications.fromJson(v));
      });
    }
    if (json['p_options'] != null) {
      pOptions = new List<POptions>();
      json['p_options'].forEach((v) {
        pOptions.add(new POptions.fromJson(v));
      });
    }
    if (json['related_options'] != null) {
      relatedOptions = new List<RelatedOptions>();
      json['related_options'].forEach((v) {
        relatedOptions.add(new RelatedOptions.fromJson(v));
      });
    }
    if (json['related_products'] != null) {
      relatedProducts = new List<RelatedProducts>();
      json['related_products'].forEach((v) {
        relatedProducts.add(new RelatedProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['size_chart'] = this.sizeChart;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['app_description'] = this.appDescription;
    data['storeslug'] = this.storeslug;
    data['store'] = this.store;
    data['manufacturer'] = this.manufacturer;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['purchase_reward'] = this.purchaseReward;
    data['reward_point'] = this.rewardPoint;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['wishlist'] = this.wishlist;
    data['cart'] = this.cart;
    data['reviewscount'] = this.reviewscount;
    data['ratingcount'] = this.ratingcount;
    data['sellerrating'] = this.sellerrating;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.specifications != null) {
      data['specifications'] =
          this.specifications.map((v) => v.toJson()).toList();
    }
    if (this.pOptions != null) {
      data['p_options'] = this.pOptions.map((v) => v.toJson()).toList();
    }
    if (this.relatedOptions != null) {
      data['related_options'] =
          this.relatedOptions.map((v) => v.toJson()).toList();
    }
    if (this.relatedProducts != null) {
      data['related_products'] =
          this.relatedProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Options {
  int optionId;
  String name;
  int productId;
  int id;
  String type;
  List<ValuesOption> values;

  Options(
      {this.optionId,
        this.name,
        this.productId,
        this.id,
        this.type,
        this.values});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    name = json['name'];
    productId = json['product_id'];
    id = json['id'];
    type = json['type'];
    if (json['values'] != null) {
      values = new List<ValuesOption>();
      json['values'].forEach((v) {
        values.add(new ValuesOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ValuesOption {
  int optionValueId;
  String value;
  String text;
  String image;
  String slug;
  int productOptionId;

  ValuesOption(
      {this.optionValueId,
        this.value,
        this.text,
        this.image,
        this.slug,
        this.productOptionId});

  ValuesOption.fromJson(Map<String, dynamic> json) {
    optionValueId = json['option_value_id'];
    value = json['value'];
    text = json['text'];
    image = json['image'];
    slug = json['slug'];
    productOptionId = json['product_option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_value_id'] = this.optionValueId;
    data['value'] = this.value;
    data['text'] = this.text;
    data['image'] = this.image;
    data['slug'] = this.slug;
    data['product_option_id'] = this.productOptionId;
    return data;
  }
}

class Images {
  int id;
  String image;
  int isDefault;

  Images({this.id, this.image, this.isDefault});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['is_default'] = this.isDefault;
    return data;
  }
}

class Stores {
  int id;
  int productId;
  int storeId;
  String defaultPrice;
  String stock;
  String minQuantity;
  String maxQuantity;
  String currentPrice;
  String cost;
  int returnPeriod;
  int status;
  String commission;
  int stockAlertQuantity;
  String createdAt;
  String updatedAt;
  String price;
  String rating;
  Store store;

  Stores(
      {this.id,
        this.productId,
        this.storeId,
        this.defaultPrice,
        this.stock,
        this.minQuantity,
        this.maxQuantity,
        this.currentPrice,
        this.cost,
        this.returnPeriod,
        this.status,
        this.commission,
        this.stockAlertQuantity,
        this.createdAt,
        this.updatedAt,
        this.price,
        this.rating,
        this.store});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    storeId = json['store_id'];
    defaultPrice = json['default_price'];
    stock = json['stock'];
    minQuantity = json['min_quantity'];
    maxQuantity = json['max_quantity'];
    currentPrice = json['current_price'];
    cost = json['cost'];
    returnPeriod = json['return_period'];
    status = json['status'];
    commission = json['commission'];
    stockAlertQuantity = json['stock_alert_quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    rating = json['rating'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['store_id'] = this.storeId;
    data['default_price'] = this.defaultPrice;
    data['stock'] = this.stock;
    data['min_quantity'] = this.minQuantity;
    data['max_quantity'] = this.maxQuantity;
    data['current_price'] = this.currentPrice;
    data['cost'] = this.cost;
    data['return_period'] = this.returnPeriod;
    data['status'] = this.status;
    data['commission'] = this.commission;
    data['stock_alert_quantity'] = this.stockAlertQuantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price'] = this.price;
    data['rating'] = this.rating;
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    return data;
  }
}

class Store {
  int id;
  String name;
  String address;
  String slug;
  String latitude;
  String longtitude;
  String image;
  String phoneNumber;

  Store(
      {this.id,
        this.name,
        this.address,
        this.slug,
        this.latitude,
        this.longtitude,
        this.image,
        this.phoneNumber});

  Store.fromJson(Map<String, dynamic> json) {
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
class Reviews {
  String name;
  String title;
  String comment;
  String reviewDate;

  Reviews({this.name, this.title, this.comment, this.reviewDate});

  Reviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    comment = json['comment'];
    reviewDate = json['review_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['comment'] = this.comment;
    data['review_date'] = this.reviewDate;
    return data;
  }
}
class Specifications {
  int specificationId;
  String name;
  int productId;
  int id;
  List<ValuesSpecification> values;

  Specifications(
      {this.specificationId, this.name, this.productId, this.id, this.values});

  Specifications.fromJson(Map<String, dynamic> json) {
    specificationId = json['specification_id'];
    name = json['name'];
    productId = json['product_id'];
    id = json['id'];
    if (json['values'] != null) {
      values = new List<ValuesSpecification>();
      json['values'].forEach((v) {
        values.add(new ValuesSpecification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specification_id'] = this.specificationId;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['id'] = this.id;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ValuesSpecification {
  int specificationValueId;
  String value;
  int productSpecificationId;

  ValuesSpecification({this.specificationValueId, this.value, this.productSpecificationId});

  ValuesSpecification.fromJson(Map<String, dynamic> json) {
    specificationValueId = json['specification_value_id'];
    value = json['value'];
    productSpecificationId = json['product_specification_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specification_value_id'] = this.specificationValueId;
    data['value'] = this.value;
    data['product_specification_id'] = this.productSpecificationId;
    return data;
  }
}
class RelatedProducts {
  int id;
  String slug;
  String code;
  String sizeChart;
  Null metaTitle;
  Null metaDescription;
  Null metaKeywords;
  int parentId;
  String name;
  String description;
  String appDescription;
  String storeslug;
  String store;
  String manufacturer;
  String value;
  String symbolLeft;
  String symbolRight;
  String purchaseReward;
  String rewardPoint;
  String oldprice;
  String price;
  String discount;
  String rating;
  String image;
  int wishlist;
  int cart;
  int reviewscount;
  int ratingcount;
  String sellerrating;
  int productId;

  RelatedProducts(
      {this.id,
        this.slug,
        this.code,
        this.sizeChart,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.parentId,
        this.name,
        this.description,
        this.appDescription,
        this.storeslug,
        this.store,
        this.manufacturer,
        this.value,
        this.symbolLeft,
        this.symbolRight,
        this.purchaseReward,
        this.rewardPoint,
        this.oldprice,
        this.price,
        this.discount,
        this.rating,
        this.image,
        this.wishlist,
        this.cart,
        this.reviewscount,
        this.ratingcount,
        this.sellerrating,
        this.productId});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    code = json['code'];
    sizeChart = json['size_chart'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    parentId = json['parent_id'];
    name = json['name'];
    description = json['description'];
    appDescription = json['app_description'];
    storeslug = json['storeslug'];
    store = json['store'];
    manufacturer = json['manufacturer'];
    value = json['value'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    purchaseReward = json['purchase_reward'];
    rewardPoint = json['reward_point'];
    oldprice = json['oldprice'];
    price = json['price'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['image'];
    wishlist = json['wishlist'];
    cart = json['cart'];
    reviewscount = json['reviewscount'];
    ratingcount = json['ratingcount'];
    sellerrating = json['sellerrating'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['size_chart'] = this.sizeChart;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['app_description'] = this.appDescription;
    data['storeslug'] = this.storeslug;
    data['store'] = this.store;
    data['manufacturer'] = this.manufacturer;
    data['value'] = this.value;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['purchase_reward'] = this.purchaseReward;
    data['reward_point'] = this.rewardPoint;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['wishlist'] = this.wishlist;
    data['cart'] = this.cart;
    data['reviewscount'] = this.reviewscount;
    data['ratingcount'] = this.ratingcount;
    data['sellerrating'] = this.sellerrating;
    data['product_id'] = this.productId;
    return data;
  }
}
class POptions {
  int optionId;
  String name;
  int productId;
  int id;
  String type;
  List<Values> values;

  POptions(
      {this.optionId,
        this.name,
        this.productId,
        this.id,
        this.type,
        this.values});

  POptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    name = json['name'];
    productId = json['product_id'];
    id = json['id'];
    type = json['type'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int optionValueId;
  String value;
  String text;
  String image;
  String slug;
  int productOptionId;

  Values(
      {this.optionValueId,
        this.value,
        this.text,
        this.image,
        this.slug,
        this.productOptionId});

  Values.fromJson(Map<String, dynamic> json) {
    optionValueId = json['option_value_id'];
    value = json['value'];
    text = json['text'];
    image = json['image'];
    slug = json['slug'];
    productOptionId = json['product_option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_value_id'] = this.optionValueId;
    data['value'] = this.value;
    data['text'] = this.text;
    data['image'] = this.image;
    data['slug'] = this.slug;
    data['product_option_id'] = this.productOptionId;
    return data;
  }
}
class RelatedOptions {
  int optionId;
  String name;
  int productId;
  int id;
  String type;
  List<Values> values;

  RelatedOptions(
      {this.optionId,
        this.name,
        this.productId,
        this.id,
        this.type,
        this.values});

  RelatedOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    name = json['name'];
    productId = json['product_id'];
    id = json['id'];
    type = json['type'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
