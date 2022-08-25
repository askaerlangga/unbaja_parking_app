import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';
import 'package:unbaja_parking_app/app/widgets/custom_textfield.dart';

import '../controllers/ubah_data_kendaraan_controller.dart';

class UbahDataKendaraanView extends GetView<UbahDataKendaraanController> {
  const UbahDataKendaraanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.dropdownValue = Get.arguments[1];
    controller.merek.text = Get.arguments[2];
    controller.nomorPlat.text = Get.arguments[3];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ubah Data Kendaraan'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(
              width: Get.width,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                    hint: const Text('Kendaraan'),
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
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
            TextField(
              controller: controller.merek,
              decoration: const InputDecoration(
                hintText: 'Contoh : Honda Beat, Toyota Yaris',
                labelText: 'Merek',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.nomorPlat,
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                FilteringTextInputFormatter.deny(' '),
              ],
              decoration: const InputDecoration(
                  labelText: 'Nomor Plat', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                label: 'Ubah Kendaraan',
                onPressed: () {
                  controller.ubahKendaraan(
                      Get.arguments[0],
                      controller.dropdownValue!,
                      controller.merek.text,
                      controller.nomorPlat.text);
                })
          ],
        ));
  }
}
