class CategoryModel {
  String? categoryID;
  String? category;
  String? status;

  CategoryModel({this.categoryID, this.category, this.status});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'].toString();
    category = json['category'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryID'] = categoryID;
    data['category'] = category;
    data['status'] = status;
    return data;
  }
}
