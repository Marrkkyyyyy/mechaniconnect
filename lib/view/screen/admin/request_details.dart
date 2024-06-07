import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/controller/admin/request_details_controller.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/data/model/mechanic_model.dart';
import 'package:mechaniconnect/data/model/request_model.dart';
import 'package:mechaniconnect/view/widget/custom_confirmation_dialog.dart';
import 'package:mechaniconnect/view/widget/spacer_widget.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestDetailsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.login2,
        title: const Text(
          "Request Details",
          style: TextStyle(fontFamily: "Manrope"),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formstate,
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
                              Navigator.of(context).pop();
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
                const SpacerWidget(
                  height: 5,
                ),
                const SizedBox(
                  height: 6,
                ),
                controller.status == "4"
                    ? const SizedBox()
                    : Text(
                        controller.status == "2"
                            ? "Assigned Mechanic"
                            : "Assign Mechanic",
                        style: const TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.login3),
                      ),
                const SizedBox(
                  height: 8,
                ),
                controller.status == "4"
                    ? const SizedBox()
                    : controller.status == "2"
                        ? Text(
                            "— ${controller.requests.mechanicName!}",
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontFamily: "Manrope",
                                fontSize: 14,
                                color: AppColor.login2),
                          )
                        : DropdownButtonFormField<MechanicModel>(
                            value: controller.selectedMechanic,
                            validator: (val) {
                              if (val == null) {
                                return "Enter required field";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "Choose mechanic",
                              contentPadding: EdgeInsets.all(10),
                              floatingLabelStyle: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColor.login2,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 18,
                              ),
                              hintStyle: TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 14,
                                  color: Colors.black45),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.login2),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            items: controller.mechanicList
                                .map<DropdownMenuItem<MechanicModel>>(
                                    (MechanicModel mechanic) {
                              return DropdownMenuItem<MechanicModel>(
                                value: mechanic,
                                child: Text(
                                  mechanic.name!,
                                  style: const TextStyle(
                                      fontFamily: "Manrope",
                                      color: Colors.black87,
                                      fontSize: 16),
                                ),
                              );
                            }).toList(),
                            onChanged: (MechanicModel? newValue) {
                              controller.selectedMechanic = newValue;
                              controller.update();
                            },
                            style: const TextStyle(fontFamily: "Manrope"),
                          ),
                controller.status == "4"
                    ? const SizedBox()
                    : const SizedBox(
                        height: 4,
                      ),
                controller.status == "4"
                    ? const SizedBox()
                    : const Divider(
                        thickness: 1,
                        indent: 15,
                        endIndent: 15,
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
      ),
      bottomNavigationBar: controller.status == "4"
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
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  EasyLoading.showInfo("Request Cancelled by the Customer");
                },
                child: const Text("Cancelled",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Manrope",
                        color: Colors.white)),
              ),
            )
          : controller.status == "2"
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
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 1, 40),
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
                                    "The operation completed? This action cannot be undone once confirmed.",
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                                onConfirm: controller.completedRequest ==
                                        StatusRequest.loading
                                    ? () {}
                                    : () {
                                        Navigator.of(context).pop();
                                        controller.doneRequest();
                                      },
                                titleText: "Confirm Operation");
                          });
                    },
                    child: const Text("Done",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Manrope",
                            color: Colors.white)),
                  ),
                )
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
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 1, 40),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      backgroundColor: AppColor.login2,
                    ),
                    onPressed: () {
                      controller.validateInput(context);
                    },
                    child: const Text("Confirm",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Manrope",
                            color: Colors.white)),
                  ),
                ),
    );
  }
}
