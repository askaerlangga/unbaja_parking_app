import 'package:cloud_firestore/cloud_firestore.dart';
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
      controller.jenisKendaraanValue.value = Get.arguments[2];
      controller.merekKendaraanValue.value = Get.arguments[3];
      controller.modelValue.value = Get.arguments[4];
      controller.warna.text = Get.arguments[5];
      controller.nomorPlat.text = Get.arguments[6];
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments[1]),
          centerTitle: true,
        ),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: controller.getJenisKendaraan(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              var data = snapshot.data!.docs;
              controller.dataMobil = data[0].data();
              controller.dataMotor = data[1].data();

              if (Get.arguments[1] == 'Tambah Kendaraan') {
                controller.jenisKendaraanValue.value =
                    controller.jenisKendaraanItems[0];
              } else {
                if (controller.jenisKendaraanValue.value == 'Sepeda Motor') {
                  controller.merekKendaraanItems.value = controller.dataMotor;
                } else {
                  controller.merekKendaraanItems.value = controller.dataMobil;
                }

                controller.modelItems.value = controller
                    .merekKendaraanItems[controller.merekKendaraanValue.value];

                if (controller.modelItems
                        .contains(controller.modelValue.value) ==
                    false) {
                  controller.modelItems.add('Lainnya');
                  controller.modelValue.value = 'Lainnya';
                  controller.modelLainnya.text = Get.arguments[4];
                }
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: <Widget>[
                  // Jenis Kendaraan
                  SizedBox(
                    width: Get.width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                          hint: const Text('Jenis Kendaraan'),
                          decoration: const InputDecoration(
                              labelText: 'Jenis Kendaraan',
                              border: OutlineInputBorder()),
                          value: controller.jenisKendaraanValue.value,
                          items: controller.jenisKendaraanItems
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? value) {
                            controller.jenisKendaraanValue.value = value!;

                            (controller.jenisKendaraanValue.value ==
                                    'Sepeda Motor')
                                ? controller.merekKendaraanItems.value =
                                    controller.dataMotor
                                : controller.merekKendaraanItems.value =
                                    controller.dataMobil;

                            controller.merekKendaraanValue.value =
                                controller.merekKendaraanItems.keys.first;

                            controller.modelItems.clear();
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Merek Kendaraan
                  Obx(
                    () => SizedBox(
                      width: Get.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                            hint: const Text('Merek Kendaraan'),
                            decoration: const InputDecoration(
                                labelText: 'Merek Kendaraan',
                                border: OutlineInputBorder()),
                            value: controller.merekKendaraanValue.value,
                            items: controller.merekKendaraanItems.keys
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (String? value) async {
                              controller.merekKendaraanValue.value = value!;
                              controller.modelItems.value = controller
                                  .merekKendaraanItems[value]
                                  .toList();

                              //     controller.tipe
                              controller.modelValue.value =
                                  controller.modelItems.first;
                              controller.modelItems.add('Lainnya');
                              print(controller.merekKendaraanItems[value]);
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Model
                  Obx(
                    () => SizedBox(
                      width: Get.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                            hint: const Text('Model'),
                            decoration: const InputDecoration(
                                labelText: 'Model',
                                border: OutlineInputBorder()),
                            value: controller.modelValue.value,
                            items: controller.modelItems
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (String? value) async {
                              controller.modelValue.value = value!;
                            }),
                      ),
                    ),
                  ),

                  // Model Lainnya
                  Obx(() {
                    if (controller.modelValue.value == 'Lainnya') {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: controller.modelLainnya,
                            decoration: const InputDecoration(
                              hintText: 'Tulis model lainnya',
                              labelText: 'Model Lainnya',
                              border: OutlineInputBorder(),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ],
                      );
                    }
                    return const SizedBox(
                      height: 0,
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),

                  // Dropdown
                  TextField(
                    controller: controller.warna,
                    decoration: const InputDecoration(
                      hintText: 'Contoh : Hitam, Putih',
                      labelText: 'Warna Kendaraan',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Nomor Plat kendaraan
                  TextField(
                    controller: controller.nomorPlat,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    decoration: const InputDecoration(
                        labelText: 'Nomor Plat Kendaraan',
                        hintText: 'Contoh : A1234BC',
                        border: OutlineInputBorder()),
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
                              controller.jenisKendaraanValue.value,
                              controller.merekKendaraanValue.value,
                              (controller.modelValue.value == 'Lainnya')
                                  ? controller.modelLainnya.text
                                  : controller.modelValue.value,
                              controller.warna.text,
                              controller.nomorPlat.text);
                        } else {
                          controller.ubahKendaraan(
                              Get.arguments[0],
                              controller.jenisKendaraanValue.value,
                              controller.merekKendaraanValue.value,
                              controller.nomorPlat.text);
                        }
                      })
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
