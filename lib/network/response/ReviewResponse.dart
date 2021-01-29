class ReviewResponse {
  int success;
  String message;
  Reviews reviews;
  List<MyReview> myreview;
  int reviewscount;
  int ratingcount;
  int rating;

  ReviewResponse(
      {this.success,
        this.message,
        this.reviews,
        this.myreview,
        this.reviewscount,
        this.ratingcount,
        this.rating});

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    reviews =
    json['reviews'] != null ? new Reviews.fromJson(json['reviews']) : null;
    if (json['myreview'] != null) {
      myreview = new List<MyReview>();
      json['myreview'].forEach((v) {
        myreview.add(new MyReview.fromJson(v));
      });
    }
    reviewscount = json['reviewscount'];
    ratingcount = json['ratingcount'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.toJson();
    }
    if (this.myreview != null) {
      data['myreview'] = this.myreview.map((v) => v.toJson()).toList();
    }
    data['reviewscount'] = this.reviewscount;
    data['ratingcount'] = this.ratingcount;
    data['rating'] = this.rating;
    return data;
  }
}

class Reviews {
  int currentPage;
  List<Review> data;
  int from;
  int lastPage;
  String nextPageUrl;
  String path;
  String perPage;
  String prevPageUrl;
  int to;
  int total;

  Reviews(
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

  Reviews.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Review>();
      json['data'].forEach((v) {
        data.add(new Review.fromJson(v));
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
class Review {
  String name;
  int rating;
  String title;
  String comment;
  String reviewDate;

  Review({this.name, this.rating, this.title, this.comment, this.reviewDate});

  Review.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    title = json['title'];
    comment = json['comment'];
    reviewDate = json['review_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['comment'] = this.comment;
    data['review_date'] = this.reviewDate;
    return data;
  }
}
class MyReview {
  String name;
  int rating;
  String title;
  String comment;
  String reviewDate;

  MyReview({this.name, this.rating, this.title, this.comment, this.reviewDate});

  MyReview.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    title = json['title'];
    comment = json['comment'];
    reviewDate = json['review_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['comment'] = this.comment;
    data['review_date'] = this.reviewDate;
    return data;
  }
}
