import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog(
      {super.key,
      required this.message,
      required this.onCancel,
      required this.onConfirm,
      this.cancelText = "Cancel",
      this.confirmText = "Confirm",
      this.confirmTextColor = Colors.teal,
      required this.titleText});
  final String message;
  final String cancelText;
  final String confirmText;
  final String titleText;
  final Color confirmTextColor;
  final Function() onCancel;
  final Function() onConfirm;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        color: const Color.fromARGB(255, 243, 243, 243),
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 0,
            ),
            SizedBox(
              height: size.height * .055,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      onCancel();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          cancelText,
                          style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 16,
                              color: Colors.black54),
                        ),
                      ),
                    ),
                  )),
                  const VerticalDivider(
                    thickness: 1,
                    width: 0,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      onConfirm();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(confirmText,
                            style: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 16,
                                color: confirmTextColor,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
