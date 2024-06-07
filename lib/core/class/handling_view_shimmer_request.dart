import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mechaniconnect/core/class/status_request.dart';
import 'package:mechaniconnect/core/constant/image_asset.dart';

class HandlingShimmerViewRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final Widget shimmer;

  const HandlingShimmerViewRequest(
      {super.key,
      required this.statusRequest,
      required this.widget,
      required this.shimmer});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? shimmer
        : statusRequest == StatusRequest.offlinefailure
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(AppImageASset.offline,
                          repeat: false, width: 100, height: 80),
                      const Text(
                        "Currently Unavailable",
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            color: Colors.black54),
                      ),
                      const Text(
                        "Please check your internet connection and refresh the page",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 16,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
              )
            : statusRequest == StatusRequest.serverfailure
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            AppImageASset.server,
                            width: 200,
                          ),
                          const Text(
                            "Server Failure",
                            style: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 18,
                                color: Colors.black54),
                          ),
                          const Text(
                            "Please check your internet connection and refresh the page",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 16,
                                color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  )
                : statusRequest == StatusRequest.failure
                    ? Container(
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
                    : widget;
  }
}
