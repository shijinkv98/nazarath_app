class TrackOrderResponse {
  int success;
  String message;
  Data data;

  TrackOrderResponse({this.success, this.message, this.data});

  TrackOrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String trackingid;
  String courier;
  List<Timeline> timeline;

  Data({this.trackingid, this.courier, this.timeline});

  Data.fromJson(Map<String, dynamic> json) {
    trackingid = json['trackingid'];
    courier = json['courier'];
    if (json['timeline'] != null) {
      timeline = new List<Timeline>();
      json['timeline'].forEach((v) {
        timeline.add(new Timeline.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trackingid'] = this.trackingid;
    data['courier'] = this.courier;
    if (this.timeline != null) {
      data['timeline'] = this.timeline.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timeline {
  int id;
  int trackId;
  int timelineId;
  String timelineStatus;
  String description;
  int status;
  String createdAt;
  String updatedAt;
  Statushistory statushistory;
  List<Trackingstatus> trackingstatus;

  Timeline(
      {this.id,
        this.trackId,
        this.timelineId,
        this.timelineStatus,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.statushistory,
        this.trackingstatus});

  Timeline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackId = json['track_id'];
    timelineId = json['timeline_id'];
    timelineStatus = json['timeline_status'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statushistory = json['statushistory'] != null
        ? new Statushistory.fromJson(json['statushistory'])
        : null;
    if (json['trackingstatus'] != null) {
      trackingstatus = new List<Trackingstatus>();
      json['trackingstatus'].forEach((v) {
        trackingstatus.add(new Trackingstatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['track_id'] = this.trackId;
    data['timeline_id'] = this.timelineId;
    data['timeline_status'] = this.timelineStatus;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.statushistory != null) {
      data['statushistory'] = this.statushistory.toJson();
    }
    if (this.trackingstatus != null) {
      data['trackingstatus'] =
          this.trackingstatus.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statushistory {
  int id;
  int orderStatusId;
  int languageId;
  String statusText;
  String createdAt;
  String updatedAt;

  Statushistory(
      {this.id,
        this.orderStatusId,
        this.languageId,
        this.statusText,
        this.createdAt,
        this.updatedAt});

  Statushistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatusId = json['order_status_id'];
    languageId = json['language_id'];
    statusText = json['status_text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_status_id'] = this.orderStatusId;
    data['language_id'] = this.languageId;
    data['status_text'] = this.statusText;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Trackingstatus {
  int id;
  int trackId;
  int timelineId;
  String timelineStatus;
  String description;
  int status;
  String createdAt;
  String updatedAt;
  Statushistory statushistory;

  Trackingstatus(
      {this.id,
        this.trackId,
        this.timelineId,
        this.timelineStatus,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.statushistory});

  Trackingstatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackId = json['track_id'];
    timelineId = json['timeline_id'];
    timelineStatus = json['timeline_status'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statushistory = json['statushistory'] != null
        ? new Statushistory.fromJson(json['statushistory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['track_id'] = this.trackId;
    data['timeline_id'] = this.timelineId;
    data['timeline_status'] = this.timelineStatus;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.statushistory != null) {
      data['statushistory'] = this.statushistory.toJson();
    }
    return data;
  }
}
