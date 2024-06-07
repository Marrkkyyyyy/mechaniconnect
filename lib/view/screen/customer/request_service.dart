import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/controller/customer/customer_dashboard_controller.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/data/model/category_model.dart';
import 'package:mechaniconnect/data/model/service_model.dart';

class RequestService extends StatelessWidget {
  const RequestService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerDashboardController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: Form(
          key: controller.formstate,
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 15),
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 224, 224, 224),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Request Service",
                      style: TextStyle(
                          color: AppColor.login2,
                          fontFamily: "Manrope",
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DropdownButtonFormField<CategoryModel>(
                    value: controller.selectedCategory,
                    validator: (val) {
                      if (val == null) {
                        return "Enter required field";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Vehicle Type",
                      hintText: "Choose vehicle type",
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      floatingLabelStyle: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.login2,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                      ),
                      hintStyle: TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 14,
                          color: Colors.black45),
                      isDense: true,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.login2),
                      ),
                      border: UnderlineInputBorder(),
                    ),
                    items: controller.categoryList
                        .map<DropdownMenuItem<CategoryModel>>(
                            (CategoryModel category) {
                      return DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Text(
                          category.category!,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              color: Colors.black87,
                              fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (CategoryModel? newValue) {
                      controller.selectedCategory = newValue;
                      controller.update();
                    },
                    style: const TextStyle(fontFamily: "Manrope"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: controller.vehicleName,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter required field";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(fontFamily: "Manrope"),
                    decoration: const InputDecoration(
                        counterText: "",
                        floatingLabelStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColor.login2),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Vehicle Name",
                        hintStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 14,
                            color: Colors.black45),
                        labelStyle:
                            TextStyle(fontFamily: "Manrope", fontSize: 18),
                        isDense: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.login2),
                        ),
                        border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: controller.vehicleModel,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter required field";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(fontFamily: "Manrope"),
                    decoration: const InputDecoration(
                        counterText: "",
                        floatingLabelStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColor.login2),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Vehicle Model",
                        hintStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 14,
                            color: Colors.black45),
                        labelStyle:
                            TextStyle(fontFamily: "Manrope", fontSize: 18),
                        isDense: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.login2),
                        ),
                        border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.registrationNumber,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter required field";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(fontFamily: "Manrope"),
                    decoration: const InputDecoration(
                        counterText: "",
                        floatingLabelStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColor.login2),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Registration Number",
                        hintStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 14,
                            color: Colors.black45),
                        labelStyle:
                            TextStyle(fontFamily: "Manrope", fontSize: 18),
                        isDense: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.login2),
                        ),
                        border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    value: controller.selectedRequestType,
                    validator: (val) {
                      if (val == null) {
                        return "Enter required field";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Request Type",
                      hintText: "Choose request type",
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      floatingLabelStyle: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.login2,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                      ),
                      hintStyle: TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 14,
                          color: Colors.black45),
                      isDense: true,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.login2),
                      ),
                      border: UnderlineInputBorder(),
                    ),
                    items: ['Emergency', 'Walk-in']
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              color: Colors.black87,
                              fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      controller.selectedRequestType = newValue;
                      controller.update();
                    },
                    style: const TextStyle(fontFamily: "Manrope"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.address,
                    maxLines: 3,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter required field";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(fontFamily: "Manrope"),
                    decoration: const InputDecoration(
                        counterText: "",
                        floatingLabelStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColor.login2),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Address",
                        hintStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 14,
                            color: Colors.black45),
                        labelStyle:
                            TextStyle(fontFamily: "Manrope", fontSize: 18),
                        isDense: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.login2),
                        ),
                        border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: controller.contact,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter required field";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(fontFamily: "Manrope"),
                    decoration: const InputDecoration(
                        counterText: "",
                        floatingLabelStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColor.login2),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Contact Number",
                        hintStyle: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 14,
                            color: Colors.black45),
                        labelStyle:
                            TextStyle(fontFamily: "Manrope", fontSize: 18),
                        isDense: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.login2),
                        ),
                        border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Services",
                    style: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 16,
                        color: AppColor.login3,
                        fontWeight: FontWeight.w600),
                  ),
                  Obx(() {
                    return Column(
                      children:
                          List.generate(controller.serviceList.length, (index) {
                        ServiceModel service = controller.serviceList[index];
                        return CheckboxListTile(
                          dense: true,
                          title: Text(
                            service.service!,
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          value: controller.selectedServices[index].value,
                          onChanged: (bool? value) {
                            controller.selectedServices[index].value =
                                value ?? false;
                          },
                        );
                      }),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      List<String> selectedServiceID = [];
                      for (int i = 0;
                          i < controller.selectedServices.length;
                          i++) {
                        if (controller.selectedServices[i].value == true) {
                          selectedServiceID
                              .add(controller.serviceList[i].serviceID!);
                        }
                      }

                      controller.validateInput(selectedServiceID);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.login2,
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: const Center(
                        child: Text(
                          "Request",
                          style: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
