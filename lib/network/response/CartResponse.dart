class CartResponse {
  int success;
  String message;
  List<Products> products;
  String symbolLeft;
  String symbolRight;
  String netTotal;
  int deliveryCharge;
  String wallet;
  String grandTotal;
  int cartcount;
  String walletMessage;

  CartResponse(
      {this.success,
        this.message,
        this.products,
        this.symbolLeft,
        this.symbolRight,
        this.netTotal,
        this.deliveryCharge,
        this.wallet,
        this.grandTotal,
        this.cartcount,
        this.walletMessage});

  CartResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    netTotal = json['net_total'];
    deliveryCharge = json['delivery_charge'];
    wallet = json['wallet'];
    grandTotal = json['grand_total'];
    cartcount = json['cartcount'];
    walletMessage = json['wallet_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['net_total'] = this.netTotal;
    data['delivery_charge'] = this.deliveryCharge;
    data['wallet'] = this.wallet;
    data['grand_total'] = this.grandTotal;
    data['cartcount'] = this.cartcount;
    data['wallet_message'] = this.walletMessage;
    return data;
  }
}

class Products {
  int i0;
  int id;
  String slug;
  String code;
  String name;
  String description;
  String appDescription;
  int storeId;
  String stock;
  String commission;
  int type;
  String storeslug;
  String seller;
  String manufacturer;
  String value;
  String symbolLeft;
  String symbolRight;
  int productId;
  String cgst;
  String sgst;
  String igst;
  String utgst;
  String cess;
  String quantity;
  String oldprice;
  String price;
  String singleprice;
  String discount;
  String rating;
  String image;
  int wishlist;
  int deliveryCharge;
  DeliveryDetails deliveryDetails;
  Product product;

  Products(
      {this.i0,
        this.id,
        this.slug,
        this.code,
        this.name,
        this.description,
        this.appDescription,
        this.storeId,
        this.stock,
        this.commission,
        this.type,
        this.storeslug,
        this.seller,
        this.manufacturer,
        this.value,
        this.symbolLeft,
        this.symbolRight,
        this.productId,
        this.cgst,
        this.sgst,
        this.igst,
        this.utgst,
        this.cess,
        this.quantity,
        this.oldprice,
        this.price,
        this.singleprice,
        this.discount,
        this.rating,
        this.image,
        this.wishlist,
        this.deliveryCharge,
        this.deliveryDetails,
        this.product});

