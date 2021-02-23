class NewsDetailsResponse {
  int success;
  String message;
  News news;

  NewsDetailsResponse({this.success, this.message, this.news});

  NewsDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    news = json['news'] != null ? new News.fromJson(json['news']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.news != null) {
      data['news'] = this.news.toJson();
    }
    return data;
  }
}

class News {
  int id;
  String linkType;
  String linkValue;
  int orderNumber;
  String isActive;
  String startTime;
  String createdAt;
  String updatedAt;
  String endTime;
  String slug;
  int blogId;
  String title;
  String metaDetails;
  String details;
  String image;
  int languageId;
  int category;
  int categoryId;
  String name;
  String description;

  News(
      {this.id,
        this.linkType,
        this.linkValue,
        this.orderNumber,
        this.isActive,
        this.startTime,
        this.createdAt,
        this.updatedAt,
        this.endTime,
        this.slug,
        this.blogId,
        this.title,
        this.metaDetails,
        this.details,
        this.image,
        this.languageId,
        this.category,
        this.categoryId,
        this.name,
        this.description});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    linkType = json['link_type'];
    linkValue = json['link_value'];
    orderNumber = json['order_number'];
    isActive = json['is_active'];
    startTime = json['start_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    endTime = json['end_time'];
    slug = json['slug'];
    blogId = json['blog_id'];
    title = json['title'];
    metaDetails = json['meta_details'];
    details = json['details'];
    image = json['image'];
    languageId = json['language_id'];
    category = json['category'];
    categoryId = json['category_id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link_type'] = this.linkType;
    data['link_value'] = this.linkValue;
    data['order_number'] = this.orderNumber;
    data['is_active'] = this.isActive;
    data['start_time'] = this.startTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['end_time'] = this.endTime;
    data['slug'] = this.slug;
    data['blog_id'] = this.blogId;
    data['title'] = this.title;
    data['meta_details'] = this.metaDetails;
    data['details'] = this.details;
    data['image'] = this.image;
    data['language_id'] = this.languageId;
    data['category'] = this.category;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
