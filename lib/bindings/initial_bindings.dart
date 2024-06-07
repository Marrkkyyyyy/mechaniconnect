import 'package:get/get.dart';
import 'package:mechaniconnect/core/class/crud.dart';
import 'package:mechaniconnect/core/functions/global_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(GlobalController());
  }
}
