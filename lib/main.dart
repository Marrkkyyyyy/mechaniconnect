import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/bindings/initial_bindings.dart';
import 'package:mechaniconnect/core/services/services.dart';
import 'package:mechaniconnect/routes.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Smart Grade Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: routes,
      builder: EasyLoading.init(),
    );
  }
}
