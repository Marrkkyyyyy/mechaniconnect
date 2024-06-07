import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mechaniconnect/controller/admin/history_controller.dart';
import 'package:mechaniconnect/core/class/handling_view_request.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/core/constant/image_asset.dart';
import 'package:mechaniconnect/core/constant/routes.dart';
import 'package:mechaniconnect/data/model/request_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.login2,
        title: const Text(
          "History",
          style: TextStyle(fontFamily: "Manrope"),
        ),
      ),
      body: GetBuilder<HistoryController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * .885),
              child: Column(
                children: [
                  controller.statusRequest == StatusRequest.success
                      ? const SizedBox()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                  HandlingViewRequest(
                    statusRequest: controller.statusRequest,
                    widget: controller.requestList.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .25,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    AppImageASset.empty,
                                    repeat: false,
                                    width: 150,
                                  ),
                                  const Text(
                                    "No Data Found",
                                    style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 18,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: List.generate(
                                controller.requestList.length, (index) {
                              ServiceRequestModel request =
                                  controller.requestList[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.historyDetails,
                                      arguments: {
                                        "status": request.status,
                                        "servicerequest": request,
                                      });
                                },
                                child: Card(
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    request.customerName!,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: "Manrope",
                                                        color:
                                                            AppColor.login2))),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        request.status! == "3"
                                                            ? AppColor.login1
                                                            : Colors.red,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 3),
                                                child: Text(
                                                  request.status! == "3"
                                                      ? "Completed"
                                                      : "Cancelled",
                                                  style: const TextStyle(
                                                      fontFamily: "Manrope",
                                                      color: Colors.white),
                                                ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(request.requestType!,
                                            style: const TextStyle(
                                                fontFamily: "Manrope",
                                                color: AppColor.login1,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
