import 'dart:convert';

import 'package:mechaniconnect/core/class/crud.dart';
import 'package:mechaniconnect/link_api.dart';

class CustomerData {
  Crud crud;
  CustomerData(this.crud);

  requestService(
    String userID,
    String vehicleType,
    String vehicleName,
    String vehicleModel,
    String registrationNumber,
    String requestType,
    String contact,
    String address,
    List<String> services,
  ) async {
    var response = await crud.postData(AppLink.requestService, {
      "userID": userID,
      "vehicleType": vehicleType,
      "vehicleName": vehicleName,
      "vehicleModel": vehicleModel,
      "registrationNumber": registrationNumber,
      "requestType": requestType,
      "contact": contact,
      "address": address,
      "services": json.encode(services),
    });
    return response.fold((l) => l, (r) => r);
  }

  fetchCustomerService() async {
    var response = await crud.postData(AppLink.fetchCustomerService, {});
    return response.fold((l) => l, (r) => r);
  }

  fetchCustomerCategory() async {
    var response = await crud.postData(AppLink.fetchCustomerCategory, {});
    return response.fold((l) => l, (r) => r);
  }

  fetchCustomerRequest(String userID) async {
    var response =
        await crud.postData(AppLink.fetchCustomerRequest, {"userID": userID});
    return response.fold((l) => l, (r) => r);
  }

   fetchCustomerHistory(String userID) async {
    var response =
        await crud.postData(AppLink.fetchCustomerHistory, {"userID": userID});
    return response.fold((l) => l, (r) => r);
  }

  fetchCustomerMechanic() async {
    var response = await crud.postData(AppLink.fetchCustomerMechanic, {});
    return response.fold((l) => l, (r) => r);
  }

  cancelRequest(String requestID) async {
    var response =
        await crud.postData(AppLink.cancelRequest, {"requestID": requestID});
    return response.fold((l) => l, (r) => r);
  }
}
