class EyePowerResponse {
  int success;
  String message;
  Data data;

  EyePowerResponse({this.success, this.message, this.data});

  EyePowerResponse.fromJson(Map<String, dynamic> json) {
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
  int id;
  int customerId;
  String prescription;
  String rxOdReSphere;
  String rxOdReCyi;
  String rxOdReAxis;
  String rxOdReAddv;
  String rxOsLeSphere;
  String rxOsLeCyi;
  String rxOsLeAxis;
  String rxOsLeAddv;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.customerId,
        this.prescription,
        this.rxOdReSphere,
        this.rxOdReCyi,
        this.rxOdReAxis,
        this.rxOdReAddv,
        this.rxOsLeSphere,
        this.rxOsLeCyi,
        this.rxOsLeAxis,
        this.rxOsLeAddv,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    prescription = json['prescription'];
    rxOdReSphere = json['rx_od_re_sphere'];
    rxOdReCyi = json['rx_od_re_cyi'];
    rxOdReAxis = json['rx_od_re_axis'];
    rxOdReAddv = json['rx_od_re_addv'];
    rxOsLeSphere = json['rx_os_le_sphere'];
    rxOsLeCyi = json['rx_os_le_cyi'];
    rxOsLeAxis = json['rx_os_le_axis'];
    rxOsLeAddv = json['rx_os_le_addv'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['prescription'] = this.prescription;
    data['rx_od_re_sphere'] = this.rxOdReSphere;
    data['rx_od_re_cyi'] = this.rxOdReCyi;
    data['rx_od_re_axis'] = this.rxOdReAxis;
    data['rx_od_re_addv'] = this.rxOdReAddv;
    data['rx_os_le_sphere'] = this.rxOsLeSphere;
    data['rx_os_le_cyi'] = this.rxOsLeCyi;
    data['rx_os_le_axis'] = this.rxOsLeAxis;
    data['rx_os_le_addv'] = this.rxOsLeAddv;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
