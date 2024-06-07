import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/controller/customer/customer_request_details_controller.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/data/model/request_model.dart';
import 'package:mechaniconnect/view/widget/custom_confirmation_dialog.dart';

class CustomerRequestDetails extends StatelessWidget {
  const CustomerRequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerRequestDetailsController());
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
                decoration: BoxDecoration(
                    color: controller.status == "1"
                        ? AppColor.orange
                        : AppColor.login3,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Text(
                  controller.status == "1" ? "Pending" : "Confirmed",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Manrope", color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(
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
              controller.requests.mechanicID == null
                  ? const SizedBox()
                  : const SizedBox(
                      height: 8,
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
              const SizedBox(
                height: 4,
              ),
              const Divider(
                thickness: 1,
                indent: 15,
                endIndent: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
      bottomNavigationBar:
          GetBuilder<CustomerRequestDetailsController>(builder: (controller) {
        return controller.status == "1"
            ? Container(
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
                    backgroundColor: AppColor.login3,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomConfirmationDialog(
                              confirmTextColor: AppColor.login3,
                              message:
                                  "Are you sure you want to cancel your request?",
                              onCancel: () {
                                Navigator.of(context).pop();
                              },
                              onConfirm: controller.statusRequest ==
                                      StatusRequest.loading
                                  ? () {}
                                  : () {
                                      Navigator.of(context).pop();
                                      controller.cancelRequest();
                                    },
                              titleText: "Cancel Request");
                        });
                  },
                  child: const Text("Cancel Request",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Manrope",
                          color: Colors.white)),
                ),
              )
            : const SizedBox();
      }),
    );
  }
}
