import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mechaniconnect/controller/admin/category_controller.dart';
import 'package:mechaniconnect/core/class/handling_view_request.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/core/constant/image_asset.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/data/model/category_model.dart';
import 'package:mechaniconnect/view/widget/custom_confirmation_dialog.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.login2,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Form(
                    key: controller.formstate,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 12),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Create Category",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: "Manrope",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: controller.categoryController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter required field";
                                } else {
                                  return null;
                                }
                              },
                              autofocus: true,
                              decoration: const InputDecoration(
                                  counterText: "",
                                  isDense: true,
                                  labelText: "Category",
                                  hintText: "Enter category",
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.login2),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 196, 196, 196),
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    child: const Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontFamily: "Manrope",
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: controller.addRequest ==
                                          StatusRequest.loading
                                      ? () {}
                                      : () {
                                          controller.validateInput();
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.login2,
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 30),
                                    child: const Center(
                                      child: Text(
                                        "Create",
                                        style: TextStyle(
                                            fontFamily: "Manrope",
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                );
              }).then((value) {
            if (value == true) {
              showSuccessMessage("Successfully Added", dismiss: false);
              controller.fetchCategory();
              controller.clearData();
            }
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColor.login2,
        title: const Text(
          "Categories",
          style: TextStyle(fontFamily: "Manrope"),
        ),
      ),
      body: GetBuilder<CategoryController>(builder: (controller) {
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
                    widget: controller.categoryList.isEmpty
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
                        : Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: List.generate(
                                  controller.categoryList.length, (index) {
                                CategoryModel category =
                                    controller.categoryList[index];
                                return GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .updateCategoryController
                                                      .text = category.category!;
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          child: Form(
                                                            key: controller
                                                                .updateFormstate,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 16,
                                                                      left: 16,
                                                                      right: 16,
                                                                      bottom:
                                                                          12),
                                                              child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      "Update Category",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontFamily:
                                                                              "Manrope",
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          16,
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          controller
                                                                              .updateCategoryController,
                                                                      validator:
                                                                          (val) {
                                                                        if (val!
                                                                            .isEmpty) {
                                                                          return "Enter required field";
                                                                        } else {
                                                                          return null;
                                                                        }
                                                                      },
                                                                      autofocus:
                                                                          true,
                                                                      decoration: const InputDecoration(
                                                                          counterText: "",
                                                                          isDense: true,
                                                                          labelText: "Category",
                                                                          hintText: "Enter category",
                                                                          border: OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.blue),
                                                                          )),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: const Color.fromARGB(255, 196, 196, 196), borderRadius: BorderRadius.circular(4)),
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                                                                            child:
                                                                                const Center(
                                                                              child: Text(
                                                                                "Cancel",
                                                                                style: TextStyle(fontFamily: "Manrope", fontSize: 16, color: Colors.black54),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              8,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap: controller.updateRequest == StatusRequest.loading
                                                                              ? () {}
                                                                              : () {
                                                                                  if (controller.updateCategoryController.text == category.category) {
                                                                                    Navigator.of(context).pop();
                                                                                  } else {
                                                                                    Navigator.of(context).pop();
                                                                                    controller.validateUpdateInput(category.categoryID!);
                                                                                  }
                                                                                },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: AppColor.login2, borderRadius: BorderRadius.circular(4)),
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                                                                            child:
                                                                                const Center(
                                                                              child: Text(
                                                                                "Update",
                                                                                style: TextStyle(fontFamily: "Manrope", fontSize: 16, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 16),
                                                  child: const Center(
                                                    child: Text(
                                                      "Update",
                                                      style: TextStyle(
                                                        fontFamily: "Manrope",
                                                        fontSize: 14,
                                                        color: AppColor.login2,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                height: 0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomConfirmationDialog(
                                                            confirmTextColor:
                                                                AppColor.login2,
                                                            message:
                                                                "Are you sure you want to change the availability?",
                                                            onCancel: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            onConfirm: controller
                                                                        .updateStatusRequest ==
                                                                    StatusRequest
                                                                        .loading
                                                                ? () {}
                                                                : () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    controller.updateStatus(
                                                                        category
                                                                            .categoryID!,
                                                                        category.status ==
                                                                                "1"
                                                                            ? "2"
                                                                            : "1");
                                                                  },
                                                            titleText:
                                                                "Change Availability");
                                                      });
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 16),
                                                  child: Center(
                                                    child: Text(
                                                      category.status == "1"
                                                          ? "Not Available"
                                                          : "Available",
                                                      style: const TextStyle(
                                                        fontFamily: "Manrope",
                                                        fontSize: 14,
                                                        color: AppColor.login3,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                height: 0,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomConfirmationDialog(
                                                            confirmTextColor:
                                                                AppColor.login2,
                                                            message:
                                                                "Are you sure you want to delete this category?",
                                                            onCancel: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            onConfirm: controller
                                                                        .deleteRequest ==
                                                                    StatusRequest
                                                                        .loading
                                                                ? () {}
                                                                : () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    controller.deleteCategory(
                                                                        category
                                                                            .categoryID!,
                                                                        "3");
                                                                  },
                                                            titleText:
                                                                "Delete Category");
                                                      });
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 16),
                                                  child: const Center(
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        fontFamily: "Manrope",
                                                        fontSize: 14,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 14, bottom: 22),
                                                  child: const Center(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        fontFamily: "Manrope",
                                                        fontSize: 14,
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        }).then((value) {
                                      if (value == true) {
                                        controller.categoryList.removeWhere(
                                            (element) =>
                                                element.categoryID ==
                                                category.categoryID);
                                        controller.update();
                                      } else if (value == "update") {
                                        showSuccessMessage(
                                            "Updated Successfully");
                                        controller.refreshData();
                                      } else if (value == "status") {
                                        showSuccessMessage(
                                            "Updated Successfully");
                                        controller.refreshData();
                                      }
                                    });
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: ListTile(
                                      trailing: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4)),
                                          color: category.status == "1"
                                              ? AppColor.login3
                                              : Colors.red,
                                        ),
                                        child: Text(
                                            category.status == "1"
                                                ? "Available"
                                                : "Not Available",
                                            style: const TextStyle(
                                                fontFamily: "Manrope",
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ),
                                      title: Text(category.category!,
                                          style: const TextStyle(
                                              fontFamily: "Manrope",
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                );
                              }),
                            ),
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
