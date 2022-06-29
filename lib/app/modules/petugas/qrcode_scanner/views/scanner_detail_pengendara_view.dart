import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                  FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: controller.getDataParkir(controller.idKendaraan!),
                      builder: (context, snapshot) {
                        if (snapshot.data != null &&
                            snapshot.data!.docs.length > 0) {
                          var dataParkir = (snapshot.data!.docs[0]).data();
                          controller.idParkir =
                              (snapshot.data!.docs[0]).reference.id;
                          controller.active = dataParkir['active'];
                          print('DATA PARKIR $dataParkir');
                          var date = DateFormat('dd-MM-yyyy, HH:mm').format(
                              DateTime.parse((dataParkir['masuk'] as Timestamp)
                                  .toDate()
                                  .toString()));
                          return Column(
                            children: [
                              ContainerDetailPengendara(
                                  title: 'Masuk :', middleText: date),
                              FutureBuilder<
                                      DocumentSnapshot<Map<String, dynamic>>>(
                                  future: controller.getDataPetugas(
                                      dataParkir['petugas_masuk']),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      var dataPetugas = snapshot.data!.data()!;
                                      return ContainerDetailPengendara(
                                          title: 'Petugas Masuk :',
                                          middleText: dataPetugas['nama']);
                                    }
                                    return Text('');
                                  })
                            ],
                          );
                        }
                        return Text('');
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      label: 'PROSES',
                      onPressed: () {
                        if (controller.active == null ||
                            controller.active == false) {
                          controller.parkirMasuk();
                        } else {
                          controller.parkirKeluar(controller.idParkir!);
                        }
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
