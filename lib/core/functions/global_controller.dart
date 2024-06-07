import 'package:get/get.dart';
import 'package:mechaniconnect/core/constant/routes.dart';
import 'package:mechaniconnect/core/services/services.dart';

class GlobalController extends GetxController {
  MyServices myServices = Get.find();
  String? userType;
  Future checkUser() async {
    userType = myServices.getUser()?["userType"].toString();
  }

  @override
  void onInit() {
    checkUser().whenComplete(() {
      if (userType == "1") {
        Get.offAllNamed(AppRoute.adminDashboard);
      } else if (userType == "2") {
        Get.offAllNamed(AppRoute.customerDashboard);
      }
    });

    super.onInit();
  }
}
