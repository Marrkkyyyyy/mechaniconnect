import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mechaniconnect/controller/customer/customer_dashboard_controller.dart';
import 'package:mechaniconnect/core/class/handling_view_request.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/core/constant/routes.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/data/model/category_model.dart';
import 'package:mechaniconnect/data/model/request_model.dart';
import 'package:mechaniconnect/data/model/service_model.dart';
import 'package:mechaniconnect/view/screen/customer/request_service.dart';
import 'package:mechaniconnect/view/widget/spacer_widget.dart';

class CustomerDashboard extends StatelessWidget {
  const CustomerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDashboardController());
    return Scaffold(
      body: GetBuilder<CustomerDashboardController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * .8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColor.login2,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    height: Get.width * .3,
                    width: Get.width,
                    child: SafeArea(
                        child: Stack(children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              controller.logout();
                            },
                            icon: const Icon(
                              Icons.exit_to_app_rounded,
                              color: Colors.white,
                            )),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Get.toNamed(AppRoute.customerHistoryPage);
                            },
                            icon: const Icon(
                              Icons.history,
                              color: Colors.white,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text("MECHANICONNECT",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontFamily: "Manrope",
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900))),
                      )
                    ])),
                  ),
                  controller.statusRequest == StatusRequest.success
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                  HandlingViewRequest(
                    statusRequest: controller.statusRequest,
                    widget: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.requestList.isEmpty
                              ? const SizedBox()
                              : const Text("Requests",
                                  style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black45)),
                          Column(
                            children: List.generate(
                                controller.requestList.length, (index) {
                              ServiceRequestModel request =
                                  controller.requestList[index];
                              DateTime originalDateTime =
                                  DateTime.parse(request.dateCreated!);
                              DateFormat format =
                                  DateFormat("E, MMM d, yyyy hh:mm a");
                              String formattedDate =
                                  format.format(originalDateTime);
                              return Card(
                                child: ListTile(
                                  onTap: () async {
                                    final res = await Get.toNamed(
                                        AppRoute.customerRequestDetails,
                                        arguments: {
                                          "status": request.status,
                                          "servicerequest": request,
                                        });

                                    if (res == true) {
                                      controller.fetchCustomerRequest();
                                    }
                                  },
                                  dense: true,
                                  title: Text(
                                    request.requestType!,
                                    style: const TextStyle(
                                        fontFamily: "Manrope",
                                        color: AppColor.login2,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    formattedDate,
                                    style: const TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                        color: request.status == "1"
                                            ? AppColor.orange
                                            : AppColor.login3),
                                    child: Text(
                                        request.status == "1"
                                            ? "Pending"
                                            : "Confirmed",
                                        style: const TextStyle(
                                            fontFamily: "Manrope",
                                            fontSize: 14,
                                            color: Colors.white)),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text("Categories",
                              style: TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45)),
                          const SizedBox(
                            height: 4,
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runAlignment: WrapAlignment.center,
                            spacing: 10,
                            children: List.generate(
                                controller.categoryList.length, (index) {
                              CategoryModel category =
                                  controller.categoryList[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                    color: AppColor.login3,
                                    borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                child: Text(category.category!,
                                    style: const TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 16,
                                        color: Colors.white)),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const SpacerWidget(
                            height: 6,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text("Services",
                              style: TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45)),
                          Column(
                            children: List.generate(
                                controller.serviceList.length, (index) {
                              ServiceModel service =
                                  controller.serviceList[index];
                              return Card(
                                elevation: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.service!,
                                        style: const TextStyle(
                                            fontFamily: "Manrope",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: AppColor.login3),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        service.description!,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            fontFamily: "Manrope"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar:
          GetBuilder<CustomerDashboardController>(builder: (controller) {
        return controller.statusRequest != StatusRequest.success
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(1, 0),
                      blurRadius: 5,
                      spreadRadius: 1.2,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 1, 40),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    backgroundColor: AppColor.login2,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const RequestService();
                        }).then((value) {
                      if (value == true) {
                        showSuccessMessage("Successfully Requested");
                        controller.fetchCustomerRequest();
                        controller.clearData();
                        controller.update();
                      }
                    });
                  },
                  child: const Text("Request",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Manrope",
                          color: Colors.white)),
                ),
              );
      }),
    );
  }
}
