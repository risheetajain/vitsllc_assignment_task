class TokenModel {
  final String id;
  final String tokenNo;
  final String jobNo;
  final String vehicleType;
  final String vehicleNumber;
  final String userMobile;
  final DateTime createdAt;
  final String status;
  final String service;
  final String serviceId;

  TokenModel(
      {required this.tokenNo,
      required this.jobNo,
      required this.vehicleType,
      required this.vehicleNumber,
      required this.createdAt,
      required this.status,
      required this.userMobile,
      required this.service,
      required this.serviceId,
      required this.id});

  static TokenModel fromJson(Map<String, dynamic> json) {
    return TokenModel(
        serviceId: json["service_id"] ?? "",
        service: json["service"] ?? "",
        status: json["status"] ?? "",
        tokenNo: json['token_no'],
        jobNo: json['job_no'],
        vehicleType: json['vehicle_type'],
        vehicleNumber: json['vehicle_number'],
        userMobile: json['user_mobile'],
        id: json["id"],
        createdAt: json["created_at"].toDate());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token_no'] = tokenNo;
    data['job_no'] = jobNo;
    data['vehicle_type'] = vehicleType;
    data['vehicle_number'] = vehicleNumber;
    data['user_mobile'] = userMobile;
    data['created_at'] = createdAt;
    data["status"] = status;
    data["service"] = service;
    data["service_id"] = serviceId;
    data["id"] = id;
    return data;
  }
}
