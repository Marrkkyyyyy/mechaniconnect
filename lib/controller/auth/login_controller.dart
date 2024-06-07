import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/routes.dart';
import 'package:mechaniconnect/core/functions/handling_data_controller.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/core/services/services.dart';
import 'package:mechaniconnect/data/datasource/remote/auth/auth.dart';

class LoginController extends GetxController {
  late TextEditingController email, password;
  AuthData authRequest = AuthData(Get.find());
  MyServices myServices = Get.find();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;

  Future<void> loginNavigatge(
      Map<String, dynamic> response, String dashboardRoute) async {
    final Map<String, dynamic> userData = response['userData'];
    userData['userType'] = response['userType'];
    await myServices.saveUser(userData);
    Get.offAllNamed(dashboardRoute);
  }

  login() async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await authRequest.login(email.text, password.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        if (response['userType'] == 1) {
          loginNavigatge(response, AppRoute.adminDashboard);
        } else if (response['userType'] == 2) {
          loginNavigatge(response, AppRoute.customerDashboard);
        }
      } else {
        showErrorMessage(response['message']);
      }
    } else if (statusRequest == StatusRequest.offlinefailure) {
      statusRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      statusRequest = StatusRequest.none;
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
      login();
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
