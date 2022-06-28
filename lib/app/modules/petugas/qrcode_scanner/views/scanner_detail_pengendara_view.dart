import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/container_detail_pengendara_widget.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/controllers/qrcode_scanner_controller.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

class ScannerDetailPengendaraView extends GetView<QrcodeScannerController> {
  const ScannerDetailPengendaraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengendara'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: controller.getDataKendaraan(Get.arguments[0]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data?.data() != null) {
            var dataKendaraan = snapshot.data!.data() as Map<String, dynamic>;
            controller.idKendaraan = Get.arguments[0];
            controller.idPengendara = dataKendaraan['pemilik'];
            controller.idPetugas = Get.arguments[1];
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Column(children: [
                  ContainerDetailPengendara(
                      title: 'Nomor Plat Kendaraan :',
                      middleText: dataKendaraan['nomor_plat']),
                  ContainerDetailPengendara(
                      title: 'Jenis Kendaraan :',
                      middleText: dataKendaraan['jenis_kendaraan']),
                  ContainerDetailPengendara(
                      title: 'Merek Kendaraan :',
                      middleText: dataKendaraan['merek_kendaraan']),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: controller
                          .getDataPengendara(dataKendaraan['pemilik']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          var userData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return ContainerDetailPengendara(
                              title: 'Nama Pengendara :',
                              middleText: userData['nama']);
                        }
                        return const Text('');
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      label: 'PROSES',
                      onPressed: () {
                        controller.parkirMasuk();
                      })
                ])
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
