import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/core/functions/handling_data_controller.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/data/datasource/remote/admin/admin_data.dart';
import 'package:mechaniconnect/data/model/mechanic_model.dart';
import 'package:mechaniconnect/data/model/request_model.dart';
import 'package:mechaniconnect/view/widget/custom_confirmation_dialog.dart';

class RequestDetailsController extends GetxController {
  late ServiceRequestModel requests;
  late String status;
  late RxList<MechanicModel> mechanicList = RxList<MechanicModel>([]);
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest updateRequest = StatusRequest.none;
  StatusRequest completedRequest = StatusRequest.none;
  MechanicModel? selectedMechanic;
  AdminData adminRequest = AdminData(Get.find());

  validateInput(context) {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomConfirmationDialog(
                confirmTextColor: AppColor.login2,
                message: "Are you sure you want to confirm this request?",
                onCancel: () {
                  Navigator.of(context).pop();
                },
                onConfirm:updateRequest == StatusRequest.loading?(){}: () {
                  Navigator.of(context).pop();
                  confirmRequest(selectedMechanic!.mechanicID!);
                },
                titleText: "Confirm Request");
          });
    }
  }

  confirmRequest(String mechanicID) async {
    updateRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response =
        await adminRequest.confirmRequest(mechanicID, requests.requestID!);
    updateRequest = handlingData(response);
    if (StatusRequest.success == updateRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        Get.back(result: true);
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

  doneRequest() async {
    completedRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.doneRequest(requests.requestID!);
    completedRequest = handlingData(response);
    if (StatusRequest.success == completedRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        Get.back(result: "done");
      } else {
        showErrorMessage(response['message']);
      }
    } else if (completedRequest == StatusRequest.offlinefailure) {
      completedRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == completedRequest) {
      completedRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  @override
  void onInit() {
    status = Get.arguments?['status'];
    requests = Get.arguments?['servicerequest'];
    mechanicList = Get.arguments?['mechanics'];
    super.onInit();
  }
}
