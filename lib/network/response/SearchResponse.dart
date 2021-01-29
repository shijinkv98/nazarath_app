class SearchResponse {
  int success;
  String message;
  List<Products> products;

  SearchResponse({this.success, this.message, this.products});

  SearchResponse.fromJson(Map<String, dynamic> json) {
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
  String slug;
  String name;
  String type;

  Products({this.slug, this.name, this.type});

  Products.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
