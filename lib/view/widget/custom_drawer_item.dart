import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem(
      {super.key,
      required this.icon,
      required this.text,
      required this.function,
      required this.color});
  final IconData icon;
  final String text;
  final Function() function;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 8,
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(fontFamily: "Manrope", fontSize: 14),
      ),
      onTap: () {
        function();
      },
    );
  }
}
