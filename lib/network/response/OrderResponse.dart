class OrderResponse {
  int success;
  String message;
  Result result;
  String bank;

  OrderResponse({this.success, this.message, this.result, this.bank});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['bank'] = this.bank;
    return data;
  }
}

class Result {
  int currentPage;
  List<Data> data;
  int from;
  int lastPage;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Result(
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

  Result.fromJson(Map<String, dynamic> json) {
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
  int id;
  String invoiceNumber;
  int storeId;
  String storeName;
  int customerId;
  int billingAddressId;
  String billingAddressType;
  String billingName;
  String billingEmail;
  String billingPhone;
  String billingAddress;
  String billingCity;
  String billingState;
  String billingCountry;
  String billingZipcode;
  String billingLatitude;
  String billingLongitude;
  int shippingAddressId;
  String shippingAddressType;
  String shippingName;
  String shippingEmail;
  String shippingPhone;
  String shippingAddress;
  String shippingCity;
  String shippingState;
  String shippingCountry;
  String shippingZipcode;
  String shippingLatitude;
  String shippingLongitude;
  String comments;
  int cartId;
  String totalAmount;
  String couponId;
  String couponCode;
  String couponDiscount;
  int couponDiscountType;
  String discountAmount;
  int walletAmount;
  String shippingCharge;
  String totalTaxAmount;
  String netTotalAmount;
  PaymentMode paymentMode;
  String deliveryMode;
  String pickupStoreId;
  int languageId;
  int currencyId;
  String currencyValue;
  String ip;
  String userAgent;
  int orderStatusId;
  String orderStatus;
  int paymentStatus;
  String orderCancelReason;
  String orderCancelDescription;
  String createdAt;
  String updatedAt;
  int isExpress;
  String pickupdates;
  String pickuptime;
  String billingAreaNumber1;
  String shippingAreaNumber1;
  String billingAreaNumber;
  String shippingAreaNumber;
  String orderWalletAmount;
  String orderTotalAmount;
  String orderNetTotalAmount;
  String orderShippingCharge;
  List<ItemsNew> itemsNew;
  Currency currency;
  List<Items> items;
  Data(
      {this.id,
        this.invoiceNumber,
        this.storeId,
        this.storeName,
        this.customerId,
        this.billingAddressId,
        this.billingAddressType,
        this.billingName,
        this.billingEmail,
        this.billingPhone,
        this.billingAddress,
        this.billingCity,
        this.billingState,
        this.billingCountry,
        this.billingZipcode,
        this.billingLatitude,
        this.billingLongitude,
        this.shippingAddressId,
        this.shippingAddressType,
        this.shippingName,
        this.shippingEmail,
        this.shippingPhone,
        this.shippingAddress,
        this.shippingCity,
        this.shippingState,
        this.shippingCountry,
        this.shippingZipcode,
        this.shippingLatitude,
        this.shippingLongitude,
        this.comments,
        this.cartId,
        this.totalAmount,
        this.couponId,
        this.couponCode,
        this.couponDiscount,
        this.couponDiscountType,
        this.discountAmount,
        this.walletAmount,
        this.shippingCharge,
        this.totalTaxAmount,
        this.netTotalAmount,
        this.paymentMode,
        this.deliveryMode,
        this.pickupStoreId,
        this.languageId,
        this.currencyId,
        this.currencyValue,
        this.ip,
        this.userAgent,
        this.orderStatusId,
        this.orderStatus,
        this.paymentStatus,
        this.orderCancelReason,
        this.orderCancelDescription,
        this.createdAt,
        this.updatedAt,
        this.isExpress,
        this.pickupdates,
        this.pickuptime,
        this.billingAreaNumber1,
        this.shippingAreaNumber1,
        this.billingAreaNumber,
        this.shippingAreaNumber,
        this.orderWalletAmount,
        this.orderTotalAmount,
        this.orderNetTotalAmount,
        this.orderShippingCharge,
        this.itemsNew,
        this.currency,
        this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    customerId = json['customer_id'];
    billingAddressId = json['billing_address_id'];
    billingAddressType = json['billing_address_type'];
    billingName = json['billing_name'];
    billingEmail = json['billing_email'];
    billingPhone = json['billing_phone'];
    billingAddress = json['billing_address'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    billingCountry = json['billing_country'];
    billingZipcode = json['billing_zipcode'];
    billingLatitude = json['billing_latitude'];
    billingLongitude = json['billing_longitude'];
    shippingAddressId = json['shipping_address_id'];
    shippingAddressType = json['shipping_address_type'];
    shippingName = json['shipping_name'];
    shippingEmail = json['shipping_email'];
    shippingPhone = json['shipping_phone'];
    shippingAddress = json['shipping_address'];
    shippingCity = json['shipping_city'];
    shippingState = json['shipping_state'];
    shippingCountry = json['shipping_country'];
    shippingZipcode = json['shipping_zipcode'];
    shippingLatitude = json['shipping_latitude'];
    shippingLongitude = json['shipping_longitude'];
    comments = json['comments'];
    cartId = json['cart_id'];
    totalAmount = json['total_amount'].toString();
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    couponDiscount = json['coupon_discount'];
    couponDiscountType = json['coupon_discount_type'];
    discountAmount = json['discount_amount'];
    walletAmount = json['wallet_amount'];
    shippingCharge = json['shipping_charge'];
    totalTaxAmount = json['total_tax_amount'].toString();
    netTotalAmount = json['net_total_amount'].toString();
    paymentMode = json['payment_mode'] != null
        ? new PaymentMode.fromJson(json['payment_mode'])
        : null;
    deliveryMode = json['delivery_mode'];
    pickupStoreId = json['pickup_store_id'];
    languageId = json['language_id'];
    currencyId = json['currency_id'];
    currencyValue = json['currency_value'];
    ip = json['ip'];
    userAgent = json['user_agent'];
    orderStatusId = json['order_status_id'];
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    orderCancelReason = json['order_cancel_reason'];
    orderCancelDescription = json['order_cancel_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isExpress = json['is_express'];
    pickupdates = json['pickupdates'];
    pickuptime = json['pickuptime'];
    billingAreaNumber1 = json['billing_area_number1'];
    shippingAreaNumber1 = json['shipping_area_number1'];
    billingAreaNumber = json['billing_area_number'];
    shippingAreaNumber = json['shipping_area_number'];
    orderWalletAmount = json['order_wallet_amount'];
    orderTotalAmount = json['order_total_amount'];
    orderNetTotalAmount = json['order_net_total_amount'];
    orderShippingCharge = json['order_shipping_charge'];
    if (json['items_new'] != null) {
      itemsNew = new List<ItemsNew>();
      json['items_new'].forEach((v) {
        itemsNew.add(new ItemsNew.fromJson(v));
      });
    }
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['customer_id'] = this.customerId;
    data['billing_address_id'] = this.billingAddressId;
    data['billing_address_type'] = this.billingAddressType;
    data['billing_name'] = this.billingName;
    data['billing_email'] = this.billingEmail;
    data['billing_phone'] = this.billingPhone;
    data['billing_address'] = this.billingAddress;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingState;
    data['billing_country'] = this.billingCountry;
    data['billing_zipcode'] = this.billingZipcode;
    data['billing_latitude'] = this.billingLatitude;
    data['billing_longitude'] = this.billingLongitude;
    data['shipping_address_id'] = this.shippingAddressId;
    data['shipping_address_type'] = this.shippingAddressType;
    data['shipping_name'] = this.shippingName;
    data['shipping_email'] = this.shippingEmail;
    data['shipping_phone'] = this.shippingPhone;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_city'] = this.shippingCity;
    data['shipping_state'] = this.shippingState;
    data['shipping_country'] = this.shippingCountry;
    data['shipping_zipcode'] = this.shippingZipcode;
    data['shipping_latitude'] = this.shippingLatitude;
    data['shipping_longitude'] = this.shippingLongitude;
    data['comments'] = this.comments;
    data['cart_id'] = this.cartId;
    data['total_amount'] = this.totalAmount;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['coupon_discount'] = this.couponDiscount;
    data['coupon_discount_type'] = this.couponDiscountType;
    data['discount_amount'] = this.discountAmount;
    data['wallet_amount'] = this.walletAmount;
    data['shipping_charge'] = this.shippingCharge;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['net_total_amount'] = this.netTotalAmount;
    if (this.paymentMode != null) {
      data['payment_mode'] = this.paymentMode.toJson();
    }
    data['delivery_mode'] = this.deliveryMode;
    data['pickup_store_id'] = this.pickupStoreId;
    data['language_id'] = this.languageId;
    data['currency_id'] = this.currencyId;
    data['currency_value'] = this.currencyValue;
    data['ip'] = this.ip;
    data['user_agent'] = this.userAgent;
    data['order_status_id'] = this.orderStatusId;
    data['order_status'] = this.orderStatus;
    data['payment_status'] = this.paymentStatus;
    data['order_cancel_reason'] = this.orderCancelReason;
    data['order_cancel_description'] = this.orderCancelDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_express'] = this.isExpress;
    data['pickupdates'] = this.pickupdates;
    data['pickuptime'] = this.pickuptime;
    data['billing_area_number1'] = this.billingAreaNumber1;
    data['shipping_area_number1'] = this.shippingAreaNumber1;
    data['billing_area_number'] = this.billingAreaNumber;
    data['shipping_area_number'] = this.shippingAreaNumber;
    data['order_wallet_amount'] = this.orderWalletAmount;
    data['order_total_amount'] = this.orderTotalAmount;
    data['order_net_total_amount'] = this.orderNetTotalAmount;
    data['order_shipping_charge'] = this.orderShippingCharge;
    if (this.itemsNew != null) {
      data['items_new'] = this.itemsNew.map((v) => v.toJson()).toList();
    }
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMode {
  int id;
  String mode;
  String image;
  int status;
  String createdAt;
  String updatedAt;

  PaymentMode(
      {this.id,
        this.mode,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  PaymentMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mode = json['mode'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mode'] = this.mode;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ItemsNew {
  int id;
  int orderId;
  String sellerInvoiceReference;
  String itemCgst;
  String itemSgst;
  String itemIgst;
  String itemUtgst;
  String itemCess;
  String shippingCgst;
  String shippingSgst;
  String shippingIgst;
  String shippingUtgst;
  String shippingCess;
  int productId;
  int storeId;
  String paidToSellerReference;
  String sellerRefundAmount;
  String paidAmountToAdmin;
  int paidToAdmin;
  String paidToAdminDate;
  String paidToAdminReference;
  String productName;
  String quantity;
  String amount;
  String taxAmount;
  String couponAmount;
  int itemStatus;
  String shippingCharge;
  int returnPeriod;
  String refundPayable;
  String refundPayed;
  String refundBankId;
  String refundBankDetails;
  String itemCancelReason;
  String itemCancelDescription;
  String cgst;
  String sgst;
  String igst;
  String utgst;
  String cess;
  String createdAt;
  String updatedAt;
  String slug;
  int status;
  String stock;
  String image;
  int possibleAction;
  String statusText;
  String refund;
  Product product;

  ItemsNew(
      {this.id,
        this.orderId,
        this.sellerInvoiceReference,
        this.itemCgst,
        this.itemSgst,
        this.itemIgst,
        this.itemUtgst,
        this.itemCess,
        this.shippingCgst,
        this.shippingSgst,
        this.shippingIgst,
        this.shippingUtgst,
        this.shippingCess,
        this.productId,
        this.storeId,
        this.paidToSellerReference,
        this.sellerRefundAmount,
        this.paidAmountToAdmin,
        this.paidToAdmin,
        this.paidToAdminDate,
        this.paidToAdminReference,
        this.productName,
        this.quantity,
        this.amount,
        this.taxAmount,
        this.couponAmount,
        this.itemStatus,
        this.shippingCharge,
        this.returnPeriod,
        this.refundPayable,
        this.refundPayed,
        this.refundBankId,
        this.refundBankDetails,
        this.itemCancelReason,
        this.itemCancelDescription,
        this.cgst,
        this.sgst,
        this.igst,
        this.utgst,
        this.cess,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.status,
        this.stock,
        this.image,
        this.possibleAction,
        this.statusText,
        this.refund,
        this.product});

  ItemsNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    sellerInvoiceReference = json['seller_invoice_reference'];
    itemCgst = json['item_cgst'];
    itemSgst = json['item_sgst'];
    itemIgst = json['item_igst'];
    itemUtgst = json['item_utgst'];
    itemCess = json['item_cess'];
    shippingCgst = json['shipping_cgst'];
    shippingSgst = json['shipping_sgst'];
    shippingIgst = json['shipping_igst'];
    shippingUtgst = json['shipping_utgst'];
    shippingCess = json['shipping_cess'];
    productId = json['product_id'];
    storeId = json['store_id'];
    paidToSellerReference = json['paid_to_seller_reference'];
    sellerRefundAmount = json['seller_refund_amount'];
    paidAmountToAdmin = json['paid_amount_to_admin'];
    paidToAdmin = json['paid_to_admin'];
    paidToAdminDate = json['paid_to_admin_date'];
    paidToAdminReference = json['paid_to_admin_reference'];
    productName = json['product_name'];
    quantity = json['quantity'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    couponAmount = json['coupon_amount'];
    itemStatus = json['item_status'];
    shippingCharge = json['shipping_charge'];
    returnPeriod = json['return_period'];
    refundPayable = json['refund_payable'];
    refundPayed = json['refund_payed'];
    refundBankId = json['refund_bank_id'];
    refundBankDetails = json['refund_bank_details'];
    itemCancelReason = json['item_cancel_reason'];
    itemCancelDescription = json['item_cancel_description'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    utgst = json['utgst'];
    cess = json['cess'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    status = json['status'];
    stock = json['stock'];
    image = json['image'];
    possibleAction = json['possible_action'];
    statusText = json['status_text'];
    refund = json['refund'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['seller_invoice_reference'] = this.sellerInvoiceReference;
    data['item_cgst'] = this.itemCgst;
    data['item_sgst'] = this.itemSgst;
    data['item_igst'] = this.itemIgst;
    data['item_utgst'] = this.itemUtgst;
    data['item_cess'] = this.itemCess;
    data['shipping_cgst'] = this.shippingCgst;
    data['shipping_sgst'] = this.shippingSgst;
    data['shipping_igst'] = this.shippingIgst;
    data['shipping_utgst'] = this.shippingUtgst;
    data['shipping_cess'] = this.shippingCess;
    data['product_id'] = this.productId;
    data['store_id'] = this.storeId;
    data['paid_to_seller_reference'] = this.paidToSellerReference;
    data['seller_refund_amount'] = this.sellerRefundAmount;
    data['paid_amount_to_admin'] = this.paidAmountToAdmin;
    data['paid_to_admin'] = this.paidToAdmin;
    data['paid_to_admin_date'] = this.paidToAdminDate;
    data['paid_to_admin_reference'] = this.paidToAdminReference;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['tax_amount'] = this.taxAmount;
    data['coupon_amount'] = this.couponAmount;
    data['item_status'] = this.itemStatus;
    data['shipping_charge'] = this.shippingCharge;
    data['return_period'] = this.returnPeriod;
    data['refund_payable'] = this.refundPayable;
    data['refund_payed'] = this.refundPayed;
    data['refund_bank_id'] = this.refundBankId;
    data['refund_bank_details'] = this.refundBankDetails;
    data['item_cancel_reason'] = this.itemCancelReason;
    data['item_cancel_description'] = this.itemCancelDescription;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    data['utgst'] = this.utgst;
    data['cess'] = this.cess;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['stock'] = this.stock;
    data['image'] = this.image;
    data['possible_action'] = this.possibleAction;
    data['status_text'] = this.statusText;
    data['refund'] = this.refund;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
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
  String metaTitle;
  String metaDescription;
  String metaKeywords;
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

class Currency {
  String name;
  String code;
  String symbolLeft;
  String symbolRight;

  Currency({this.name, this.code, this.symbolLeft, this.symbolRight});

  Currency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    return data;
  }
}

class Items {
  int id;
  int orderId;
  String sellerInvoiceReference;
  String itemCgst;
  String itemSgst;
  String itemIgst;
  String itemUtgst;
  String itemCess;
  String shippingCgst;
  String shippingSgst;
  String shippingIgst;
  String shippingUtgst;
  String shippingCess;
  int productId;
  int storeId;
  String paidToSellerReference;
  String sellerRefundAmount;
  String paidAmountToAdmin;
  int paidToAdmin;
  String paidToAdminDate;
  String paidToAdminReference;
  String productName;
  String quantity;
  String amount;
  String taxAmount;
  String couponAmount;
  int itemStatus;
  String shippingCharge;
  int returnPeriod;
  String refundPayable;
  String refundPayed;
  String refundBankId;
  String refundBankDetails;
  String itemCancelReason;
  String itemCancelDescription;
  String cgst;
  String sgst;
  String igst;
  String utgst;
  String cess;
  String createdAt;
  String updatedAt;
  Product product;

  Items(
      {this.id,
        this.orderId,
        this.sellerInvoiceReference,
        this.itemCgst,
        this.itemSgst,
        this.itemIgst,
        this.itemUtgst,
        this.itemCess,
        this.shippingCgst,
        this.shippingSgst,
        this.shippingIgst,
        this.shippingUtgst,
        this.shippingCess,
        this.productId,
        this.storeId,
        this.paidToSellerReference,
        this.sellerRefundAmount,
        this.paidAmountToAdmin,
        this.paidToAdmin,
        this.paidToAdminDate,
        this.paidToAdminReference,
        this.productName,
        this.quantity,
        this.amount,
        this.taxAmount,
        this.couponAmount,
        this.itemStatus,
        this.shippingCharge,
        this.returnPeriod,
        this.refundPayable,
        this.refundPayed,
        this.refundBankId,
        this.refundBankDetails,
        this.itemCancelReason,
        this.itemCancelDescription,
        this.cgst,
        this.sgst,
        this.igst,
        this.utgst,
        this.cess,
        this.createdAt,
        this.updatedAt,
        this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    sellerInvoiceReference = json['seller_invoice_reference'];
    itemCgst = json['item_cgst'];
    itemSgst = json['item_sgst'];
    itemIgst = json['item_igst'];
    itemUtgst = json['item_utgst'];
    itemCess = json['item_cess'];
    shippingCgst = json['shipping_cgst'];
    shippingSgst = json['shipping_sgst'];
    shippingIgst = json['shipping_igst'];
    shippingUtgst = json['shipping_utgst'];
    shippingCess = json['shipping_cess'];
    productId = json['product_id'];
    storeId = json['store_id'];
    paidToSellerReference = json['paid_to_seller_reference'];
    sellerRefundAmount = json['seller_refund_amount'];
    paidAmountToAdmin = json['paid_amount_to_admin'];
    paidToAdmin = json['paid_to_admin'];
    paidToAdminDate = json['paid_to_admin_date'];
    paidToAdminReference = json['paid_to_admin_reference'];
    productName = json['product_name'];
    quantity = json['quantity'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    couponAmount = json['coupon_amount'];
    itemStatus = json['item_status'];
    shippingCharge = json['shipping_charge'];
    returnPeriod = json['return_period'];
    refundPayable = json['refund_payable'];
    refundPayed = json['refund_payed'];
    refundBankId = json['refund_bank_id'];
    refundBankDetails = json['refund_bank_details'];
    itemCancelReason = json['item_cancel_reason'];
    itemCancelDescription = json['item_cancel_description'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    utgst = json['utgst'];
    cess = json['cess'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['seller_invoice_reference'] = this.sellerInvoiceReference;
    data['item_cgst'] = this.itemCgst;
    data['item_sgst'] = this.itemSgst;
    data['item_igst'] = this.itemIgst;
    data['item_utgst'] = this.itemUtgst;
    data['item_cess'] = this.itemCess;
    data['shipping_cgst'] = this.shippingCgst;
    data['shipping_sgst'] = this.shippingSgst;
    data['shipping_igst'] = this.shippingIgst;
    data['shipping_utgst'] = this.shippingUtgst;
    data['shipping_cess'] = this.shippingCess;
    data['product_id'] = this.productId;
    data['store_id'] = this.storeId;
    data['paid_to_seller_reference'] = this.paidToSellerReference;
    data['seller_refund_amount'] = this.sellerRefundAmount;
    data['paid_amount_to_admin'] = this.paidAmountToAdmin;
    data['paid_to_admin'] = this.paidToAdmin;
    data['paid_to_admin_date'] = this.paidToAdminDate;
    data['paid_to_admin_reference'] = this.paidToAdminReference;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['tax_amount'] = this.taxAmount;
    data['coupon_amount'] = this.couponAmount;
    data['item_status'] = this.itemStatus;
    data['shipping_charge'] = this.shippingCharge;
    data['return_period'] = this.returnPeriod;
    data['refund_payable'] = this.refundPayable;
    data['refund_payed'] = this.refundPayed;
    data['refund_bank_id'] = this.refundBankId;
    data['refund_bank_details'] = this.refundBankDetails;
    data['item_cancel_reason'] = this.itemCancelReason;
    data['item_cancel_description'] = this.itemCancelDescription;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    data['utgst'] = this.utgst;
    data['cess'] = this.cess;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}
