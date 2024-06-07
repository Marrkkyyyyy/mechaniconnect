import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/functions/handling_data_controller.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/core/services/services.dart';
import 'package:mechaniconnect/data/datasource/remote/admin/admin_data.dart';
import 'package:mechaniconnect/data/model/mechanic_model.dart';

class MechanicController extends GetxController {
  late TextEditingController fullName, contact, updateFullName, updateContact;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  GlobalKey<FormState> updateFormstate = GlobalKey<FormState>();
  AdminData adminRequest = AdminData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest addRequest = StatusRequest.none;
  StatusRequest deleteRequest = StatusRequest.none;
  StatusRequest updateRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  late RxList<MechanicModel> mechanicList = RxList<MechanicModel>([]);

  Future<void> refreshData() async {
    await fetchMechanic();
  }

  clearData() {
    fullName.clear();
    contact.clear();
  }

  fetchMechanic() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await adminRequest.fetchMechanic();
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> result = response['mechanic'];
        List<MechanicModel> mechanics =
            result.map((data) => MechanicModel.fromJson(data)).toList();
        mechanics.sort((a, b) => a.name!.compareTo(b.name!));
        mechanicList.assignAll(mechanics.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  addMechanic() async {
    addRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.addMechanic(fullName.text, contact.text);
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

  updateMechanic(String mechanicID) async {
    updateRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.updateMechanic(
        mechanicID, updateFullName.text, updateContact.text);
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

  deleteMechanic(String mechanicID) async {
    deleteRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.deleteMechanic(mechanicID);
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

  validateInput() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      addMechanic();
    }
  }

  validateUpdateInput(String mechanicID) {
    var formData = updateFormstate.currentState;
    if (formData!.validate()) {
      updateMechanic(mechanicID);
    }
  }

  @override
  void onInit() {
    fetchMechanic();
    updateFullName = TextEditingController();
    updateContact = TextEditingController();
    fullName = TextEditingController();
    contact = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    updateFullName.dispose();
    updateContact.dispose();
    fullName.dispose();
    contact.dispose();
    super.dispose();
  }
}
