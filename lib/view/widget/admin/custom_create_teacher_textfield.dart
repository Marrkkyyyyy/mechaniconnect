import 'package:flutter/material.dart';
import 'package:mechaniconnect/core/constant/color.dart';

class CustomCreateTeacherTextfield extends StatelessWidget {
  const CustomCreateTeacherTextfield(
      {super.key,
      required this.labelText,
      this.controller,
      required this.hintText,
      required this.icon,
      required this.valid,
      this.textCapitalization = TextCapitalization.none,
      this.textInputType = TextInputType.name,
      this.autoFocus = false});
  final String labelText;
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final String? Function(String?) valid;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final bool autoFocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      maxLength: 100,
      keyboardType: textInputType,
      textCapitalization: textCapitalization,
      validator: valid,
      controller: controller,
      style: const TextStyle(fontFamily: "Manrope"),
      decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(icon),
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          labelText: labelText,
          floatingLabelStyle:
              const TextStyle(fontFamily: "Manrope", color: AppColor.login2),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.login2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.login2, width: 1.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.login2),
          )),
    );
  }
}
