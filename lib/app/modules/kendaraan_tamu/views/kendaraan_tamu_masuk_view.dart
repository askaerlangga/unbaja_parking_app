import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/kendaraan_tamu/controllers/kendaraan_tamu_controller.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/custom_textfield.dart';

class KendaraanTamuMasukView extends GetView<KendaraanTamuController> {
  const KendaraanTamuMasukView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kendaraan Masuk'),
        centerTitle: true,
      ),
      body: ListView(padding: EdgeInsets.all(20), children: [
        SizedBox(
          width: Get.width,
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
                hint: const Text('Kendaraan'),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                value: controller.dropdownValue,
                items: controller.dropdownItems
                    .map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? value) {
                  controller.dropdownValue = value!;
                }),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            textCapitalization: TextCapitalization.characters,
            controller: controller.nomorPlat,
            labelText: 'Nomor Plat Kendaraan'),
        CustomTextField(
            controller: controller.merek, labelText: 'Merek Kendaraan'),
        CustomButton(
            label: 'PROSES',
            onPressed: () {
              controller.parkirMasuk();
            })
      ]),
    );
  }
}
