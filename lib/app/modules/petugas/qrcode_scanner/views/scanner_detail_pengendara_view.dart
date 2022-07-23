import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/widgets/container_detail_pengendara_widget.dart';
import 'package:unbaja_parking_app/app/modules/petugas/qrcode_scanner/controllers/qrcode_scanner_controller.dart';
import 'package:unbaja_parking_app/app/widgets/custom_button.dart';

class ScannerDetailPengendaraView extends GetView<QrcodeScannerController> {
  const ScannerDetailPengendaraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? active;
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
            // controller.idPengendara = dataKendaraan['pemilik'];
            controller.parkir.nomorPlat = dataKendaraan['nomor_plat'];
            controller.parkir.jenisKendaraan = dataKendaraan['jenis_kendaraan'];
            controller.parkir.merekKendaraan = dataKendaraan['merek_kendaraan'];
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
                          controller.parkir.namaPengendara = userData['nama'];
                          return ContainerDetailPengendara(
                              title: 'Nama Pengendara :',
                              middleText: userData['nama']);
                        }
                        return const Text('');
                      }),
                  FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: controller.getDataParkir(Get.arguments[0]),
                      builder: (context, snapshot) {
                        print('HEYYYY ${snapshot.data?.docs}');
                        if (snapshot.data != null &&
                            snapshot.data!.docs.isNotEmpty) {
                          var dataParkir = (snapshot.data!.docs[0]).data();
                          controller.idParkir =
                              (snapshot.data!.docs[0]).reference.id;
                          active = dataParkir['active'];
                          print('DATA PARKIR $dataParkir');
                          var jamMasuk =
                              (dataParkir['masuk'] as Timestamp).toDate();
                          var durasi = DateTime.now()
                              .difference(jamMasuk)
                              .toString()
                              .split('.')[0]
                              .split(':');

                          return Column(
                            children: [
                              ContainerDetailPengendara(
                                  title: 'Masuk :',
                                  middleText: DateFormat('dd-MM-yyyy, HH:mm')
                                      .format(jamMasuk)),
                              ContainerDetailPengendara(
                                  title: 'Petugas Masuk :',
                                  middleText: dataParkir['petugas_masuk']),
                              ContainerDetailPengendara(
                                  title: 'Lama Parkir :',
                                  middleText:
                                      '${durasi[0]} Jam, ${durasi[1]} Menit'),
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
                        if (active == null || active == false) {
                          controller.parkir.petugasMasuk = Get.arguments[1];
                          controller.parkirMasuk();
                        } else {
                          controller.parkir.petugasKeluar = Get.arguments[1];
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
