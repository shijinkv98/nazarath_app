class NotificationResponse {
  int success;
  String message;
  List<Notifications> notifications;

  NotificationResponse({this.success, this.message, this.notifications});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int notificationId;
  int customerId;
  int deviceId;
  int status;
  String error;
  int read;
  int hide;
  String createdAt;
  String updatedAt;
  Notification notification;

  Notifications(
      {this.notificationId,
        this.customerId,
        this.deviceId,
        this.status,
        this.error,
        this.read,
        this.hide,
        this.createdAt,
        this.updatedAt,
        this.notification});

  Notifications.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    customerId = json['customer_id'];
    deviceId = json['device_id'];
    status = json['status'];
    error = json['error'];
    read = json['read'];
    hide = json['hide'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['customer_id'] = this.customerId;
    data['device_id'] = this.deviceId;
    data['status'] = this.status;
    data['error'] = this.error;
    data['read'] = this.read;
    data['hide'] = this.hide;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.notification != null) {
      data['notification'] = this.notification.toJson();
    }
    return data;
  }
}

class Notification {
  int id;
  int notificationFor;
  int notificationType;
  String typeValue;
  int status;
  String createdAt;
  String updatedAt;
  List<NotificationLanguages> languages;

  Notification(
      {this.id,
        this.notificationFor,
        this.notificationType,
        this.typeValue,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.languages});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationFor = json['notification_for'];
    notificationType = json['notification_type'];
    typeValue = json['type_value'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['languages'] != null) {
      languages = new List<NotificationLanguages>();
      json['languages'].forEach((v) {
        languages.add(new NotificationLanguages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notification_for'] = this.notificationFor;
    data['notification_type'] = this.notificationType;
    data['type_value'] = this.typeValue;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationLanguages {
  int id;
  int notificationId;
  int languageId;
  String title;
  String smallDescription;
  String bigDescription;
  String smallImage;
  String bigImage;
  String createdAt;
  String updatedAt;

  NotificationLanguages(
      {this.id,
        this.notificationId,
        this.languageId,
        this.title,
        this.smallDescription,
        this.bigDescription,
        this.smallImage,
        this.bigImage,
        this.createdAt,
        this.updatedAt});

  NotificationLanguages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationId = json['notification_id'];
    languageId = json['language_id'];
    title = json['title'];
    smallDescription = json['small_description'];
    bigDescription = json['big_description'];
    smallImage = json['small_image'];
    bigImage = json['big_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notification_id'] = this.notificationId;
    data['language_id'] = this.languageId;
    data['title'] = this.title;
    data['small_description'] = this.smallDescription;
    data['big_description'] = this.bigDescription;
    data['small_image'] = this.smallImage;
    data['big_image'] = this.bigImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
