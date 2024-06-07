import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveUser(Map<String, dynamic> userData) async {
    final String userJson = json.encode(userData);
    await sharedPreferences.setString('userData', userJson);
  }

  Map<String, dynamic>? getUser() {
    final String? userJson = sharedPreferences.getString('userData');
    if (userJson != null) {
      return json.decode(userJson);
    }
    return null;
  }

  Future<void> logout() async {
    await sharedPreferences.clear();
    Get.offAllNamed("/");
  }
}

initialServices() async {
  await Get.putAsync(() {
    return MyServices().init();
  });
}
