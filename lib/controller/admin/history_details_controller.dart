import 'package:get/get.dart';
import 'package:mechaniconnect/data/model/request_model.dart';

class HistoryDetailsController extends GetxController {
  late ServiceRequestModel requests;
  late String status;

  @override
  void onInit() {
    status = Get.arguments?['status'];
    requests = Get.arguments?['servicerequest'];
    super.onInit();
  }
}
