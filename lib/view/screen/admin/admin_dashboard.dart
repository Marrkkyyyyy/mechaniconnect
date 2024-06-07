import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/controller/admin/admin_dashboard_controller.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/core/constant/routes.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminDashboardController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              controller.logout();
            },
          )
        ],
        backgroundColor: AppColor.login2,
        title: const Text(
          "Dashboard",
          style: TextStyle(fontFamily: "Manrope"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnWidget(context, () {
              Get.toNamed(AppRoute.requestPage);
            }, "REQUESTS", Icons.assignment),
            const SizedBox(
              height: 10,
            ),
            btnWidget(context, () {
              Get.toNamed(AppRoute.servicePage);
            }, "SERVICES", Icons.build),
            const SizedBox(
              height: 10,
            ),
            btnWidget(context, () {
              Get.toNamed(AppRoute.categoryPage);
            }, "CATEGORIES", Icons.category),
            const SizedBox(
              height: 10,
            ),
            btnWidget(context, () {
              Get.toNamed(AppRoute.mechanicPage);
            }, "MECHANICS", Icons.person),
          ],
        ),
      ),
    );
  }

  Widget btnWidget(context, Function function, String text, IconData icon) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.8),
                spreadRadius: .3,
                blurRadius: 2,
                offset: const Offset(1, 3),
              ),
            ],
            color: AppColor.login3,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .14,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: Colors.white,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Manrope",
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        )),
      ),
    );
  }
}
