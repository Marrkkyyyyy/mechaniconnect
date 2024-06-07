class MechanicModel {
  String? mechanicID;
  String? name;
  String? contact;
  String? status;
  String? dateCreated;

  MechanicModel(
      {this.mechanicID,
      this.name,
      this.contact,
      this.status,
      this.dateCreated});

  MechanicModel.fromJson(Map<String, dynamic> json) {
    mechanicID = json['mechanicID'].toString();
    name = json['name'].toString();
    contact = json['contact'].toString();
    status = json['status'].toString();
    dateCreated = json['dateCreated'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanicID'] = mechanicID;
    data['name'] = name;
    data['contact'] = contact;
    data['status'] = status;
    data['dateCreated'] = dateCreated;
    return data;
  }
}