  Products.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    id = json['id'];
    slug = json['slug'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    appDescription = json['app_description'];
    storeId = json['store_id'];
    stock = json['stock'];
    commission = json['commission'];
    type = json['type'];
    storeslug = json['storeslug'];
    seller = json['seller'];
    manufacturer = json['manufacturer'];
    value = json['value'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
    productId = json['product_id'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    utgst = json['utgst'];
    cess = json['cess'];
    quantity = json['quantity'];
    oldprice = json['oldprice'];
    price = json['price'];
    singleprice = json['singleprice'];
    discount = json['discount'];
    rating = json['rating'];
    image = json['image'];
    wishlist = json['wishlist'];
    deliveryCharge = json['delivery_charge'];
    deliveryDetails = json['delivery_details'] != null
        ? new DeliveryDetails.fromJson(json['delivery_details'])
        : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['app_description'] = this.appDescription;
    data['store_id'] = this.storeId;
    data['stock'] = this.stock;
    data['commission'] = this.commission;
    data['type'] = this.type;
    data['storeslug'] = this.storeslug;
    data['seller'] = this.seller;
    data['manufacturer'] = this.manufacturer;
    data['value'] = this.value;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    data['product_id'] = this.productId;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    data['utgst'] = this.utgst;
    data['cess'] = this.cess;
    data['quantity'] = this.quantity;
    data['oldprice'] = this.oldprice;
    data['price'] = this.price;
    data['singleprice'] = this.singleprice;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['wishlist'] = this.wishlist;
    data['delivery_charge'] = this.deliveryCharge;
    if (this.deliveryDetails != null) {
      data['delivery_details'] = this.deliveryDetails.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class DeliveryDetails {
  int returnPolicy;
  int deliveryPosible;
  int codAvailable;

  DeliveryDetails({this.returnPolicy, this.deliveryPosible, this.codAvailable});

  DeliveryDetails.fromJson(Map<String, dynamic> json) {
    returnPolicy = json['return_policy'];
    deliveryPosible = json['delivery_posible'];
    codAvailable = json['cod_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['return_policy'] = this.returnPolicy;
    data['delivery_posible'] = this.deliveryPosible;
    data['cod_available'] = this.codAvailable;
    return data;
  }
}

class Product {
  String code;
  int userId;
  int status;
  int parentId;
  int isShowInList;
  int taxClassId;
  String slug;
  int isFeatured;
  int isPuliAssured;
  String weight;
  String sizeChart;
  int orderNumber;
  String rewardPoint;
  String purchaseReward;
  Null metaTitle;
  Null metaDescription;
  Null metaKeywords;
  String cgst;
  String sgst;
  String igst;
  String utgst;
  String cess;
  int isAlisonsAssured;
  String createdAt;
  String updatedAt;
  int isLatest;
  List<ThisOptions> thisOptions;

  Product(
      {this.code,
        this.userId,
        this.status,
        this.parentId,
        this.isShowInList,
        this.taxClassId,
        this.slug,
        this.isFeatured,
        this.isPuliAssured,
        this.weight,
        this.sizeChart,
        this.orderNumber,
        this.rewardPoint,
        this.purchaseReward,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.cgst,
        this.sgst,
        this.igst,
        this.utgst,
        this.cess,
        this.isAlisonsAssured,
        this.createdAt,
        this.updatedAt,
        this.isLatest,
        this.thisOptions});

  Product.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    userId = json['user_id'];
    status = json['status'];
    parentId = json['parent_id'];
    isShowInList = json['is_show_in_list'];
    taxClassId = json['tax_class_id'];
    slug = json['slug'];
    isFeatured = json['is_featured'];
    isPuliAssured = json['is_puli_assured'];
    weight = json['weight'];
    sizeChart = json['size_chart'];
    orderNumber = json['order_number'];
    rewardPoint = json['reward_point'];
    purchaseReward = json['purchase_reward'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    utgst = json['utgst'];
    cess = json['cess'];
    isAlisonsAssured = json['is_alisons_assured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isLatest = json['is_latest'];
    if (json['this_options'] != null) {
      thisOptions = new List<ThisOptions>();
      json['this_options'].forEach((v) {
        thisOptions.add(new ThisOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['parent_id'] = this.parentId;
    data['is_show_in_list'] = this.isShowInList;
    data['tax_class_id'] = this.taxClassId;
    data['slug'] = this.slug;
    data['is_featured'] = this.isFeatured;
    data['is_puli_assured'] = this.isPuliAssured;
    data['weight'] = this.weight;
    data['size_chart'] = this.sizeChart;
    data['order_number'] = this.orderNumber;
    data['reward_point'] = this.rewardPoint;
    data['purchase_reward'] = this.purchaseReward;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    data['utgst'] = this.utgst;
    data['cess'] = this.cess;
    data['is_alisons_assured'] = this.isAlisonsAssured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_latest'] = this.isLatest;
    if (this.thisOptions != null) {
      data['this_options'] = this.thisOptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThisOptions {
  int optionId;
  String name;
  int productId;
  int id;
  String type;
  ThisValues thisValues;

  ThisOptions(
      {this.optionId,
        this.name,
        this.productId,
        this.id,
        this.type,
        this.thisValues});

  ThisOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    name = json['name'];
    productId = json['product_id'];
    id = json['id'];
    type = json['type'];
    thisValues = json['this_values'] != null
        ? new ThisValues.fromJson(json['this_values'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.thisValues != null) {
      data['this_values'] = this.thisValues.toJson();
    }
    return data;
  }
}

class ThisValues {
  int optionValueId;
  String value;
  String text;
  String slug;
  int productOptionId;

  ThisValues(
      {this.optionValueId,
        this.value,
        this.text,
        this.slug,
        this.productOptionId});

  ThisValues.fromJson(Map<String, dynamic> json) {
    optionValueId = json['option_value_id'];
    value = json['value'];
    text = json['text'];
    slug = json['slug'];
    productOptionId = json['product_option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_value_id'] = this.optionValueId;
    data['value'] = this.value;
    data['text'] = this.text;
    data['slug'] = this.slug;
    data['product_option_id'] = this.productOptionId;
    return data;
  }
}
