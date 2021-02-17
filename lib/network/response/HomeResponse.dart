class HomeResponse {
  int success;
  String message;
  List<HomeSlider> slider;
  List<Categories> categories;
  List<Sellers> sellers;
  List<Offers> offers;
  List<Banners> banners;
  List<Recentviews> recentviews;
  List<Newarrivals> newarrivals;
  List<Featuredbrands> featuredbrands;
  List<RecommendedProducts> recommendedProducts;
  List<FeaturedProducts> featuredProducts;
  int cartcount;
  int wishlistcount;
  Currency currency;
  Address address;
  int notificationCount;

  HomeResponse(
      {this.success,
        this.message,
        this.slider,
        this.categories,
        this.sellers,
        this.offers,
        this.banners,
        this.recentviews,
        this.newarrivals,
        this.featuredbrands,
        this.recommendedProducts,
        this.featuredProducts,
        this.cartcount,
        this.wishlistcount,
        this.currency,
        this.address,
        this.notificationCount});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['slider'] != null) {
      slider = new List<HomeSlider>();
      json['slider'].forEach((v) {
        slider.add(new HomeSlider.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['sellers'] != null) {
      sellers = new List<Sellers>();
      json['sellers'].forEach((v) {
        sellers.add(new Sellers.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = new List<Offers>();
      json['offers'].forEach((v) {
        offers.add(new Offers.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = new List<Banners>();
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    if (json['recentviews'] != null) {
      recentviews = new List<Recentviews>();
      json['recentviews'].forEach((v) {
        recentviews.add(new Recentviews.fromJson(v));
      });
    }
    if (json['newarrivals'] != null) {
      newarrivals = new List<Newarrivals>();
      json['newarrivals'].forEach((v) {
        newarrivals.add(new Newarrivals.fromJson(v));
      });
    }
    if (json['featuredbrands'] != null) {
      featuredbrands = new List<Featuredbrands>();
      json['featuredbrands'].forEach((v) {
        featuredbrands.add(new Featuredbrands.fromJson(v));
      });
    }
    if (json['recommended_products'] != null) {
      recommendedProducts = new List<RecommendedProducts>();
      json['recommended_products'].forEach((v) {
        recommendedProducts.add(new RecommendedProducts.fromJson(v));
      });
    }
    if (json['featured_products'] != null) {
      featuredProducts = new List<FeaturedProducts>();
      json['featured_products'].forEach((v) {
        featuredProducts.add(new FeaturedProducts.fromJson(v));
      });
    }
    cartcount = json['cartcount'];
    wishlistcount = json['wishlistcount'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    notificationCount = json['notification_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.slider != null) {
      data['slider'] = this.slider.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.sellers != null) {
      data['sellers'] = this.sellers.map((v) => v.toJson()).toList();
    }
    if (this.offers != null) {
      data['offers'] = this.offers.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    if (this.recentviews != null) {
      data['recentviews'] = this.recentviews.map((v) => v.toJson()).toList();
    }
    if (this.newarrivals != null) {
      data['newarrivals'] = this.newarrivals.map((v) => v.toJson()).toList();
    }
    if (this.featuredbrands != null) {
      data['featuredbrands'] =
          this.featuredbrands.map((v) => v.toJson()).toList();
    }
    data['cartcount'] = this.cartcount;
    data['wishlistcount'] = this.wishlistcount;
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.recommendedProducts != null) {
      data['recommended_products'] =
          this.recommendedProducts.map((v) => v.toJson()).toList();
    }
    if (this.featuredProducts != null) {
      data['featured_products'] =
          this.featuredProducts.map((v) => v.toJson()).toList();
    }
    data['notification_count'] = this.notificationCount;
    return data;
  }
}

class HomeSlider {
  int id;
  int bannerTypeId;
  int linkType;
  String linkValue;
  int orderNumber;
  int isActive;
  String startTime;
  String endTime;
  String createdAt;
  String updatedAt;
  int bannerId;
  int languageId;
  String image;
  String mobileImage;
  String title;
  String subTitle;
  String buttonText;
  String name;
  String code;
  String position;
  int status;

  HomeSlider(
      {this.id,
        this.bannerTypeId,
        this.linkType,
        this.linkValue,
        this.orderNumber,
        this.isActive,
        this.startTime,
        this.endTime,
        this.createdAt,
        this.updatedAt,
        this.bannerId,
        this.languageId,
        this.image,
        this.mobileImage,
        this.title,
        this.subTitle,
        this.buttonText,
        this.name,
        this.code,
        this.position,
        this.status});

  HomeSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerTypeId = json['banner_type_id'];
    linkType = json['link_type'];
    linkValue = json['link_value'];
    orderNumber = json['order_number'];
    isActive = json['is_active'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bannerId = json['banner_id'];
    languageId = json['language_id'];
    image = json['image'];
    mobileImage = json['mobile_image'];
    title = json['title'];
    subTitle = json['sub_title'];
    buttonText = json['button_text'];
    name = json['name'];
    code = json['code'];
    position = json['position'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_type_id'] = this.bannerTypeId;
    data['link_type'] = this.linkType;
    data['link_value'] = this.linkValue;
    data['order_number'] = this.orderNumber;
    data['is_active'] = this.isActive;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner_id'] = this.bannerId;
    data['language_id'] = this.languageId;
    data['image'] = this.image;
    data['mobile_image'] = this.mobileImage;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['button_text'] = this.buttonText;
    data['name'] = this.name;
    data['code'] = this.code;
    data['position'] = this.position;
    data['status'] = this.status;
    return data;
  }
}

class Categories {
  Category category;
  int subcategory;

  Categories({this.category, this.subcategory});

  Categories.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['subcategory'] = this.subcategory;
    return data;
  }
}

class Category {
  int id;
  String slug;
  String image;
  String name;
  String description;

  Category({this.id, this.slug, this.image, this.name, this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class Sellers {
  int id;
  String name;
  String address;
  String slug;
  String latitude;
  String longtitude;
  String image;
  String phoneNumber;

  Sellers(
      {this.id,
        this.name,
        this.address,
        this.slug,
        this.latitude,
        this.longtitude,
        this.image,
        this.phoneNumber});

  Sellers.fromJson(Map<String, dynamic> json) {
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

class Offers {
  String image;
  String name;
  int languageId;
  int offerId;
  String createdAt;
  String updatedAt;
  int status;
  String slug;
  int id;
  String amount;
  String startTime;
  String endTime;
  int type;
  int offerFor;
  String metaKeywords;
  String metaDescription;
  String metaTitle;
  String maximumAmount;
  String minimumTransaction;
  int isShownInHomePage;

  Offers(
      {this.image,
        this.name,
        this.languageId,
        this.offerId,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.slug,
        this.id,
        this.amount,
        this.startTime,
        this.endTime,
        this.type,
        this.offerFor,
        this.metaKeywords,
        this.metaDescription,
        this.metaTitle,
        this.maximumAmount,
        this.minimumTransaction,
        this.isShownInHomePage});

  Offers.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    languageId = json['language_id'];
    offerId = json['offer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    slug = json['slug'];
    id = json['id'];
    amount = json['amount'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    type = json['type'];
    offerFor = json['offer_for'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    metaTitle = json['meta_title'];
    maximumAmount = json['maximum_amount'];
    minimumTransaction = json['minimum_transaction'];
    isShownInHomePage = json['is_shown_in_home_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['language_id'] = this.languageId;
    data['offer_id'] = this.offerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['slug'] = this.slug;
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['type'] = this.type;
    data['offer_for'] = this.offerFor;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['meta_title'] = this.metaTitle;
    data['maximum_amount'] = this.maximumAmount;
    data['minimum_transaction'] = this.minimumTransaction;
    data['is_shown_in_home_page'] = this.isShownInHomePage;
    return data;
  }
}

class Recentviews {
  String slug;
  String name;
  String store;
  String manufacturer;
  String symbolLeft;
  String symbolRight;
  String oldprice;
  String price;
  String discount;
  String image;

  Recentviews(
      {this.slug,
        this.name,
        this.store,
        this.manufacturer,
        this.symbolLeft,
        this.symbolRight,
        this.oldprice,
        this.price,
        this.discount,
        this.image});

  Recentviews.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    store = json['store'];
    manufacturer = json['manufacturer'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    oldprice = json['oldprice'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['store'] = this.store;
    data['manufacturer'] = this.manufacturer;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['image'] = this.image;
    return data;
  }
}

class Featuredbrands {
  int id;
  String image;
  int status;
  String slug;
  int isFeatured;
  String createdAt;
  String updatedAt;
  String name;

  Featuredbrands(
      {this.id,
        this.image,
        this.status,
        this.slug,
        this.isFeatured,
        this.createdAt,
        this.updatedAt,
        this.name});

  Featuredbrands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    slug = json['slug'];
    isFeatured = json['is_featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['status'] = this.status;
    data['slug'] = this.slug;
    data['is_featured'] = this.isFeatured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
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

class Address {
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
  String buildingNumber;
  int areaNumber;
  String streetNumber;
  String location;
  Country country;

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
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
  String createdAt;
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
class Banners {
  int id;
  int bannerTypeId;
  int linkType;
  String linkValue;
  int orderNumber;
  int isActive;
  String startTime;
  String endTime;
  String createdAt;
  String updatedAt;
  int bannerId;
  int languageId;
  String image;
  String mobileImage;
  String title;
  String subTitle;
  String buttonText;
  String name;
  String code;
  String position;
  int status;

  Banners(
      {this.id,
        this.bannerTypeId,
        this.linkType,
        this.linkValue,
        this.orderNumber,
        this.isActive,
        this.startTime,
        this.endTime,
        this.createdAt,
        this.updatedAt,
        this.bannerId,
        this.languageId,
        this.image,
        this.mobileImage,
        this.title,
        this.subTitle,
        this.buttonText,
        this.name,
        this.code,
        this.position,
        this.status});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerTypeId = json['banner_type_id'];
    linkType = json['link_type'];
    linkValue = json['link_value'];
    orderNumber = json['order_number'];
    isActive = json['is_active'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bannerId = json['banner_id'];
    languageId = json['language_id'];
    image = json['image'];
    mobileImage = json['mobile_image'];
    title = json['title'];
    subTitle = json['sub_title'];
    buttonText = json['button_text'];
    name = json['name'];
    code = json['code'];
    position = json['position'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_type_id'] = this.bannerTypeId;
    data['link_type'] = this.linkType;
    data['link_value'] = this.linkValue;
    data['order_number'] = this.orderNumber;
    data['is_active'] = this.isActive;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner_id'] = this.bannerId;
    data['language_id'] = this.languageId;
    data['image'] = this.image;
    data['mobile_image'] = this.mobileImage;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['button_text'] = this.buttonText;
    data['name'] = this.name;
    data['code'] = this.code;
    data['position'] = this.position;
    data['status'] = this.status;
    return data;
  }
}
class Newarrivals {
  String slug;
  String name;
  String store;
  String manufacturer;
  String symbolLeft;
  String symbolRight;
  String oldprice;
  String price;
  String discount;
  String image;

  Newarrivals(
      {this.slug,
        this.name,
        this.store,
        this.manufacturer,
        this.symbolLeft,
        this.symbolRight,
        this.oldprice,
        this.price,
        this.discount,
        this.image});

  Newarrivals.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    store = json['store'];
    manufacturer = json['manufacturer'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    oldprice = json['oldprice'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['store'] = this.store;
    data['manufacturer'] = this.manufacturer;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['image'] = this.image;
    return data;
  }
}

class RecommendedProducts {
  String slug;
  String code;
  String name;
  String description;
  String appDescription;
  String store;
  String manufacturer;
  String symbolLeft;
  String symbolRight;
  String oldprice;
  String price;
  String discount;
  String rating;
  String image;
  int cart;
  int wishlist;

  RecommendedProducts(
      {this.slug,
        this.code,
        this.name,
        this.description,
        this.appDescription,
        this.store,
        this.manufacturer,
        this.symbolLeft,
        this.symbolRight,
        this.oldprice,
        this.price,
        this.discount,
        this.rating,
        this.image,
        this.cart,
        this.wishlist});

  RecommendedProducts.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    appDescription = json['app_description'];
    store = json['store'];
    manufacturer = json['manufacturer'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    oldprice = json['oldprice'];
    price = json['price'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['image'];
    cart = json['cart'];
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['app_description'] = this.appDescription;
    data['store'] = this.store;
    data['manufacturer'] = this.manufacturer;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['cart'] = this.cart;
    data['wishlist'] = this.wishlist;
    return data;
  }
}

class FeaturedProducts {
  String slug;
  String code;
  String name;
  String description;
  String appDescription;
  String store;
  String manufacturer;
  String symbolLeft;
  String symbolRight;
  String oldprice;
  String price;
  String discount;
  String rating;
  String image;
  int cart;
  int wishlist;

  FeaturedProducts(
      {this.slug,
        this.code,
        this.name,
        this.description,
        this.appDescription,
        this.store,
        this.manufacturer,
        this.symbolLeft,
        this.symbolRight,
        this.oldprice,
        this.price,
        this.discount,
        this.rating,
        this.image,
        this.cart,
        this.wishlist});

  FeaturedProducts.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    appDescription = json['app_description'];
    store = json['store'];
    manufacturer = json['manufacturer'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    oldprice = json['oldprice'];
    price = json['price'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['image'];
    cart = json['cart'];
    wishlist = json['wishlist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['app_description'] = this.appDescription;
    data['store'] = this.store;
    data['manufacturer'] = this.manufacturer;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['cart'] = this.cart;
    data['wishlist'] = this.wishlist;
    return data;
  }
}