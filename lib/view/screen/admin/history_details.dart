import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/controller/admin/history_details_controller.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/data/model/request_model.dart';
import 'package:mechaniconnect/view/widget/spacer_widget.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryDetailsController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.login2,
          title: const Text(
            "Request Details",
            style: TextStyle(fontFamily: "Manrope"),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: const BoxDecoration(
                      color: AppColor.login2,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text(
                    controller.requests.customerName!,
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 22,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(controller.requests.address!,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              color: AppColor.login2,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 22,
                          color: AppColor.login2,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.requests.contact!,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              color: AppColor.login2,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: controller.requests.contact!));
                            },
                            child: const Icon(
                              Icons.copy,
                              size: 18,
                              color: AppColor.login2,
                            ))
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: const BoxDecoration(
                            color: AppColor.login3,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Text(
                          controller.requests.requestType!,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              color: Colors.white,
                              fontSize: 14),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                controller.requests.mechanicID == null
                    ? const SizedBox()
                    : const SpacerWidget(
                        height: 5,
                      ),
                controller.requests.mechanicID == null
                    ? const SizedBox()
                    : const SizedBox(
                        height: 5,
                      ),
                controller.requests.mechanicID == null
                    ? const SizedBox()
                    : const Text(
                        "Assigned Mechanic",
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.login3),
                      ),
                const SizedBox(
                  height: 3,
                ),
                controller.requests.mechanicID == null
                    ? const SizedBox()
                    : Text(
                        "— ${controller.requests.mechanicName!}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontFamily: "Manrope",
                            fontSize: 14,
                            color: AppColor.login2),
                      ),
                controller.requests.mechanicID == null
                    ? const SizedBox()
                    : const SizedBox(
                        height: 5,
                      ),
                const SpacerWidget(
                  height: 5,
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(118, 0, 0, 0)),
                      ),
                      Text(
                        controller.requests.category!,
                        style: const TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.login3),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Vehicle Name",
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(118, 0, 0, 0)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          controller.requests.vehicleName!,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.login3),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Registration Name",
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(118, 0, 0, 0)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .52,
                        child: Text(
                          controller.requests.vehicleRegName!,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.login3),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Model",
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(118, 0, 0, 0)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          controller.requests.vehicleModel!,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.login3),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: const BoxDecoration(
                      color: AppColor.login2,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Text("Services",
                      style: TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          controller.requests.serviceItems.length, (index) {
                        ServiceItem serviceItem =
                            controller.requests.serviceItems[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text("• ${serviceItem.service}",
                              style: const TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.login3)),
                        );
                      }),
                    ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
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
              backgroundColor:
                  controller.status == "3" ? AppColor.login1 : Colors.red,
            ),
            onPressed: () {
              controller.status == "3"
                  ? EasyLoading.showInfo(
                      "This request has been successfully completed.")
                  : EasyLoading.showInfo("Request Cancelled by the Customer");
            },
            child: Text(controller.status == "3" ? "Completed" : "Cancelled",
                style: const TextStyle(
                    fontSize: 16, fontFamily: "Manrope", color: Colors.white)),
          ),
        ));
  }
}
