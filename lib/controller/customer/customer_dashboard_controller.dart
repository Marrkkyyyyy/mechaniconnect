import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/functions/handling_data_controller.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/core/services/services.dart';
import 'package:mechaniconnect/data/datasource/remote/customer/customer_data.dart';
import 'package:mechaniconnect/data/model/category_model.dart';
import 'package:mechaniconnect/data/model/request_model.dart';
import 'package:mechaniconnect/data/model/service_model.dart';

class CustomerDashboardController extends GetxController {
  MyServices myServices = Get.find();
  CustomerData customerRequest = CustomerData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest serviceRequest = StatusRequest.none;
  late RxList<ServiceModel> serviceList = RxList<ServiceModel>([]);
  late RxList<CategoryModel> categoryList = RxList<CategoryModel>([]);
  late RxList<ServiceRequestModel> requestList =
      RxList<ServiceRequestModel>([]);
  RxList<RxBool> selectedServices = RxList<RxBool>([]);
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CategoryModel? selectedCategory;
  String? selectedRequestType;
  String? userID;
  late TextEditingController vehicleName,
      vehicleModel,
      registrationNumber,
      contact,
      address;

  clearData() {
    selectedCategory = null;
    selectedRequestType = null;
    for (var service in selectedServices) {
      service.value = false;
    }
    vehicleName.clear();
    vehicleModel.clear();
    registrationNumber.clear();
    contact.clear();
    address.clear();
  }

  validateInput(List<String> selectedServiceID) {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      if (selectedServiceID.isEmpty) {
        showErrorMessage("Please select services");
      } else if (selectedCategory == null) {
        showErrorMessage("Please choose vehicle type");
      } else if (selectedRequestType == null) {
        showErrorMessage("Please choose request type");
      } else {
        requestService(selectedServiceID);
      }
    }
  }

  requestService(List<String> selectedServiceID) async {
    serviceRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await customerRequest.requestService(
        userID!,
        selectedCategory!.categoryID!,
        vehicleName.text,
        vehicleModel.text,
        registrationNumber.text,
        selectedRequestType!,
        contact.text,
        address.text,
        selectedServiceID);
    serviceRequest = handlingData(response);
    if (StatusRequest.success == serviceRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        Get.back(result: true);
      } else {
        showErrorMessage(response['message']);
      }
    } else if (serviceRequest == StatusRequest.offlinefailure) {
      serviceRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == serviceRequest) {
      serviceRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  logout() {
    myServices.logout();
  }

  Future<void> refreshData() async {
    fetchCustomerService();
    fetchCustomerCategory();
    fetchCustomerRequest();
  }

  fetchCustomerRequest() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await customerRequest.fetchCustomerRequest(userID!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['viewrequest'];
        List<ServiceRequestModel> requests =
            result.map((data) => ServiceRequestModel.fromJson(data)).toList();
        requests.sort((a, b) => a.dateCreated!.compareTo(b.dateCreated!));
        requestList.assignAll(requests.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  fetchCustomerService() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await customerRequest.fetchCustomerService();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['service'];
        List<ServiceModel> services =
            result.map((data) => ServiceModel.fromJson(data)).toList();
        services.sort((a, b) => a.service!.compareTo(b.service!));
        serviceList.assignAll(services.toList());
        selectedServices
            .assignAll(List.generate(services.length, (_) => false.obs));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  fetchCustomerCategory() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await customerRequest.fetchCustomerCategory();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['category'];
        List<CategoryModel> categories =
            result.map((data) => CategoryModel.fromJson(data)).toList();
        categories.sort((a, b) => a.category!.compareTo(b.category!));
        categoryList.assignAll(categories.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    vehicleName = TextEditingController();
    vehicleModel = TextEditingController();
    registrationNumber = TextEditingController();
    contact = TextEditingController();
    address = TextEditingController();
    fetchCustomerService();
    fetchCustomerCategory();
    fetchCustomerRequest();

    super.onInit();
  }

  @override
  void dispose() {
    vehicleName.dispose();
    vehicleModel.dispose();
    registrationNumber.dispose();
    contact.dispose();
    address.dispose();
    super.dispose();
  }
}
