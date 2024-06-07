import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/functions/handling_data_controller.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/core/services/services.dart';
import 'package:mechaniconnect/data/datasource/remote/admin/admin_data.dart';
import 'package:mechaniconnect/data/model/service_model.dart';

class ServiceController extends GetxController {
  late TextEditingController serviceController,
      descriptionController,
      updateServiceController,
      updateDescriptionController;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  GlobalKey<FormState> updateFormstate = GlobalKey<FormState>();
  AdminData adminRequest = AdminData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest addRequest = StatusRequest.none;
  StatusRequest deleteRequest = StatusRequest.none;
  StatusRequest updateRequest = StatusRequest.none;
  StatusRequest updateStatusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  late RxList<ServiceModel> serviceList = RxList<ServiceModel>([]);

  Future<void> refreshData() async {
    await fetchService();
  }

  clearData() {
    serviceController.clear();
    descriptionController.clear();
  }

  fetchService() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await adminRequest.fetchService();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['service'];
        List<ServiceModel> services =
            result.map((data) => ServiceModel.fromJson(data)).toList();
        services.sort((a, b) => a.service!.compareTo(b.service!));
        serviceList.assignAll(services.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  addService() async {
    addRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.addService(
        serviceController.text, descriptionController.text);
    addRequest = handlingData(response);
    if (StatusRequest.success == addRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        Get.back(result: true);
      } else {
        showErrorMessage(response['message']);
      }
    } else if (addRequest == StatusRequest.offlinefailure) {
      addRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == addRequest) {
      addRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  updateService(String serviceID) async {
    updateRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.updateService(serviceID,
        updateServiceController.text, updateDescriptionController.text);
    updateRequest = handlingData(response);
    if (StatusRequest.success == updateRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        Get.back(result: "update");
      } else {
        showErrorMessage(response['message']);
      }
    } else if (updateRequest == StatusRequest.offlinefailure) {
      updateRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == updateRequest) {
      updateRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  deleteService(String serviceID, String status) async {
    deleteRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response =
        await adminRequest.manipulateServiceStatus(serviceID, status);
    deleteRequest = handlingData(response);
    if (StatusRequest.success == deleteRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        Get.back(result: true);
      } else {
        showErrorMessage(response['message']);
      }
    } else if (deleteRequest == StatusRequest.offlinefailure) {
      deleteRequest = StatusRequest.none;
      showErrorMessage(response['message']);
    } else if (StatusRequest.serverfailure == deleteRequest) {
      deleteRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  updateStatus(String serviceID, String status) async {
    updateStatusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response =
        await adminRequest.manipulateServiceStatus(serviceID, status);
    updateStatusRequest = handlingData(response);
    if (StatusRequest.success == updateStatusRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        Get.back(result: "status");
      } else {
        showErrorMessage(response['message']);
      }
    } else if (updateStatusRequest == StatusRequest.offlinefailure) {
      updateStatusRequest = StatusRequest.none;
      showErrorMessage(response['message']);
    } else if (StatusRequest.serverfailure == updateStatusRequest) {
      updateStatusRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  validateInput() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      addService();
    }
  }

  validateUpdateInput(String serviceID) {
    var formData = updateFormstate.currentState;
    if (formData!.validate()) {
      updateService(serviceID);
    }
  }

  @override
  void onInit() {
    fetchService();
    serviceController = TextEditingController();
    descriptionController = TextEditingController();
    updateServiceController = TextEditingController();
    updateDescriptionController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    serviceController.dispose();
    descriptionController.dispose();
    updateServiceController.dispose();
    updateDescriptionController.dispose();
    super.dispose();
  }
}
