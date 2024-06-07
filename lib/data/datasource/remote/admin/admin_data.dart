import 'package:mechaniconnect/core/class/crud.dart';
import 'package:mechaniconnect/link_api.dart';

class AdminData {
  Crud crud;
  AdminData(this.crud);

  // ********************* Mechanic

  fetchMechanic() async {
    var response = await crud.postData(AppLink.fetchMechanic, {});
    return response.fold((l) => l, (r) => r);
  }

  addMechanic(String name, String contact) async {
    var response = await crud.postData(AppLink.addMechanic, {
      "name": name,
      "contact": contact,
    });
    return response.fold((l) => l, (r) => r);
  }

  updateMechanic(String mechanicID, String name, String contact) async {
    var response = await crud.postData(AppLink.updateMechanic, {
      "mechanicID": mechanicID,
      "name": name,
      "contact": contact,
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteMechanic(String mechanicID) async {
    var response = await crud.postData(AppLink.deleteMechanic, {
      "mechanicID": mechanicID,
    });
    return response.fold((l) => l, (r) => r);
  }

  // ********************* Category

  fetchCategory() async {
    var response = await crud.postData(AppLink.fetchCategory, {});
    return response.fold((l) => l, (r) => r);
  }

  addCategory(String category) async {
    var response = await crud.postData(AppLink.addCategory, {
      "category": category,
    });
    return response.fold((l) => l, (r) => r);
  }

  updateCategory(String categoryID, String category) async {
    var response = await crud.postData(AppLink.updateCategory, {
      "categoryID": categoryID,
      "category": category,
    });
    return response.fold((l) => l, (r) => r);
  }

  manipulateCategoryStatus(String categoryID, String status) async {
    var response = await crud.postData(AppLink.manipulateCategoryStatus, {
      "categoryID": categoryID,
      "status": status,
    });
    return response.fold((l) => l, (r) => r);
  }

  // ********************* Service

  fetchService() async {
    var response = await crud.postData(AppLink.fetchService, {});
    return response.fold((l) => l, (r) => r);
  }

  addService(String service, String description) async {
    var response = await crud.postData(AppLink.addService, {
      "service": service,
      "description": description,
    });
    return response.fold((l) => l, (r) => r);
  }

  updateService(String serviceID, String service, String description) async {
    var response = await crud.postData(AppLink.updateService, {
      "serviceID": serviceID,
      "service": service,
      "description": description,
    });
    return response.fold((l) => l, (r) => r);
  }

  manipulateServiceStatus(String serviceID, String status) async {
    var response = await crud.postData(AppLink.manipulateServiceStatus, {
      "serviceID": serviceID,
      "status": status,
    });
    return response.fold((l) => l, (r) => r);
  }

  // ********************* Request

  fetchRequest() async {
    var response = await crud.postData(AppLink.fetchRequest, {});
    return response.fold((l) => l, (r) => r);
  }

   fetchHistory() async {
    var response = await crud.postData(AppLink.fetchHistory, {});
    return response.fold((l) => l, (r) => r);
  }

  confirmRequest(String mechanicID, String requestID) async {
    var response = await crud.postData(AppLink.confirmRequest,
        {"mechanicID": mechanicID, "requestID": requestID});
    return response.fold((l) => l, (r) => r);
  }

  doneRequest(String requestID) async {
    var response =
        await crud.postData(AppLink.doneRequest, {"requestID": requestID});
    return response.fold((l) => l, (r) => r);
  }
}
