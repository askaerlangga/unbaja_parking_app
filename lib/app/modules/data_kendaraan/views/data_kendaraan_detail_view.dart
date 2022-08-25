import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/data_kendaraan/controllers/data_kendaraan_controller.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/widgets/container_detail_pengendara_widget.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

class DataKendaraanDetailView extends GetView<DataKendaraanController> {
  const DataKendaraanDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kendaraan Detail'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: controller.getDataKendaraan(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!.data() != null) {
            var dataKendaraan = snapshot.data!.data()!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                ContainerDetailPengendara(
                  title: 'Jenis Kendaraan : ',
                  middleText: dataKendaraan['jenis_kendaraan'],
                ),
                ContainerDetailPengendara(
                  title: 'Merek Kendaraan : ',
                  middleText: dataKendaraan['merek_kendaraan'],
                ),
                ContainerDetailPengendara(
                  title: 'Nomor Plat : ',
                  middleText: dataKendaraan['nomor_plat'],
                ),
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future:
                        controller.getDataPengendara(dataKendaraan['pemilik']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null) {
                        var userData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return ContainerDetailPengendara(
                            title: 'Pemilik Kendaraan :',
                            middleText: userData['nama']);
                      }
                      return const Text('');
                    }),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    label: 'Ubah Data',
                    onPressed: () {
                      Get.toNamed(Routes.UBAH_DATA_KENDARAAN, arguments: [
                        Get.arguments,
                        dataKendaraan['jenis_kendaraan'],
                        dataKendaraan['merek_kendaraan'],
                        dataKendaraan['nomor_plat']
                      ]);
                    }),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
