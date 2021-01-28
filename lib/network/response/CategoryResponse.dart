

class CategoryResponse{
  int success;
  String message;
  List<Categories> categories;

  CategoryResponse({this.success, this.message, this.categories});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  Category category;
  List<Subcategories> subcategories;

  Categories({this.category, this.subcategories});

  Categories.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['subcategories'] != null) {
      subcategories = new List<Subcategories>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  int parentId;
  int orderNumber;
  String image;
  int status;
  String slug;
  int isPuliExpress;
  int isPuliAssured;
  int isAlisonsAssured;
  int isAlisonsExpress;
  int isVisibleInHome;
  int isTryAndBuyAvailable;
  String metaTitle;
  Null metaDescription;
  Null metaKeywords;
  String createdAt;
  String updatedAt;
  int categoryId;
  int languageId;
  String name;
  String description;

  Category(
      {this.id,
        this.parentId,
        this.orderNumber,
        this.image,
        this.status,
        this.slug,
        this.isPuliExpress,
        this.isPuliAssured,
        this.isAlisonsAssured,
        this.isAlisonsExpress,
        this.isVisibleInHome,
        this.isTryAndBuyAvailable,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.languageId,
        this.name,
        this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    orderNumber = json['order_number'];
    image = json['image'];
    status = json['status'];
    slug = json['slug'];
    isPuliExpress = json['is_puli_express'];
    isPuliAssured = json['is_puli_assured'];
    isAlisonsAssured = json['is_alisons_assured'];
    isAlisonsExpress = json['is_alisons_express'];
    isVisibleInHome = json['is_visible_in_home'];
    isTryAndBuyAvailable = json['is_try_and_buy_available'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    languageId = json['language_id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['order_number'] = this.orderNumber;
    data['image'] = this.image;
    data['status'] = this.status;
    data['slug'] = this.slug;
    data['is_puli_express'] = this.isPuliExpress;
    data['is_puli_assured'] = this.isPuliAssured;
    data['is_alisons_assured'] = this.isAlisonsAssured;
    data['is_alisons_express'] = this.isAlisonsExpress;
    data['is_visible_in_home'] = this.isVisibleInHome;
    data['is_try_and_buy_available'] = this.isTryAndBuyAvailable;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['language_id'] = this.languageId;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class Subcategories {
  int id;
  int parentId;
  int orderNumber;
  String image;
  int status;
  String slug;
  int isPuliExpress;
  int isPuliAssured;
  int isAlisonsAssured;
  int isAlisonsExpress;
  int isVisibleInHome;
  int isTryAndBuyAvailable;
  String metaTitle;
  String metaDescription;
  Null metaKeywords;
  String createdAt;
  String updatedAt;
  int categoryId;
  int languageId;
  String name;
  String description;
  int subcategoriesCount;

  Subcategories(
      {this.id,
        this.parentId,
        this.orderNumber,
        this.image,
        this.status,
        this.slug,
        this.isPuliExpress,
        this.isPuliAssured,
        this.isAlisonsAssured,
        this.isAlisonsExpress,
        this.isVisibleInHome,
        this.isTryAndBuyAvailable,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.languageId,
        this.name,
        this.description,
        this.subcategoriesCount,
      });

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    orderNumber = json['order_number'];
    image = json['image'];
    status = json['status'];
    slug = json['slug'];
    isPuliExpress = json['is_puli_express'];
    isPuliAssured = json['is_puli_assured'];
    isAlisonsAssured = json['is_alisons_assured'];
    isAlisonsExpress = json['is_alisons_express'];
    isVisibleInHome = json['is_visible_in_home'];
    isTryAndBuyAvailable = json['is_try_and_buy_available'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    languageId = json['language_id'];
    name = json['name'];
    description = json['description'];
    subcategoriesCount = json['subcategories_count'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['order_number'] = this.orderNumber;
    data['image'] = this.image;
    data['status'] = this.status;
    data['slug'] = this.slug;
    data['is_puli_express'] = this.isPuliExpress;
    data['is_puli_assured'] = this.isPuliAssured;
    data['is_alisons_assured'] = this.isAlisonsAssured;
    data['is_alisons_express'] = this.isAlisonsExpress;
    data['is_visible_in_home'] = this.isVisibleInHome;
    data['is_try_and_buy_available'] = this.isTryAndBuyAvailable;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['language_id'] = this.languageId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['subcategories_count'] = this.subcategoriesCount;
    return data;
  }
}
