import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/functions/handling_data_controller.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/data/datasource/remote/customer/customer_data.dart';
import 'package:mechaniconnect/data/model/request_model.dart';

class CustomerRequestDetailsController extends GetxController {
  late ServiceRequestModel requests;
  late String status;
  CustomerData customerRequest = CustomerData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    status = Get.arguments?['status'];
    requests = Get.arguments?['servicerequest'];
    super.onInit();
  }

  cancelRequest() async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading...", dismissOnTap: true);
    var response = await customerRequest.cancelRequest(requests.requestID!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      EasyLoading.dismiss();
      if (response['status'] == "success") {
        Get.back(result: true);
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
}
