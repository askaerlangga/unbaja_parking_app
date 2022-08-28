import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatelessWidget {
  String valueItems;
  final List items;
  final String hint;

  CustomDropdown(
      {Key? key,
      required this.valueItems,
      required this.items,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
            hint: Text(hint),
            decoration: const InputDecoration(border: OutlineInputBorder()),
            value: valueItems,
            items: items.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? value) {
              valueItems = value!;
              // controller.merekKendaraanActive.value = true;
            }),
      ),
    );
  }
}
