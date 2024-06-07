class ServiceRequestModel {
  String? requestID;
  String? userID;
  String? customerName;
  String? mechanicID;
  String? mechanicName;
  String? categoryID;
  String? requestType;
  String? contact;
  String? address;
  String? vehicleName;
  String? vehicleRegName;
  String? vehicleModel;
  String? status;
  String? dateCreated;
  String? category;
  List<ServiceItem> serviceItems;

  ServiceRequestModel({
    this.requestID,
    this.userID,
    this.customerName,
    this.mechanicID,
    this.mechanicName,
    this.categoryID,
    this.requestType,
    this.contact,
    this.address,
    this.vehicleName,
    this.vehicleRegName,
    this.vehicleModel,
    this.status,
    this.dateCreated,
    required this.category,
    required this.serviceItems,
  });

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    List<ServiceItem> serviceItemList = [];
    if (json['serviceItem'] != null) {
      serviceItemList = List<ServiceItem>.from(
          json['serviceItem'].map((item) => ServiceItem.fromJson(item)));
    }
    return ServiceRequestModel(
      requestID: json['requestID'].toString(),
      userID: json['userID'].toString(),
      customerName: json['CustomerName'].toString(),
      mechanicID: json['mechanicID']?.toString(),
      mechanicName: json['MechanicName']?.toString(),
      categoryID: json['categoryID'].toString(),
      requestType: json['requestType'].toString(),
      contact: json['contact'].toString(),
      address: json['address'].toString(),
      vehicleName: json['vehicleName'].toString(),
      vehicleRegName: json['vehicleRegName'].toString(),
      vehicleModel: json['vehicleModel'].toString(),
      status: json['status'].toString(),
      dateCreated: json['dateCreated'].toString(),
      category: json['category'].toString(),
      serviceItems: serviceItemList,
    );
  }
}

class ServiceItem {
  String? serviceID;
  String? service;

  ServiceItem({
    this.serviceID,
    this.service,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      serviceID: json['serviceID'].toString(),
      service: json['service'].toString(),
    );
  }
}
