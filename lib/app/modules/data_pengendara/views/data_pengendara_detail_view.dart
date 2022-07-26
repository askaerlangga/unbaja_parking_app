import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/data_pengendara/controllers/data_pengendara_controller.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/widgets/container_detail_pengendara_widget.dart';
import 'package:unbaja_parking_app/app/routes/app_pages.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

class DataPengendaraDetailView extends GetView<DataPengendaraController> {
  const DataPengendaraDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Data Pengendara'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: controller.getDataPengendara(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!.data() != null) {
            var dataPengguna = snapshot.data!.data()!;
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                ContainerDetailPengendara(
                  title: 'Nama : ',
                  middleText: dataPengguna['nama'],
                ),
                ContainerDetailPengendara(
                  title: 'Alamat : ',
                  middleText: dataPengguna['alamat'],
                ),
                ContainerDetailPengendara(
                  title: 'Nomor Telepon : ',
                  middleText: dataPengguna['nomor_telepon'],
                ),
                ContainerDetailPengendara(
                  title: 'Nomor Identitas : ',
                  middleText: dataPengguna['nomor_identitas'],
                ),
                ContainerDetailPengendara(
                  title: 'Status : ',
                  middleText: dataPengguna['status'],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    label: 'Ubah Data',
                    onPressed: () {
                      var data = [
                        dataPengguna['nama'],
                        dataPengguna['alamat'],
                        dataPengguna['nomor_telepon'],
                        dataPengguna['nomor_identitas'],
                        dataPengguna['status'],
                      ];
                      Get.toNamed(Routes.UBAH_DATA_PENGGUNA,
                          arguments: [Get.arguments, data]);
                    })
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
