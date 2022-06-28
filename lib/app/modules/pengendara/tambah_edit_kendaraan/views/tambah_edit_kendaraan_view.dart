import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

import '../controllers/tambah_edit_kendaraan_controller.dart';

class TambahEditKendaraanView extends GetView<TambahEditKendaraanController> {
  const TambahEditKendaraanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Get.arguments[1] == 'Ubah Kendaraan') {
      controller.dropdownValue = Get.arguments[2];
      controller.merek.text = Get.arguments[3];
      controller.nomorPlat.text = Get.arguments[4];
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments[1]),
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
                label: Get.arguments[1],
                onPressed: () {
                  if (Get.arguments[1] == 'Tambah Kendaraan') {
                    controller.tambahKendaraan(
                        Get.arguments[0],
                        controller.dropdownValue!,
                        controller.merek.text,
                        controller.nomorPlat.text);
                  } else {
                    controller.ubahKendaraan(
                        Get.arguments[0],
                        controller.dropdownValue!,
                        controller.merek.text,
                        controller.nomorPlat.text);
                  }
                })
          ],
        ));
  }
}
