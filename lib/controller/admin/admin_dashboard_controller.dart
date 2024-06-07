import 'package:get/get.dart';
import 'package:mechaniconnect/core/services/services.dart';

class AdminDashboardController extends GetxController {
  MyServices myServices = Get.find();

  logout() {
    myServices.logout();
  }

  
}
