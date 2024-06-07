import 'package:flutter/material.dart';

class CustomLoginRegisterButton extends StatelessWidget {
  const CustomLoginRegisterButton(
      {super.key,
      required this.function,
      required this.color,
      required this.size,
      required this.text});
  final Function function;
  final Color color;
  final double size;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: size,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: "Manrope",
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
