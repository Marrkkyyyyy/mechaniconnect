import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechaniconnect/core/constant/color.dart';

class CustomAuthTextfield extends StatelessWidget {
  const CustomAuthTextfield({
    super.key,
    required this.iconColor,
    required this.hidePassword,
    required this.labelText,
    required this.hinText,
    this.textEditingController,
    required this.valid,
    required this.icon,
    this.isObscure = false,
    this.isPassword = false,
    this.textInputType = TextInputType.name,
    this.textCapitalization = TextCapitalization.none,
    this.isEnabled = true,
  });
  final Rx<Color> iconColor;
  final RxBool hidePassword;
  final String labelText;
  final String hinText;
  final TextEditingController? textEditingController;
  final String? Function(String?) valid;
  final IconData icon;
  final bool isObscure;
  final bool isPassword;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Focus(
        onFocusChange: (hasFocus) {
          iconColor.value = hasFocus ? Colors.orange : Colors.grey;
        },
        child: TextFormField(
          enabled: isEnabled,
          validator: valid,
          controller: textEditingController,
          textCapitalization: textCapitalization,
          keyboardType: textInputType,
          obscureText: isPassword ? hidePassword.value : isObscure,
          style: const TextStyle(
              fontFamily: "Manrope", fontSize: 16, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            labelText: labelText,
            labelStyle: const TextStyle(
                fontFamily: "Manrope", fontWeight: FontWeight.w400),
            floatingLabelStyle: const TextStyle(
                fontFamily: "Manrope",
                fontWeight: FontWeight.w400,
                color: Colors.grey),
            hintText: hinText,
            hintStyle: const TextStyle(
                fontFamily: "Manrope", fontWeight: FontWeight.w400),
            prefixIcon: Icon(
              icon,
              color: iconColor.value,
              size: 22,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      hidePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: iconColor.value,
                    ),
                    onPressed: () {
                      hidePassword.value = !hidePassword.value;
                    },
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColor.login1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade400, width: .5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade500, width: .8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
    });
  }
}
