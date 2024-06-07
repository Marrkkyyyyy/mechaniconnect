import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/controller/auth/login_controller.dart';
import 'package:mechaniconnect/core/constant/color.dart';
import 'package:mechaniconnect/core/constant/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
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
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(100))),
                  child: Stack(
                    children: <Widget>[
                      const Positioned(
                          bottom: 20,
                          right: 20,
                          child: Text(
                            "Login",
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
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
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
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            controller.login();
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
                              "Login",
                              style: TextStyle(
                                  fontFamily: "Manrope",
                                  fontSize: 20,
                                  color: Colors.white,
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
                            const Text('Don\'t have an account?',
                                style: TextStyle(
                                    fontFamily: "Manrope", fontSize: 16)),
                            const SizedBox(width: 5),
                            InkWell(
                              child: const Text('Register',
                                  style: TextStyle(
                                    color: AppColor.login3,
                                    fontSize: 16,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.bold,
                                  )),
                              onTap: () {
                                Get.toNamed(AppRoute.registerPage);
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
    );
  }
}
