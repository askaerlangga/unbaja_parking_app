import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? prefixIcon;
  final bool? enable;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.labelText,
      this.prefixIcon,
      this.enable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        enabled: enable,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            labelText: labelText,
            border: const OutlineInputBorder()),
      ),
    );
  }
}
