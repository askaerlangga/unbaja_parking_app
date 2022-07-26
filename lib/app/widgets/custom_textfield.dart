import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? prefixIcon;
  final bool? enable;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool obsecureText;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.labelText,
      this.prefixIcon,
      this.enable,
      this.keyboardType,
      this.textCapitalization = TextCapitalization.none,
      this.obsecureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        obscureText: obsecureText,
        textCapitalization: textCapitalization,
        controller: controller,
        enabled: enable,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            labelText: labelText,
            border: const OutlineInputBorder()),
      ),
    );
  }
}
