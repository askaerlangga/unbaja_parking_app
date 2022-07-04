import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unbaja_parking_app/app/modules/petugas/kendaraan_terparkir/controllers/kendaraan_terparkir_controller.dart';

import '../../qrcode_scanner/container_detail_pengendara_widget.dart';

class DetailKendaraanTerparkirView
    extends GetView<KendaraanTerparkirController> {
  const DetailKendaraanTerparkirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Kendaraan Terparkir'),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: controller.getDataParkir(Get.arguments[0]),
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data?.data() != null) {
              var dataParkir = snapshot.data!.data();
              print(dataParkir);
              var jamMasuk = (dataParkir?['masuk'] as Timestamp).toDate();
              var durasi = DateTime.now()
                  .difference(jamMasuk)
                  .toString()
                  .split('.')[0]
                  .split(':');
              if (dataParkir?['pengendara'] == 'Tamu') {
                return ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    ContainerDetailPengendara(
                      title: 'Nomor Plat Kendaraan : ',
                      middleText: dataParkir!['nomor_plat'],
                    ),
                    ContainerDetailPengendara(
                      title: 'Jenis Kendaraan : ',
                      middleText: dataParkir['jenis_kendaraan'],
                    ),
                    ContainerDetailPengendara(
                      title: 'Merek Kendaraan : ',
                      middleText: dataParkir['merek'],
                    ),
                    ContainerDetailPengendara(
                      title: 'Nama Pengendara : ',
                      middleText: dataParkir['pengendara'],
                    ),
                    ContainerDetailPengendara(
                      title: 'Masuk : ',
                      middleText:
                          DateFormat('dd-MM-yyyy, HH:mm').format(jamMasuk),
                    ),
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: controller
                            .getDataPetugas(dataParkir['petugas_masuk']),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            var dataPetugas = snapshot.data!.data()!;
                            return ContainerDetailPengendara(
                                title: 'Petugas Masuk :',
                                middleText: dataPetugas['nama']);
                          }
                          return Text('');
                        }),
                    ContainerDetailPengendara(
                      title: 'Lama Parkir : ',
                      middleText: '${durasi[0]} Jam, ${durasi[1]} Menit',
                    ),
                  ],
                );
              }

              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  ContainerDetailPengendara(
                    title: 'Nomor Plat Kendaraan : ',
                    middleText: dataParkir!['nomor_plat'],
                  ),
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: controller.getDataKendaraan(Get.arguments[1]),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          var dataKendaraan = snapshot.data!.data();
                          return Column(
                            children: [
                              ContainerDetailPengendara(
                                title: 'Jenis Kendaraan : ',
                                middleText: dataKendaraan!['jenis_kendaraan'],
                              ),
                              ContainerDetailPengendara(
                                title: 'Merek Kendaraan : ',
                                middleText: dataKendaraan['merek_kendaraan'],
                              ),
                            ],
                          );
                        }
                        return const Text('');
                      }),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: controller
                          .getDataPengendara(dataParkir['pengendara']),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          var dataPengendara = snapshot.data!.data();
                          return ContainerDetailPengendara(
                            title: 'Nama Pengendara : ',
                            middleText: dataPengendara!['nama'],
                          );
                        }
                        return const Text('');
                      }),
                  ContainerDetailPengendara(
                    title: 'Masuk : ',
                    middleText:
                        DateFormat('dd-MM-yyyy, HH:mm').format(jamMasuk),
                  ),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: controller
                          .getDataPetugas(dataParkir['petugas_masuk']),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          var dataPetugas = snapshot.data!.data()!;
                          return ContainerDetailPengendara(
                              title: 'Petugas Masuk :',
                              middleText: dataPetugas['nama']);
                        }
                        return Text('');
                      }),
                  ContainerDetailPengendara(
                    title: 'Lama Parkir : ',
                    middleText: '${durasi[0]} Jam, ${durasi[1]} Menit',
                  ),
                ],
              );
            }
            return const Text('Tidak ada data');
          },
        ));
  }
}
