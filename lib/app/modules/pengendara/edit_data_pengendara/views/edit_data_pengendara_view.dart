import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/custom_textfield.dart';

import '../controllers/edit_data_pengendara_controller.dart';

class EditDataPengendaraView extends GetView<EditDataPengendaraController> {
  const EditDataPengendaraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.arguments[2] != null) {
      controller.nama.text = Get.arguments[2];
      controller.alamat.text = Get.arguments[3];
      controller.nomorTelepon.text = Get.arguments[4];
      controller.nomorIdentitas.text = Get.arguments[5];
      controller.status.text = Get.arguments[6];
    }

    controller.alamat.text = '';
    controller.nomorTelepon.text = '';
    controller.nomorIdentitas.text = '';
    controller.status.text = '';
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments[0]),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomTextField(controller: controller.nama, labelText: 'Nama'),
          CustomTextField(controller: controller.alamat, labelText: 'Alamat'),
          CustomTextField(
              controller: controller.nomorTelepon, labelText: 'Nomor Telepon'),
          CustomTextField(
            controller: controller.nomorIdentitas,
            labelText: 'Nomor Identitas',
            enable: (Get.arguments[2] == null) ? true : false,
          ),
          FutureBuilder(
              future: Future.delayed(Duration.zero),
              builder: (context, _) {
                if (Get.arguments[2] == null) {
                  return SizedBox(
                    width: Get.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                          hint: const Text('Status'),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
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
                  );
                }
                return CustomTextField(
                  controller: controller.nomorIdentitas,
                  labelText: 'Nomor Identitas',
                  enable: false,
                );
              }),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              label: 'SELESAI',
              onPressed: () {
                controller.editDataPengendara(
                    Get.arguments[1],
                    controller.nama.text,
                    controller.alamat.text,
                    controller.nomorTelepon.text,
                    controller.nomorIdentitas.text,
                    (controller.status.text == '')
                        ? controller.dropdownValue.toString()
                        : controller.status.text);
              })
        ],
      ),
    );
  }
}
