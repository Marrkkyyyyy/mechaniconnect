import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/functions/handling_data_controller.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/core/services/services.dart';
import 'package:mechaniconnect/data/datasource/remote/admin/admin_data.dart';
import 'package:mechaniconnect/data/model/category_model.dart';

class CategoryController extends GetxController {
  late TextEditingController categoryController, updateCategoryController;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  GlobalKey<FormState> updateFormstate = GlobalKey<FormState>();
  AdminData adminRequest = AdminData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest addRequest = StatusRequest.none;
  StatusRequest deleteRequest = StatusRequest.none;
  StatusRequest updateRequest = StatusRequest.none;
  StatusRequest updateStatusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  late RxList<CategoryModel> categoryList = RxList<CategoryModel>([]);

  Future<void> refreshData() async {
    await fetchCategory();
  }

  clearData() {
    categoryController.clear();
  }

  fetchCategory() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await adminRequest.fetchCategory();
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

  addCategory() async {
    addRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.addCategory(categoryController.text);
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

  updateCategory(String categoryID) async {
    updateRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.updateCategory(
        categoryID, updateCategoryController.text);
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

  deleteCategory(String categoryID, String status) async {
    deleteRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.manipulateCategoryStatus(categoryID, status);
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

  updateStatus(String categoryID, String status) async {
    updateStatusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await adminRequest.manipulateCategoryStatus(categoryID, status);
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
      addCategory();
    }
  }

  validateUpdateInput(String mechanicID) {
    var formData = updateFormstate.currentState;
    if (formData!.validate()) {
      updateCategory(mechanicID);
    }
  }

  @override
  void onInit() {
    fetchCategory();
    categoryController = TextEditingController();
    updateCategoryController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    categoryController.dispose();
    updateCategoryController.dispose();
    super.dispose();
  }
}
