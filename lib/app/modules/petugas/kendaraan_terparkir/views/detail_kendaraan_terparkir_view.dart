import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unbaja_parking_app/app/modules/petugas/kendaraan_terparkir/controllers/kendaraan_terparkir_controller.dart';

import '../../qrcode_scanner/widgets/container_detail_pengendara_widget.dart';

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
                    middleText: dataParkir['merek_kendaraan'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Nama Pengendara : ',
                    middleText: dataParkir['nama_pengendara'],
                  ),
                  ContainerDetailPengendara(
                    title: 'Masuk : ',
                    middleText:
                        DateFormat('dd-MM-yyyy, HH:mm').format(jamMasuk),
                  ),
                  ContainerDetailPengendara(
                      title: 'Petugas Masuk :',
                      middleText: dataParkir['petugas_masuk']),
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
