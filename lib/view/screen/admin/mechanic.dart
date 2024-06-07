import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mechaniconnect/controller/admin/mechanic_controller.dart';
import 'package:mechaniconnect/core/class/handling_view_request.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/core/constant/image_asset.dart';
import 'package:mechaniconnect/core/functions/show_message.dart';
import 'package:mechaniconnect/data/model/mechanic_model.dart';
import 'package:mechaniconnect/view/widget/custom_confirmation_dialog.dart';

class MechanicPage extends StatelessWidget {
  const MechanicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MechanicController());
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
                              "Create Mechanic",
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
                              controller: controller.fullName,
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
                                  labelText: "Full Name",
                                  hintText: "Enter Full Name",
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.login2),
                                  )),
                            ),
                            const SizedBox(
                              height: 16,
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
                              autofocus: true,
                              decoration: const InputDecoration(
                                  counterText: "",
                                  isDense: true,
                                  labelText: "Contact Number",
                                  hintText: "Enter contact number",
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
              controller.fetchMechanic();
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
          "Mechanics",
          style: TextStyle(fontFamily: "Manrope"),
        ),
      ),
      body: GetBuilder<MechanicController>(builder: (controller) {
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
                    widget: controller.mechanicList.isEmpty
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
                                  controller.mechanicList.length, (index) {
                                MechanicModel mechanic =
                                    controller.mechanicList[index];
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
                                                  controller.updateFullName
                                                      .text = mechanic.name!;
                                                  controller.updateContact
                                                      .text = mechanic.contact!;
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
                                                                      "Update Mechanic",
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
                                                                              .updateFullName,
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
                                                                          labelText: "Full Name",
                                                                          hintText: "Enter Full Name",
                                                                          border: OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.blue),
                                                                          )),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          16,
                                                                    ),
                                                                    TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .phone,
                                                                      controller:
                                                                          controller
                                                                              .updateContact,
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
                                                                          labelText: "Contact Number",
                                                                          hintText: "Enter contact number",
                                                                          border: OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: AppColor.login2),
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
                                                                                  if (controller.updateFullName.text == mechanic.name && controller.updateContact.text == mechanic.contact) {
                                                                                    Navigator.of(context).pop();
                                                                                  } else {
                                                                                    Navigator.of(context).pop();
                                                                                    controller.validateUpdateInput(mechanic.mechanicID!);
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
                                                                "Are you sure you want to delete this mechanic?",
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
                                                                    controller.deleteMechanic(
                                                                        mechanic
                                                                            .mechanicID!);
                                                                  },
                                                            titleText:
                                                                "Delete Mechanic");
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
                                        controller.mechanicList.removeWhere(
                                            (element) =>
                                                element.mechanicID ==
                                                mechanic.mechanicID);
                                        controller.update();
                                      } else if (value == "update") {
                                        showSuccessMessage(
                                            "Updated Successfully");
                                        controller.refreshData();
                                      }
                                    });
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: ListTile(
                                      subtitle: Text(mechanic.contact!),
                                      title: Text(mechanic.name!,
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
