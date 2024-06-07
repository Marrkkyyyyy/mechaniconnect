import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/functions/handling_data_controller.dart';
import 'package:mechaniconnect/core/services/services.dart';
import 'package:mechaniconnect/data/datasource/remote/admin/admin_data.dart';
import 'package:mechaniconnect/data/datasource/remote/customer/customer_data.dart';
import 'package:mechaniconnect/data/model/mechanic_model.dart';
import 'package:mechaniconnect/data/model/request_model.dart';

class HistoryController extends GetxController {
  AdminData adminRequest = AdminData(Get.find());
  CustomerData customerRequest = CustomerData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  late RxList<MechanicModel> mechanicList = RxList<MechanicModel>([]);
  late RxList<ServiceRequestModel> requestList =
      RxList<ServiceRequestModel>([]);

  Future<void> refreshData() async {
    fetchHistory();
  }

  fetchHistory() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await adminRequest.fetchHistory();
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

  @override
  void onInit() {
    fetchHistory();
    super.onInit();
  }
}
