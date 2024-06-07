class ServiceModel {
  String? serviceID;
  String? service;
  String? description;
  String? status;

  ServiceModel({this.serviceID, this.service, this.description, this.status});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    serviceID = json['serviceID'].toString();
    service = json['service'].toString();
    description = json['description'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceID'] = serviceID;
    data['service'] = service;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}
