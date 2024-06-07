import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/controller/auth/register_controller.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/core/functions/valid_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: controller.formstate,
            child: Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.39,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [AppColor.login1, AppColor.login3],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100))),
                    child: Stack(
                      children: <Widget>[
                        const Positioned(
                            bottom: 20,
                            right: 20,
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w600),
                            )),
                        Center(
                          child: Image.asset(
                            "images/display_logo.png",
                            height: 110,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: controller.fullName,
                            validator: (val) {
                              return validInput(val, "name");
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Full Name",
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter required field";
                              } else if (!val.isEmail) {
                                return "Enter valid email";
                              } else {
                                return null;
                              }
                            },
                            controller: controller.email,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: controller.password,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter required field";
                              } else if (val.length < 8) {
                                return "Password must be at least 8 characters long";
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: controller.statusRequest ==
                                    StatusRequest.loading
                                ? () {}
                                : () {
                                    controller.validateInput();
                                  },
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [AppColor.login1, AppColor.login3],
                                    end: Alignment.centerLeft,
                                    begin: Alignment.centerRight),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Already a member?',
                                  style: TextStyle(
                                      fontFamily: "Manrope", fontSize: 16)),
                              const SizedBox(width: 5),
                              InkWell(
                                child: const Text('Login',
                                    style: TextStyle(
                                      color: AppColor.login3,
                                      fontSize: 16,
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.bold,
                                    )),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
